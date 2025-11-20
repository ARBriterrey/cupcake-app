**Version:** MVP (Supabase-first Architecture)  
**Audience:** Developers onboarding to Cupcake  
**Goal:** Enable a new developer to fully set up Cupcake’s environment, run the app locally, and understand key workflows.

---

# 1. 📦 Prerequisites

### Required Software

|Tool|Version|Notes|
|---|---|---|
|**Flutter SDK**|Latest Stable|Cross-platform mobile framework|
|**Dart SDK**|Bundled w/ Flutter|No additional install needed|
|**Supabase CLI**|Latest|Database migrations & local dev|
|**Node.js**|≥ 18|For middleware + scripts|
|**pnpm**|Latest|Monorepo package manager|
|**Git**|Latest|Version control|
|**Android Studio**|Latest|Also provides Android SDK|
|**Xcode**|Latest|Required for iOS builds (Mac only)|

---

# 2. 🚀 Repository Setup (Monorepo)

Cupcake uses a **Turborepo-style monorepo**:
```bash
cupcake/
│
├── apps/
│   ├── mobile/         # Flutter app
│   └── api/            # Node.js middleware (optional)
│
├── packages/
│   ├── core/           # Shared constants, types, theme, events
│   ├── sprinkles/      # All modular add-ons
│   └── ui/             # Shared Flutter UI components
│
└── docs/               # Documentation + schemas

```

Clone the repo:

```bash
git clone https://github.com/<your-username>/cupcake.git 
cd cupcake
```

Install dependencies:

```bash
pnpm install
```

---

# 3. 🔐 Environment Configuration

### Required `.env` files

You will need **three** environment files:

### `apps/mobile/.env`

```ini
SUPABASE_URL=<your project url>
SUPABASE_ANON_KEY=<anon public key>

# Optional:
APP_ENV=development

```

### `apps/api/.env`

```ini
SUPABASE_SERVICE_ROLE_KEY=<service role key>
OPENAI_API_KEY=<your-key-here>
REVENUECAT_WEBHOOK_SECRET=<optional>
```

### `supabase/.env`

```ini
SUPABASE_DB_PASSWORD=<your local db password>
```

Never commit these files — `.gitignore` should already exclude them.

---

# 4. 🗄️ Supabase Setup

Install the CLI:

```bash
pnpm dlx supabase init
```

Login:

``` bash
supabase login
```

Link project:
```bash
supabase link --project-ref <your-project-id>
```

Run local Supabase (optional but recommended):
```bash
supabase start
```
### Apply migrations:
```bash
supabase db push
```

### Useful Supabase Commands

|Command|Purpose|
|---|---|
|`supabase status`|Check local services|
|`supabase stop`|Stop containers|
|`supabase migration new <name>`|Create migration|
|`supabase db reset`|Drop & recreate local DB|

---

# 5. 📱 Running the Flutter Mobile App

Inside `apps/mobile`:

1. Install Flutter dependencies:
```bash
flutter pub get
```

`flutter pub get`

2. Run app:
```bash
flutter run
```
`flutter run`

3. For iOS:
```bash
flutter build ios
```
`flutter build ios`

4. For Android:
```bash
flutter build apk
```

`flutter build apk`

Recommended IDEs:

- **VSCode** with Flutter extensions
- **Android Studio** (great for emulators & debugging)

---

# 6. 🧱 Core Concepts Developers Must Understand

### 6.1 Couple Linking Model
Every authenticated user must be linked into a **pair**:

```scss
pairs(pair_id)
    - user_a
    - user_b
    - created_at
```

Sprinkles operate using:  
👉 `pair_id`  
👉 `user_id`  
👉 `visibility_settings`
### 6.2 Local-First Sync Model

Cupcake uses:
- **Hive/Drift** → persistent local cache
- **Supabase Realtime** → updates from server
- **Sync Engine** → merges changes

This means Cupcake **works offline**, and updates sync when online.
### 6.3 Sprinkle Manifest (Mandatory)

Every Sprinkle must include `sprinkle.json`:

```json
{
  "name": "habit_tracker",
  "version": "0.1.0",
  "integrations": ["calendar", "dashboard"],
  "events_emitted": ["habit_completed"],
  "events_listened": []
}

```

---

# 7. 🧩 Adding a New Sprinkle

Cupcake uses modular architecture. To add a new Sprinkle:

1. Create directory:
```bash
packages/sprinkles/<sprinkle_name>/
```

2. Generate files from template:
```bash
sprinkle/
    lib/
      sprinkle_main.dart
      sprinkle_controller.dart
      sprinkle_repository.dart

```

3. Register Sprinkle:  
    Edit:
```bash
packages/core/sprinkles_registry.dart
```

4. Update schema (if needed):
```bash
supabase/migrations/<timestamp>_<name>.sql
```

5. Add dashboard integration if Sprinkle needs a widget.
6. Write tests:
```bash
packages/sprinkles/<name>/test/
```


---

# 8. 🤖 AI-Assisted Development Workflow (Optional but Recommended)

### Use AI with strict structure:

1. Provide Sprinkles manifest
2. Provide schema file (`core_schema.yaml`)
3. Provide pattern templates
4. Ask AI to generate:
    - data model
    - controller
    - UI screens
    - event handlers
    - tests
### AI agents recommended:

- Sprinkle Builder Agent
- Schema Guardian Agent
- Test Writer Agent
- Doc Generator Agent
Keep context small → avoid hallucination → enforce templates.

---

# 9. 🧪 Testing Setup

### Unit tests:
```bash
flutter test
```
### Integration tests:
```bash
flutter test integration_test
```
### Supabase-backed tests:
Use the Supabase emulator:
```bash
supabase start
```

Run backend tests with Jest (if API exists):
```bash
pnpm test
```

---
# 10. 🚀 Deployment Pipeline

### Mobile

|Platform|Command|
|---|---|
|Android|`flutter build appbundle`|
|iOS|`flutter build ipa`|

### Backend (Supabase)

Supabase deploys migrations and edge functions automatically via:
```bash
supabase db push
supabase functions deploy
```
### CI/CD (Optional)

Setup GitHub Actions workflows:

- `flutter_ci.yml`
- `supabase_deploy.yml`

---

# 11. 📂 Project Best Practices

### Code Style

- Use lower_snake_case for Dart files
- Use PascalCase for class names
- Keep Sprinkle code isolated

### Branching Strategy
```css
main → staging → feature/**
```
`main → staging → feature/**`

### Documentation

- Every Sprinkle must include:
    - README.md
    - sprinkle.json
    - API notes (if any)

---

# 12. 🆘 Troubleshooting

### Supabase Realtime not syncing

- Check RLS policies
- Ensure `read` and `insert` policies use the correct `pair_id`

### Flutter errors

Run:
```bash
flutter clean
flutter pub get
```
### Sync issues

- Clear Hive/Hive.box
- Restart local Supabase containers