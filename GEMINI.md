# Gemini Context: Cupcake App

This document provides a comprehensive overview of the Cupcake application, based on the project's planning and architecture documents.

**Project Status:** This is a skeleton project. The directory structure has been created, and the initial scaffolding for core components (monorepo, mobile app, API) is partially complete. The information below reflects the intended design and architecture and has been updated to reflect confirmed technology choices.

---

## 1. Project Overview

Cupcake is a **couples-first mobile app** designed for long-distance relationships (LDRs). Its purpose is to foster emotional intimacy and connection through a set of shared digital tools and experiences.

The core philosophy is built around a "Cupcake & Sprinkles" metaphor:
- **The Cupcake:** The free base application that includes essential, shared tools for couples.
- **Sprinkles:** Optional, modular add-on features that couples can choose to add to their experience, representing personalization and deeper engagement.

## 2. Intended Architecture

The project is a monorepo intended to be managed by **pnpm** and **Turborepo**.

- **Frontend (`apps/mobile`):** A cross-platform mobile application.
  - **Framework:** **Flutter** has been chosen for the mobile application, as evidenced by the project's scaffolding.

- **Backend (`apps/api`):** A lightweight **Node.js** middleware (using Express or NestJS). Its primary roles are to proxy requests to third-party services like OpenAI and to handle payment webhooks from RevenueCat/Stripe.

- **Database (`supabase/`):** The primary backend platform is **Supabase**, providing:
  - A **PostgreSQL** database.
  - User Authentication.
  - Real-time data sync.
  - File storage.
  - Database migrations managed via the Supabase CLI.

- **Shared Packages (`packages/`):**
  - `packages/core`: For shared logic, types, constants, and event handling.
  - `packages/ui`: For a shared component library.
  - `packages/sprinkles`: To house each modular "Sprinkle" as a separate package.

## 3. Brand & Vision

- **Brand Tone:** The app's voice should be **warm, soft, minimal, intimate, and gentle**. Communication should be encouraging and empathetic, not demanding.
- **Visual Aesthetic:** The UI should feel like a "cozy shared space," utilizing soft pastels, warm neutrals, spacious layouts, and rounded corners.
- **Core Mission:** To strengthen a couple's bond through features that encourage mutual participation and create a shared emotional rhythm.

## 4. Development Plan & Next Steps

The project is ready to be scaffolded. Based on the "Next Action Items" in the architecture plan, the following steps should be taken:

1.  **Initialize Monorepo:**
    *   Configure `pnpm-workspace.yaml` to define the workspace areas (`apps/*`, `packages/*`).
    *   Configure `turbo.json` to define the build pipeline and task dependencies.

2.  **Set up Supabase:**
    *   Create development and staging projects on the Supabase platform.
    *   Configure Auth, Storage, and other required Supabase services.
    *   Initialize the local environment with `supabase init` and link the projects.

3.  **Implement Core Schema:**
    *   Create the initial database migration files in `supabase/migrations/` for core tables (e.g., `pairs`, `users`, `journal`, `calendar`).
    *   Apply the migrations to the local database using `supabase db push`.

4.  **Scaffold Applications:**
    *   **Mobile App (`apps/mobile`):** Scaffold the Flutter (or React Native) application, including basic auth flow and couple-linking logic.
    *   **API (`apps/api`):** Scaffold the Node.js middleware skeleton, including placeholder endpoints for AI proxying and payment webhooks.

5.  **Create a Sample Sprinkle:**
    *   Implement the "Shared Journal" sprinkle as the first example, including its `sprinkle.json` manifest.

6.  **Set up CI/CD:**
    *   Add initial GitHub Actions workflows for running tests and triggering builds.
