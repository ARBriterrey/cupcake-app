### Development Plan for the Cupcake App

This plan prioritizes building a strong core application first, then validating the modular "Sprinkle" architecture, and finally accelerating development with automation and AI tooling.

---

#### **Phase 1: Foundation & Setup (Weeks 1-2)**

This phase is about turning the skeleton repository into a runnable project. It directly follows the "Next Action Items" from the architecture document.

1.  **Initialize Monorepo:**
    *   Configure `pnpm-workspace.yaml` to recognize the `apps` and `packages` directories.
    *   Set up `turbo.json` with a basic pipeline for linting and building the future `api` and `mobile` apps.

2.  **Configure Supabase:**
    *   Create the development and staging projects on the Supabase platform.
    *   Run `supabase init` locally.
    *   Create the first migration in `supabase/migrations/` for the `users` and `pairs` tables. This is the absolute core of the couple-centric model.
    *   Run `supabase db push` to apply the schema to your local database.

3.  **Scaffold Applications:**
    *   **Flutter App (`apps/mobile`):** Initialize a new Flutter application. Set up the basic folder structure and connect it to your local Supabase instance using the `.env` file.
    *   **Node.js API (`apps/api`):** Initialize a new Node.js (e.g., Express) project. Create a single placeholder endpoint (e.g., `/health`) to confirm it runs.

4.  **Establish CI:**
    *   Create a basic GitHub Actions workflow that runs `pnpm install` and a lint command to ensure repository health.

---

#### **Phase 2: Core App Implementation - "The Cupcake" (Weeks 3-6)**

The goal here is to build the essential, non-optional features of the app.

1.  **Authentication & Pairing:**
    *   Implement the user sign-up and login flow in the Flutter app using `supabase-flutter`.
    *   Build the UI and logic for users to invite their partner and establish a `pair` record in the database. This is the most critical workflow to get right.

2.  **Build the Core UI:**
    *   Create the main app shell (e.g., a `Scaffold` with a `BottomNavigationBar`).
    *   Develop the initial `Couple Dashboard` as the central hub.

3.  **Implement a Core Feature:**
    *   Build one of the base features end-to-end, for example, the **Shared Calendar / Moments Board**. This will force you to establish the patterns for:
        *   State management (with Riverpod).
        *   Data fetching from Supabase.
        *   Real-time updates using Supabase Realtime.
        *   Local caching for offline use (with Hive/Drift).

4.  **Develop Shared UI Package:**
    *   As you build, identify common widgets (buttons, text styles, cards) and move them into the `packages/ui` directory to create a reusable component library.

---

#### **Phase 3: First "Sprinkle" & Pattern Validation (Weeks 7-8)**

This phase proves the modular architecture.

1.  **Manually Build the "Shared Journal" Sprinkle:**
    *   Follow the steps outlined in the `Developer Setup Guide` to create the sprinkle from scratch.
    *   Create its database schema and migration.
    *   Implement its UI, logic, and state management within its own package (`packages/sprinkles/journal`).
    *   Register the sprinkle in the core app.
    *   Write dedicated tests for the sprinkle.

2.  **Refine the Pattern:**
    *   Document the exact steps, boilerplate code, and conventions you used. This manual process creates the definitive template for all future sprinkles.

---

### When to Build the AI Agents

The best time to build the AI agents is **at the beginning of Phase 4**, immediately after you have a proven, manual pattern from building the first Sprinkle.

*   **Why wait until Phase 4?**
    *   **You need a template:** The agents need a concrete, successful example to learn from. The manually-built "Shared Journal" sprinkle provides this template. Building agents before this would be based on theory, not proven practice.
    *   **Patterns must be stable:** The core architecture, state management, and data flow should be stable before you try to automate their creation.

#### **Phase 4: Acceleration & Scaling (Ongoing)**

Now, with a solid foundation and a proven modular pattern, you can focus on speed and expansion.

1.  **Build the AI Agents:**
    *   **`Sprinkle Builder Agent`:** This should be the first agent you build. Train it on the "Shared Journal" template to automate the creation of new sprinkle packages, including directory structure, boilerplate files, and registration code.
    *   **`Schema Guardian` & `Test Writer` Agents:** Once the Sprinkle Builder is working, create agents to generate the initial Supabase schema and basic unit/widget tests for new sprinkles.

2.  **Expand Features:**
    *   Use your new AI agents to rapidly scaffold and develop the remaining core features and a backlog of new Sprinkles (Habit Tracker, Mood Tracker, etc.).

3.  **Mature CI/CD:**
    *   Expand your GitHub Actions to include automated testing for all packages and create workflows to build and deploy the Flutter app to TestFlight/Play Store beta channels.