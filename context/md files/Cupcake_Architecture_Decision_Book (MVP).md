**Date:** 2025-11-12
**Scope:** MVP-level architecture decisions for *Cupcake* (couples-first mobile app). This document records the chosen stack, upgrade paths, backup/failover options, integration notes and MVP scalability guidance.

---
## 1 — Final chosen stack (MVP)
**Frontend**
- **Framework:** Flutter (iOS + Android)
- **State Management:** Riverpod
- **Local Storage:** Hive or Drift (offline-first)
- **Feature Modularity:** `/modules/sprinkles/<sprinkle_name>` folders

**Backend & Realtime**
- Supabase (Postgres) as primary platform: Auth, Realtime, Storage, Database
- Lightweight Node.js middleware (Express or NestJS) for:
  - AI proxying (OpenAI)
  - payments/webhooks orchestration (RevenueCat/Stripe)
  - custom business logic that shouldn't live in DB triggers

**Database & ORM**
- PostgreSQL (hosted via Supabase)
- Prisma ORM for type-safe DB schema & migrations

**Storage**
- Supabase Storage for photos, backups, and media
- Use signed URLs for secure access

**Authentication & Couple Linking**
- Supabase Auth (email, magic links, social OAuth later)
- Couple linking model: pairs created in DB; actions are scoped to a shared_space id

**Payments & Entitlements**
- RevenueCat for cross-platform in-app purchases and entitlement management
- Stripe server-side for any web / non-store purchases (if needed)

**Analytics**
- Lightweight metrics collected server-side for analytics (privacy-by-default — aggregate only)

**CI/CD & Hosting**
- Mobile builds: Staging & production channels
- Backend hosting: Render / Railway (small app-friendly hosts)
- Repo: GitHub (private)
- CI: GitHub Actions for backend + infra tasks

