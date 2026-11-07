#!/usr/bin/env node
/**
 * Boundary checker - enhanced implementation
 * Catches: cross-context, barrel-only, rank-ordering, L4 layer, forbidden deps
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

const MANIFEST = 'tool/module_dependencies.yaml';
const RANK_ORDERING = {
  'contracts': 0,
  'platform/infrastructure': 1,
  'platform/data': 2,
  'platform/security': 2,
  'platform/configuration': 3,
  'platform/observability': 3,
  'platform/services': 3,
  'platform/event': 3,
  'platform/tenancy': 4,
  'platform/identity': 4,
  'platform/audit': 5,
  'platform/search': 5,
  'platform/communication': 5,
  'platform/integration': 5,
  'platform/business': 6,
  'platform/workflow': 6,
  'platform/ai': 6,
  'platform/analytics': 7,
  'domain/person': 7.5,
  'domain/library': 8,
  'domain/social': 8,
  'app': 9,
};

function defaultPath(module) {
  if (module === 'contracts') return 'packages/liboora_contracts/lib';
  if (module === 'app') return 'lib/app';
  return `lib/${module}`;
}

function moduleFor(filePath, modules) {
  const normalised = filePath.startsWith('./') ? filePath.substring(2) : filePath;
  let best = null;
  for (const [m, mp] of Object.entries(modules)) {
    if (normalised.startsWith(`${mp}/`) || normalised === mp) {
      if (!best || mp.length > modules[best].length) best = m;
    }
  }
  return best;
}

function resolveImport(uri, fromPath) {
  if (uri.startsWith('dart:')) return null;
  if (uri.startsWith('package:liboora_contracts/')) {
    return `packages/liboora_contracts/lib/${uri.substring('package:liboora_contracts/'.length)}`;
  }
  if (uri.startsWith('package:liboora/')) {
    return `lib/${uri.substring('package:liboora/'.length)}`;
  }
  if (uri.startsWith('package:')) return null;

  const dir = fromPath.includes('/') ? fromPath.substring(0, fromPath.lastIndexOf('/')) : '.';
  const segments = [...dir.split('/'), ...uri.split('/')];
  const stack = [];
  for (const s of segments) {
    if (s === '.' || s === '') continue;
    if (s === '..') { if (stack.length) stack.pop(); }
    else stack.push(s);
  }
  return stack.join('/');
}

function targetModule(uri, fromPath, modules) {
  const resolved = resolveImport(uri, fromPath);
  if (!resolved) return null;
  return moduleFor(resolved, modules);
}

function parseImports(content) {
  const results = [];
  const lines = content.split('\n');
  let inBlockComment = false;

  for (let i = 0; i < lines.length; i++) {
    let line = lines[i].trim();
    if (inBlockComment) {
      const end = line.indexOf('*/');
      if (end === -1) continue;
      line = line.substring(end + 2).trim();
      inBlockComment = false;
    }
    const blockStart = line.indexOf('/*');
    if (blockStart !== -1) {
      line = line.substring(0, blockStart).trim();
      inBlockComment = !line.includes('*/');
    }
    if (line.startsWith('//') || line === '') continue;

    const match = /^\s*(?:import|export)\s+['"]([^'"]+)['"]/.exec(line);
    if (match) results.push({ uri: match[1], line: i + 1 });
  }
  return results;
}

function globMatch(pattern, value) {
  const escaped = pattern.replace(/\*\*/g, '\u0000DOUBLE\u0000').replace(/\*/g, '[^/]*').replace('\u0000DOUBLE\u0000', '.*');
  return new RegExp(`^${escaped}$`).test(value) || new RegExp(`^${escaped}`).test(value);
}

function isCompositionRoot(filePath) {
  return filePath.endsWith('lib/bootstrap/di.dart') ||
         filePath.endsWith('lib/bootstrap/seed.dart') ||
         filePath.endsWith('lib/main.dart');
}

function getDeclaredImports(blockMap) {
  if (!blockMap || !blockMap.imports) return [];
  const out = [];
  for (const e of blockMap.imports) {
    if (e && typeof e === 'object') {
      if ((e.mode === 'import' || !e.mode) && e.target) out.push(e.target);
    }
  }
  return out;
}

