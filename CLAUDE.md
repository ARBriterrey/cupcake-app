# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Cupcake** is a couples-first mobile app for long-distance relationships built on a modular "Cupcake & Sprinkles" architecture where the base app (Cupcake) is always free and shared, while optional add-ons (Sprinkles) extend functionality.

**Current Status:** This is a skeleton project. Directory structure exists but core implementation is pending Phase 1 initialization.

## Architecture Philosophy

### Couple-Centric Data Model
All data and features are **pair-scoped** by default, not user-scoped. The core model revolves around:
- `pairs` table linking two users
- `pair_id` as the primary scope for shared actions
- `visibility` flags on data elements (private/shared/calendar_visible)

### Modular Sprinkle System
Each Sprinkle (add-on feature) is:
- A self-contained package in `packages/sprinkles/<name>/`
- Required to have a `sprinkle.json` manifest declaring inputs, outputs, and emitted events
- Integrated via event bus for loose coupling
- Never directly mutates core tables (must use core service endpoints)

### Event-Driven Integration
Domain events enable decoupled communication:
- Example: `journal.entry.created` → triggers calendar update, memory timeline, backup
- Example: `habit.completed` → updates calendar, streak service
- Event listeners registered during app bootstrap via `packages/core/events` API

## Tech Stack

### Frontend
- **Framework:** Flutter (iOS + Android)
- **State Management:** Riverpod
- **Local Storage:** Hive or Drift for offline-first architecture
- **Feature Location:** `/apps/mobile/` with modular sprinkles in `/modules/sprinkles/<name>/`

### Backend
- **Primary Platform:** Supabase (PostgreSQL, Auth, Realtime, Storage)
- **Middleware:** Node.js (Express or NestJS) in `/apps/api/` for:
  - AI proxying (OpenAI)
  - Payment webhooks (RevenueCat/Stripe)
  - Complex business logic unsuitable for DB triggers
- **ORM:** Prisma for type-safe schema and migrations

### Monorepo
- **Tool:** Turborepo + pnpm workspaces
- **Structure:**
  ```
  apps/mobile       # Flutter app
  apps/api          # Node middleware
  packages/core     # Shared types, events, utilities, theme
  packages/ui       # Shared Flutter UI components
  packages/sprinkles/* # Each sprinkle as separate package
  supabase/migrations/ # Database schema versions
  docs/contracts/   # YAML API contracts and event schemas
  ```

## Development Commands

### Monorepo Setup (When Implemented)
```bash
# Install dependencies
pnpm install

# Build all packages
pnpm turbo build

# Run tests across workspace
pnpm turbo test

# Lint all packages
pnpm turbo lint
```

### Flutter Mobile App (apps/mobile)
```bash
# Install dependencies
flutter pub get

# Run in development mode with hot reload
flutter run

# Run on specific device
flutter run -d <device-id>

# Build for iOS
flutter build ios

# Build for Android
flutter build apk

# Run tests
flutter test

# Run specific test file
flutter test test/path/to/test_file.dart

# Clean build artifacts
flutter clean
```

### Supabase
```bash
# Initialize Supabase locally
supabase init

# Start local Supabase stack
supabase start

# Stop local stack
supabase stop

# Check service status
supabase status

# Create new migration
supabase migration new <migration_name>

# Apply migrations to local DB
supabase db push

# Reset local database
supabase db reset

# Link to remote project
supabase link --project-ref <project-id>

# Deploy migrations to production
supabase db push --remote

# Deploy edge functions
supabase functions deploy
```

### Node.js API Middleware (apps/api)
```bash
# Install dependencies
cd apps/api && pnpm install

# Run in development mode
pnpm dev

# Run tests
pnpm test

# Run specific test
pnpm test <test-file-pattern>

# Build for production
pnpm build

# Run production build
pnpm start
```

## Critical Architectural Patterns

### Sprinkle Manifest (`sprinkle.json`)
Every sprinkle MUST include this file:
```json
{
  "name": "habit_tracker",
  "version": "0.1.0",
  "inputs": ["pair_id", "user_id"],
  "outputs": ["events:habit_completed"],
  "optionalIntegrations": ["calendar", "dashboard"]
}
```

