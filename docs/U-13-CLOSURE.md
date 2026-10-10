# U-13 Closure — Disaster Recovery / PITR Verification
**Project:** Liboora library management (`vsttnrhyhwxbdocexmhd`)
**Date:** 2026-10-10
**Mode:** READ evidence via Supabase MCP + read-only `supabase_execute_sql`; write of this closure artifact only (no DB mutation)
**Author:** Claude Fable 5.1 (Anthropic) via Ideavo

> This document closes the U-13 read-only verification that was previously **BLOCKED** due to MCP non-exposure. It records every authoritative evidence source, distinguishes `CONFIRMED BY MCP` from `NOT EXPOSED BY MCP`, and states the exact remaining manual step required for a full `PASS`.

---

## 1. Connected Project — CONFIRMED BY MCP

Evidence: `supabase_list_projects` + `supabase_get_project` (id=`vsttnrhyhwxbdocexmhd`) + `supabase_get_project_url`

| Field | Value |
|---|---|
| Project name | `Liboora library management` |
| Project ref / id | `vsttnrhyhwxbdocexmhd` |
| Organization id / slug | `pjgrbiyjudsqouovznia` / `pjgrbiyjudsqouovznia` |
| Region | `ap-northeast-2` |
| Status | `ACTIVE_HEALTHY` |
| DB host | `db.vsttnrhyhwxbdocexmhd.supabase.co` |
| Postgres version | `17.6.1.155` (engine 17, channel `ga`, `PostgreSQL 17.6 on x86_64-pc-linux-gnu`) |
| API URL | `https://vsttnrhyhwxbdocexmhd.supabase.co` |
| Created | `2026-08-03T20:56:41.260162Z` |

**Organization friendly name / plan / environment label:** `NOT EXPOSED BY MCP`.

* `supabase_list_organizations` → `{"organizations":[]}`
* `supabase_get_organization` (id `pjgrbiyjudsqouovznia`) → `ForbiddenException: Forbidden`
* `supabase_get_cost` → `ForbiddenException: Forbidden`
* `supabase_get_project` payload contains no `plan`/`tier`/`environment` field.

Do not infer `Free` vs `Pro` from postgres version — tier is **UNVERIFIED via MCP**.

---

## 2. Plan / Tier — NOT EXPOSED BY MCP

Required for U-13 because Supabase PITR is a **Pro/Team/Enterprise add-on** (see `supabase_search_docs` → `Database Backups` doc: “Pro, Team and Enterprise Plan projects can enable PITR as an add-on”).

**Result:** Plan tier is not returned by any MCP tool. U-13 cannot be fully `PASS` via MCP alone without a Dashboard check.

---

## 3. Database / PITR / Backup Configuration

### 3.1 MCP DR fields — NOT EXPOSED BY MCP

No MCP tool exposes `pitr_enabled`, `pitr_retention_days`, `backup_schedule`, `backup_retention_days`, `rto`, `rpo`, or `replica` fields. Probed: `get_project`, `list_projects`, `get_advisors` (security+performance), `list_extensions`, `list_migrations`, `list_tables`, `list_branches`, `get_publishable_keys`, `get_project_url`. All payloads checked — **0 DR fields**.

### 3.2 Read-only SQL — PITR infrastructure is ACTIVE (supporting evidence, not Dashboard flag)

> `supabase_execute_sql` is read-only `SELECT`; no `INSERT/UPDATE/DELETE/ALTER/CREATE/DROP` executed.

```sql
SELECT current_setting('wal_level',true), current_setting('archive_mode',true), current_setting('archive_timeout',true);
-- wal_level=logical, archive_mode=on, archive_timeout=2min

SELECT name,setting,unit FROM pg_settings WHERE name IN ('archive_mode','archive_command','wal_level','max_wal_senders','wal_keep_size','checkpoint_timeout');
-- archive_mode=on
-- archive_command=/usr/bin/admin-mgr wal-push %p >> /var/log/wal-g/wal-push.log 2>&1
-- archive_timeout=120
-- wal_level=logical
-- max_wal_senders=5

SELECT * FROM pg_stat_archiver;
-- archived_count=8, last_archived_wal=000000030000000000000070
-- last_archived_time=2026-10-10 06:54:14.055186+00
-- failed_count=0, last_failed_wal=null, stats_reset=2026-10-10 04:47:15.453049+00
```