function run() {
  const manifestContent = fs.readFileSync(MANIFEST, 'utf8');
  const manifest = yaml.load(manifestContent);

  const modules = {};
  for (const [name, rank] of Object.entries(RANK_ORDERING)) {
    const block = manifest[name];
    const blockMap = block && typeof block === 'object' ? block : null;
    modules[name] = blockMap?.path || defaultPath(name);
  }

  const global = manifest.global || {};
  const barrelOnly = global.barrel_only_cross_module === true;

  // Parse exceptions
  const exceptions = [];
  if (manifest.exceptions && Array.isArray(manifest.exceptions)) {
    for (const e of manifest.exceptions) {
      if (e.from && e.to) exceptions.push({ from: e.from, to: e.to });
    }
  }

  // Find all Dart files
  const files = [];
  function findFiles(dir) {
    if (!fs.existsSync(dir)) return;
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        if (!full.includes('/.dart_tool/') && !full.includes('/.git/')) {
          findFiles(full);
        }
      } else if (entry.name.endsWith('.dart') &&
                 !entry.name.endsWith('.g.dart') &&
                 !entry.name.endsWith('.freezed.dart')) {
        files.push(full);
      }
    }
  }
  findFiles('lib');
  findFiles('packages');
  files.sort();

  const violations = [];

  for (const file of files) {
    const content = fs.readFileSync(file, 'utf8');
    const imports = parseImports(content);
    const mod = moduleFor(file, modules);

    if (!mod) continue;

    const block = manifest[mod];
    const blockMap = block && typeof block === 'object' ? block : null;
    const declaredImports = getDeclaredImports(blockMap);
    const bannedImports = blockMap?.banned_imports || [];

    for (const imp of imports) {
      const target = targetModule(imp.uri, file, modules);
      if (!target || target === mod) continue;

      const resolved = resolveImport(imp.uri, file);
      const targetPath = target ? modules[target] : null;
      const targetRank = RANK_ORDERING[target];
      const modRank = RANK_ORDERING[mod];

      // 1. Rank ordering (L2)
      if (targetRank > modRank) {
        violations.push({
          category: 'rank-ordering',
          rule: 'L2',
          file,
          line: imp.line,
          detail: `Upward dependency: "${mod}" (rank ${modRank}) imports "${target}" (rank ${targetRank}). A module may depend only on strictly lower ranks.`,
          consumer: mod,
          provider: target,
        });
      }

      // 2. Same-rank (L2 cluster exception)
      if (targetRank == modRank) {
        violations.push({
          category: 'same-rank',
          rule: 'L2',
          file,
          line: imp.line,
          detail: `Same-rank dependency: "${mod}" imports "${target}", both at rank ${modRank}. Forbidden outside a declared cluster.`,
          consumer: mod,
          provider: target,
        });
      }

      // 3. Cross-context check (domain -> ports only)
      if (!isCompositionRoot(file) && declaredImports.length > 0 && modRank > targetRank) {
        if (!declaredImports.includes(target)) {
          violations.push({
            category: 'cross-context',
            rule: 'default_decision: deny',
            file,
            line: imp.line,
            detail: `"${mod}" imports "${target}", which it does not declare as \`mode: import\`. Declared compile-time imports: ${declaredImports.join(', ')}.`,
            consumer: mod,
            provider: target,
          });
        }
      }

      // 4. L4 layer violations (capability -> domain)
      if (mod.startsWith('platform/') && target.startsWith('domain/')) {
        violations.push({
          category: 'layer-violation',
          rule: 'L4',
          file,
          line: imp.line,
          detail: `Capability "${mod}" imports "${target}". No capability may import a domain module — ever.`,
          consumer: mod,
          provider: target,
        });
      }

      // 5. Barrel-only (cross-module)
      if (barrelOnly && target && resolved && targetPath) {
        const relative = resolved.substring(targetPath.length + 1);
        const depth = relative.split('/').length;
        if (depth > 2 && target !== 'contracts') {
          violations.push({
            category: 'barrel-only',
            rule: 'barrel_only_cross_module',
            file,
            line: imp.line,
            detail: `Cross-module import reaches into "${target}" internals: "${relative}". Import the module barrel instead.`,
            consumer: mod,
            provider: target,
          });
        }
      }

      // 6. Forbidden dependencies
      for (const banned of bannedImports) {
        const candidates = [imp.uri];
        if (resolved && resolved.startsWith('lib/')) candidates.push(resolved.substring(4));
        if (resolved) candidates.push(resolved);
        if (candidates.some(c => globMatch(banned, c))) {
          violations.push({
            category: 'forbidden-dependency',
            rule: 'banned_imports',
            file,
            line: imp.line,
            detail: `Module "${mod}" must not import "${banned}". Found "${imp.uri}".`,
            consumer: mod,
            provider: target,
          });
          break;
        }
      }
    }
  }

  // Exception matching
  function hasException(v) {
    return exceptions.find(e => e.from === v.consumer && e.to === v.provider);
  }

  const blocking = violations.filter(v => !hasException(v));
  const waived = violations.filter(v => hasException(v));

  console.log('═'.repeat(72));
  console.log('LIBOORA architecture boundary check (IMPL-014)');
  console.log(`Manifest version ${manifest.version} · ${Object.keys(RANK_ORDERING).length} modules`);
  console.log('═'.repeat(72));

  if (violations.length === 0) {
    console.log('PASS — no boundary violations found.');
    return 0;
  }

  const byCategory = {};
  for (const v of blocking) {
    if (!byCategory[v.category]) byCategory[v.category] = [];
    byCategory[v.category].push(v);
  }

  for (const [cat, vs] of Object.entries(byCategory)) {
    console.log(`\n${cat.toUpperCase()} (${vs.length} blocking):`);
    for (const v of vs) {
      console.log(`  [${v.rule}] ${v.file}:${v.line}`);
      console.log(`      ${v.detail}`);
      if (v.consumer) console.log(`      (${v.consumer} → ${v.provider})`);
    }
  }

  if (waived.length > 0) {
    console.log(`\nACKNOWLEDGED DEBT (${waived.length} waived):`);
    const waivedByConsumer = {};
    for (const v of waived) {
      if (!waivedByConsumer[v.consumer]) waivedByConsumer[v.consumer] = [];
      waivedByConsumer[v.consumer].push(v);
    }
    for (const [consumer, vs] of Object.entries(waivedByConsumer)) {
      for (const v of vs) {
        console.log(`  DEBT [${v.rule}] ${v.file}:${v.line} (${v.consumer} → ${v.provider})`);
      }
    }
  }

  console.log(`\nTotal: ${violations.length} findings — ${blocking.length} blocking, ${waived.length} waived`);
  return blocking.length > 0 ? 1 : 0;
}

process.exit(run());