### Sprinkle Registration
Sprinkles register during app bootstrap and must implement:
```dart
registerSprinkle()      // Register with core system
syncWithCalendar()      // Optional calendar integration
updateDashboard()       // Optional dashboard widget
linkAuth()              // Connect to pair authentication
```

### Data Contracts
- All API contracts live in `packages/core/contracts/` as versioned YAML
- Event schemas are documented alongside contracts
- Contracts define shape of data exchanged between sprinkles and core systems

### Privacy & Security Model
- **Privacy-first:** Minimal data collection, no ads, no tracking
- **Visibility control:** Each data element has visibility flag
- **Audit logs:** Maintain trails for shared actions at pair_id level (for troubleshooting, not surveillance)
- **RLS Policies:** Supabase Row Level Security enforces pair-scoped access
- **Encryption:** HTTPS transport, Supabase encryption at rest

## Local Development Workflow

### Environment Files Required
- `apps/mobile/.env` - Supabase URL and anon key
- `apps/api/.env` - Service role key, OpenAI key, webhook secrets
- `supabase/.env` - Local DB password

**Never commit .env files** - they should be in .gitignore

### Typical Development Flow
1. Start local Supabase: `supabase start`
2. Run Flutter app: `flutter run` (in apps/mobile)
3. Run API middleware: `pnpm dev` (in apps/api)
4. Use seeded test dataset in local Supabase
5. Flutter hot reload for rapid iteration

### Adding a New Sprinkle
1. Create package directory: `packages/sprinkles/<name>/`
2. Add `sprinkle.json` manifest
3. Implement required interfaces (registration, sync, events)
4. Create migration if new tables needed: `supabase/migrations/<timestamp>_<name>.sql`
5. Register in `packages/core/sprinkles_registry.dart`
6. Add dashboard integration if needed
7. Write tests in `packages/sprinkles/<name>/test/`
8. Document emitted events in `docs/contracts/`

## Deployment Environments

### Local
- Local Supabase via Docker
- Flutter app on emulator/device
- Node middleware runs locally
- Uses `.env.local` for configuration

### Staging
- Staging Supabase project
- Staging Node deploy (Railway/Render branch)
- `staging` build channel for mobile
- Test RevenueCat sandbox
- Test OpenAI usage limits

### Production
- Production Supabase project
- Production Node service (Railway/Render)
- App Store / Play Store releases
- Use secrets manager (GitHub Secrets) for sensitive values

## Testing Philosophy

### Mobile (Flutter)
- Unit tests for business logic
- Widget tests for UI components
- Integration tests for sprinkle event flows
- E2E smoke tests with flutter_driver or Patrol

### Backend
- Jest for Node.js unit tests
- Integration tests against Supabase emulator
- Test event bus flows (e.g., habit_completed → calendar entry appears)

## Important References

Detailed documentation is available in `/context/md files/`:
- `Cupcake_Architecture_Decision_Book (MVP).md` - Complete tech stack decisions
- `Cupcake_Knowledge_Base_Full (1) (1).md` - Vision, features, data architecture
- `Cupcake_Product_Concept_And_Brand_Tone.md` - Brand voice, UX principles
- `plan.md` - Development phases and timeline
- `🍰 Cupcake Developer Setup Guide.md` - Detailed setup instructions

## Brand Tone for User-Facing Features

When implementing user-facing features, maintain the brand voice:
- **Warm, soft, minimal, intimate, gentle**
- Encouraging, not demanding
- Empathetic, not dramatic
- Playful, not childish
- Romantic, not cheesy

Example: "Want to try this together today?" NOT "Complete your habit today."

## AI-Assisted Development Notes

When using AI to generate code for this project:
1. Always provide the sprinkle manifest as context
2. Reference schema files from `packages/core/contracts/`
3. Use pattern templates from existing sprinkles
4. Generate tests alongside implementation code
5. Enforce event-driven patterns (don't create tight coupling)
6. Keep AI context small to avoid hallucination