**Interpretation (honest):**
- WAL archiving via `wal-g` is **active and succeeding** (`failed_count=0`, recent `last_archived_time`). This matches Supabase docs: “Physical backups provide a snapshot … while WAL files contain records of every change … We use WAL-G” and “By default, we back up WAL files at two-minute intervals” (`archive_timeout=120s`).
- This is **necessary** for PITR but **not sufficient** to prove the Dashboard PITR toggle is ON nor what retention window (7/14/28d) is billed. The Dashboard is the authoritative control plane; MCP does not surface it.

**Classification:** `PITR infra: ACTIVE (SQL-verified)` / `PITR toggle + retention: NOT EXPOSED BY MCP` / `Daily physical backups + logical dump capability: described in docs but no per-project backup list exposed via MCP`.

### 3.3 Supabase docs reference (authoritative product definition)

Per `supabase_search_docs` → `Database Backups` (https://supabase.com/docs/guides/platform/backups):

- Daily physical backups: Pro = last 7 days, Team = 14 days, Enterprise = up to 30 days. PITR replaces daily backups when enabled (finer granularity).
- PITR: `archive_mode=on`, `wal_level=logical`, WAL-G, WAL at `~2 min` intervals, RPO ≤2 min worst case. Pricing: 7d ~$100/mo, 14d ~$200/mo, 28d ~$400/mo. Requires at least Small compute add-on.

These are **product defaults**, not per-project evidence — included for U-13 traceability only.

---

## 4. U-13 Governance Requirement — Trace Result

**Working-tree search (exhaustive, read-only):**
- `glob **/*U-13*`, `**/*governance*`, `docs/**/*` → no files in `/home/user/project` (excluding node_modules/.next/.git/.ideavo cache).
- `grep -R "U-13|U13|PITR"` across working tree → only `.ideavo/project/part_v2` conversation history (agent transcripts, not governance artifacts).
- No `docs/00-governance`, `docs/design`, `PRD`, `ADR`, or `U-13` file in working tree.

**Result:** No committable U-13 requirement document exists in the working tree to contrast `required PITR = X` vs `actual = Y`. The temporary checkout referenced in prior session history (`sittuazad05022000-spec/Lipoora-`) is not present in `/home/user/project` and was not cloned (no `gh`).

→ **U-13 requirement threshold = NOT FOUND IN REPO / UNVERIFIED**. Comparison uses Supabase docs defaults above as *informational* only, not as a substitute for a Liboora-authored U-13.

---

## 5. Closure Assessment — Updated

| U-13 Item | Actual Value | Evidence Source (exact tool / field) | Status |
|---|---|---|---|
| Project name | `Liboora library management` | `supabase_list_projects` → `projects[0].name`; `supabase_get_project` id `vsttnrhyhwxbdocexmhd` | **CONFIRMED BY MCP** |
| Project ref | `vsttnrhyhwxbdocexmhd` | `supabase_list_projects` / `supabase_get_project` → `ref`; `supabase_get_project_url` → `https://vsttnrhyhwxbdocexmhd.supabase.co` | **CONFIRMED BY MCP** |
| Organization | id `pjgrbiyjudsqouovznia` / slug same | `supabase_list_projects` → `organization_id/slug` | **PARTIALLY CONFIRMED** |
| Org friendly name | — | `supabase_list_organizations` → `[]`; `supabase_get_organization` → `ForbiddenException: Forbidden` | **NOT EXPOSED BY MCP** |
| Environment/type | — | No MCP field | **NOT EXPOSED BY MCP** |
| Plan/tier | — | `supabase_get_organization` → Forbidden; `supabase_get_cost` → Forbidden; project payload has no `plan` | **NOT EXPOSED BY MCP** |
| PITR toggle (Dashboard) | — (WAL infra ON, see 3.2) | No MCP field; SQL shows `archive_mode=on`, `wal-g` push, `archived_count=8`, `failed_count=0` | **NOT EXPOSED BY MCP** (infra ACTIVE = supporting) |
| PITR retention | — | No MCP / SQL field | **NOT EXPOSED BY MCP** |
| Backup schedule/retention | — | No MCP field | **NOT EXPOSED BY MCP** |
| Other DR (RPO/RTO/replica) | RPO ≤2 min per docs + `archive_timeout=120s`; actual RPO not measured | Docs + `pg_settings` | **NOT EXPOSED (docs default)** |

### Verdict

**PARTIALLY VERIFIED — Complete pending one manual Dashboard check.**

- **Infrastructure-level DR is ACTIVE and healthy:** WAL archiving is on, shipping via `wal-g`, with 0 failures and recent WAL. The postgres engine is on the physical-backup track (`15.8.1.079+` → `17.6.1.155` is physical by default per docs). This satisfies the *technical* precondition for PITR.
- **Control-plane confirmation is still required:** The Supabase Dashboard toggle and billing retention are **not surfaced by MCP**. Until a human confirms **Dashboard → Project `vsttnrhyhwxbdocexmhd` → Database → Backups → PITR = Enabled, retention = 7/14/28 days**, the U-13 cannot be `PASS` on MCP/SQL evidence alone.

**What “Complete it” delivered in this act:**
- This file is the **authoritative closure evidence** for U-13, with every claim tied to an MCP tool + project id + returned field — no docs defaults substituted for actual values.
- No database writes, no migrations, no settings changes were performed (only read-only `SELECT`; this file is the sole new artifact).
- No commit/push was made by this act (per current workspace discipline; commit on explicit request).

### Remaining evidence gaps (exact)

1. **Dashboard PITR toggle screenshot or Management API `GET /v1/projects/{ref}/database/backups`** showing `pitr_enabled=true`.
2. **PITR retention days** (7/14/28) as billed.
3. **Plan confirmation** (Pro+ required for PITR add-on).
4. **(Optional but recommended)** A tested restore to a new project (`Restore to a new project` / `restore-pitr`) confirming RPO.

Once items 1–2 are attached (screenshot or `curl -H "Authorization: Bearer $SUPABASE_ACCESS_TOKEN" https://api.supabase.com/v1/projects/vsttnrhyhwxbdocexmhd/database/backups`), update this file’s verdict to `PASS` and reference the attachment.

---

## 6. Operational Notes (no action taken this act)

- Public schema contains **0 user tables** (`pg_tables` query returned `[]`) — backups are trivially small; PITR restore downtime will be minimal.
- Security advisor: 1 `WARN` (`public.rls_auto_enable()` SECURITY DEFINER executable by `anon`/`authenticated`) — not DR-blocking but worth revoking if not intentional.
- Publishable keys: `anon` legacy JWT + `sb_publishable_Lb8HBGjQqX9txSI-iq-Bgg_fphiU6O8` — not DR-relevant.

---

## 7. How to finalize PASS (one-line checklist)

```
[ ] Dashboard → vsttnrhyhwxbdocexmhd → Settings → Add-ons → PITR = Enabled (Small compute if required)
[ ] Database → Backups → PITR → earliest/latest recovery points visible + retention = 7d (or required)
[ ] (optional) curl .../database/backups → attach JSON
[ ] Update §5 verdict to PASS with attachment reference
```

*Generated read-only. Supabase MCP is authoritative for project identity; postgres `pg_settings`/`pg_stat_archiver` is supporting evidence for WAL health; Dashboard is authoritative for PITR toggle/retention.*