**Monorepo & Package Management**
- Monorepo (Turborepo or PNPM workspace)
- Packages:
  - apps/mobile (Flutter app)
  - apps/api (Node middleware)
  - packages/ui (shared Flutter UI components)
  - packages/core (shared types, event hooks, utility functions)
  - packages/sprinkles/* (each sprinkle as a package)

---
## 2 — Data & Integration Contracts (MVP)
Design all integrations around simple, clear contracts. Keep them versioned (v1, v2) and JSON/YAML-described.

**Shared space model (conceptual JSON):**
```json
{
  "pair_id": "pair_0123",
  "members": ["user_A", "user_B"],
  "addons": ["journal", "habit_tracker"],
  "calendar": {
    "events": []
  },
  "journal": {
    "entries": []
  },
  "trackers": {}
}
```

**Principles**
- Every shared action writes to a `pair-scoped` resource (not user-scoped) where appropriate.
- Individual privacy: each data element has a `visibility` flag (private/shared/calendar_visible).
- Event bus: emit domain events on key actions. Example events:
  - `journal.entry.created` → listeners: calendar, memory_timeline, backup
  - `habit.completed` → listeners: calendar, streak_service
- Version your API schemas and keep a small, single source-of-truth YAML in `/packages/core/contracts/`.
- All sprinkles must declare: inputs, outputs, and emitted events in a standard `sprinkle.json` manifest.

---
## 3 — Deployment & Dev Workflow (MVP)
**Local development**
- Use Flutter's hot reload and `flutter run` for local iteration.
- Use Supabase dev project with a seeded test dataset.
- Run Node middleware locally with `.env.local` for API keys (OpenAI key, RevenueCat webhook secret).

**Staging**
- A staging Supabase project, staging Node deploy (Railway/Render branch), and `staging` build channel.
- Connect test RevenueCat sandbox and test OpenAI usage limits.

**Production**
- Production Supabase project and production Node service.
- Production channel for mobile releases via the App Store / Play Store.
- Use secrets manager (EAS secrets / GitHub Secrets) for API keys and DB URLs.

---
## 4 — Backup, Failover & Upgrade Options (MVP + short-term upgrades)
**Database backups**
- Supabase provides Point-in-Time Recovery (PITR) options — enable daily logical backups and weekly full exports for MVP.
- Export DB snapshots to object storage (e.g., S3-compatible or Supabase Storage) as extra redundancy.

**Storage backups**
- Mirror critical media to a secondary bucket (S3 or another Supabase project) nightly.
- Keep retention policy (30–90 days) based on storage costs.

**Failover**
- App-level degrade plans:
  - If Supabase Realtime is slow: app falls back to polling the REST API for core sync.
  - If Node middleware fails: mobile app should still support read-only cached data and local journaling with queued sync when middleware returns.
- Monitor via monitoring service (LogDNA, Sentry, or Supabase logs). Set up alerts for errors and latency spikes.

**Upgrade Paths**
- Supabase → Dedicated Postgres on managed provider (Neon / AWS RDS) with read replicas and caching (Redis) if needed.
- Node middleware → Kubernetes-based deployment for autoscaling (if >100k users). Use Render → move to AWS ECS / EKS later.
- Storage → Cloudinary for heavy image optimization, CDN, and transformation features.
- Realtime → Move from Supabase Realtime to Kafka or a dedicated WebSocket layer for high-frequency presence/gaming.

---
## 5 — Security & Privacy (MVP)
**Guiding stance:** privacy-by-default. Minimal data collection and user control.
- Authentication: Supabase Auth with optional MFA later.
- Encryption: HTTPS for transport; Supabase encryption at rest (managed).
- Sensitive data: personal health or period data flagged and stored with stricter visibility defaults; provide easy deletion/export flows.
- Audit logs: maintain audit trails for shared actions at the `pair_id` level for troubleshooting (not for surveillance).
- Compliance: track requirements for GDPR/HIPAA if you plan health-related features that qualify — consult legal before pursuing HIPAA.

---
## 6 — Payments & License Model (MVP)
**Model:** Base app free and shared. Sprinkles are purchasable per couple.
**Implementation:** RevenueCat to handle in-app purchases and entitlement sync across platforms.
**Server checks:** Node middleware validates purchase receipts with RevenueCat and updates `pair_entitlements` in DB.
**One-time purchases:** store entitlements in DB with `purchase_id`, `purchaser_user_id`, and `expiry:null`.

---
## 7 — Sprinkles Engineering Guidelines (MVP)
Each sprinkle must follow strict packaging and integration rules.
**Package manifest (sprinkle.json) — required fields:**
```json
{
  "name": "habit-tracker",
  "version": "0.1.0",
  "inputs": ["pair_id", "user_id"],
  "outputs": ["events:habit_completed"],
  "optionalIntegrations": ["calendar", "dashboard"]
}
```
**Rules:**
- No sprinkle should directly mutate core tables. All writes must go through `core` service endpoints to enforce visibility rules.
- Each sprinkle is responsible for its own migrations under the monorepo's migration pipeline.
- Sprinkles must register event listeners during app bootstrap via `packages/core/events` API.

---
## 8 — Observability & Testing (MVP)
**Logging & Monitoring**
- Use Sentry for crash reporting (mobile + Node).
- Use basic metrics (Prometheus/Hosted equivalent) for API latency and error rates.
**Testing**
- Unit tests for core logic (Jest for Node, Flutter's built-in testing framework for mobile).
- Integration tests for event flows (e.g., habit_completed → calendar entry appears).
- E2E smoke tests using `flutter_driver` or Patrol.

---
## 9 — Developer Experience & AI Assistance
**Monorepo + developer tools**
- Use Turborepo / pnpm workspace to accelerate builds and local linking.
- Maintain a `/docs` folder with YAML contracts and sprinkle manifests.
**AI-assisted development**
- Create and freeze a `cupcake_dev_spec.yaml` that describes the stack, contracts and patterns.
- Build small AI agents (local scripts) that can scaffold new sprinkles using the `sprinkle.json` manifest and tests-first generation.
- Always generate tests alongside code to avoid hallucination drift.

---
## 10 — Next Action Items (MVP)
1. Initialize monorepo skeleton (Turborepo + pnpm).
2. Create Supabase dev + staging projects; configure Auth & Storage.
3. Scaffold Flutter app with basic auth flow and pair linking.
4. Implement core DB schema (pairs, users, journal, calendar, entitlements) and Prisma migrations.
5. Build Node middleware skeleton for AI proxy and payments webhook.
6. Create `sprinkle.json` manifest template and one sample sprinkle (Shared Journal).
7. Add CI (GitHub Actions) for tests and EAS build triggers.

---
## Appendix
- `packages/core/contracts/` should contain YAML definitions for all domain events and table schemas.
- Keep this document in repo root as `Cupcake_Architecture_Decision_Book.md` and update whenever major changes are decided.
