# Cupcake Knowledge Base (Full Version – Supabase Corrected)

**Prepared for:** Andhan Rahul Buddhan  
**Project:** Cupcake – Couples-First Long-Distance Relationship App  

---

# 1. Vision & Philosophy

Cupcake is a **couples-first long-distance relationship app** built around emotional intimacy, shared rituals, and practical life syncing. Instead of focusing on messaging or calling, Cupcake fosters **connection through shared experiences**, reflection, and wellness.

### Core Principles
- **Couples-first:** Shared systems, shared data, shared rituals.
- **Modular:** Base app + optional “Sprinkles.”
- **Local-first:** Works offline and syncs seamlessly.
- **Privacy-first:** No ads, no tracking, no dark patterns.

---

# 2. Base App (Cupcake Core)

Always free and always shared between the couple.

### Core Features
- **Shared Journal** (private or shared entries)
- **Nudge System** (“thinking of you” signals)
- **Shared Calendar** (auto time-zone aware)
- **Collaborative Lists** (with Chit Jar mode)
- **Widget Sync** (shared photos to home screen)

The Base establishes the **sync layer**, **authentication**, **pair linking**, and **core components** that Sprinkles build upon.

---

# 3. Sprinkles (Modular Add-ons)

Optional plug-in style modules extending the shared experience.

### Sprinkle Categories
#### Wellness
- Habit Tracker  
- Sleep/Energy Tracker  
- Medication Tracker  
- Period Tracker  

#### Reflection
- Gratitude Jar  
- Memory Lane  
- Deep Question Sets  

#### Fitness & Lifestyle
- Shared workouts  
- Steps/movement sync  
- Mini challenges  

#### Bonding & Games
- Turn-by-turn games  
- Trivia  
- Drawing prompts  

#### Organization
- Trip planner  
- Shared budgets (future)
- Joint tasks  

Sprinkles **plug into** shared Calendar, Journal, Dashboard, and Sync Engine.

---

# 4. Technical Architecture (MVP – Supabase Corrected)

## 4.1 Frontend
- **Framework:** Flutter (iOS + Android)
- **State Management:** Riverpod
- **Local Storage:** Hive or Drift (offline-first)
- **Feature Modularity:** `/modules/sprinkles/<sprinkle_name>` folders

## 4.2 Backend — *Supabase (Primary for MVP)*
### Why Supabase for MVP?
- SQL relational database (PostgreSQL)  
- Row-level security with policy-based control  
- Real-time sync built on database changes  
- Auth tightly integrated with Postgres  
- Open-source and future-flexible  
- Perfect for shared/couple-based data models  
- Cheaper and more predictable scaling  

### Supabase Services Used
- **Postgres DB** — core shared models  
- **Row Level Security** — user & pair scoping  
- **Supabase Auth** — email / OAuth / magic link  
- **Supabase Realtime** — Firestore-like sync  
- **Supabase Storage** — media and file uploads  
- **Edge Functions** — serverless backend logic  

## 4.3 Node Middleware (Optional but Recommended)
Reasons:
- Custom AI endpoints (OpenAI proxy)
- Payments handler for RevenueCat/Stripe webhooks
- Complex logic that shouldn’t run in DB triggers

---

# 5. Data Architecture

## 5.1 Couple Pair Model (Supabase Schema)
```
pairs (
  pair_id uuid primary key,
  user_a uuid references users(id),
  user_b uuid references users(id),
  created_at timestamp
)

sprinkles_enabled (
  id uuid primary key,
  pair_id uuid references pairs(pair_id),
  sprinkle_key text
)
```

## 5.2 Sync Model
- Supabase Realtime pushes updates to clients
- Hive/Drift caches ensure offline availability
- State merges performed by a central Sync Engine in Flutter

## 5.3 Sprinkle Contract
Every Sprinkle implements:
```
registerSprinkle()
syncWithCalendar()
updateDashboard()
linkAuth()
```

All Sprinkles communicate via the shared `pair_id`.

---

# 6. AI-Assisted Development Strategy

## 6.1 Agents
- **Sprinkle Builder Agent**
- **Schema Guardian Agent**
- **UI Builder Agent**
- **Test Writer Agent**
- **Documentation Agent**

## 6.2 Workflow
1. Create Sprinkle manifest  
2. AI generates boilerplate module  
3. Developer refines and integrates  
4. Tests generated + run  
5. CI ensures schema consistency  

---

# 7. Privacy & Safety

- No ads  
- No cross-app tracking  
- Local-first storage  
- User-controlled deletion/export  
- Couple-specific encryption model (future)  
- GDPR-compliant  

---

# 8. Deployment & CI/CD

### Pipeline (Flutter + Supabase)
- GitHub Actions builds  
- Expo-like workflow not needed (Flutter used)  
- Supabase migrations via `supabase cli`  
- TestFlight (iOS) / Play Store (Android) for rollout  

### Versioning
```
major.minor.patch
```

---

# 9. Future Scalability

### Phase 2 Upgrades
- Supabase → dedicated Postgres (Neon)  
- Edge Functions → microservices  
- Redis cache layer  
- AI summary engine for journals and moods  

### Phase 3 Upgrades
- Web dashboard  
- Cross-couple analytics  
- Therapist/counsellor mode  
- Marketplace for community Sprinkles  
- On-device LLMs for privacy-first AI  

---

# 10. Summary

Cupcake MVP is built on **Supabase**, not Firebase.  
It is designed as a **modular, privacy-first, emotionally intelligent couples app**. The Sprinkle architecture allows Cupcake to remain lightweight yet expandable, while Supabase provides a scalable relational backend ideal for shared couple data and event-driven updates.

This file serves as the complete development context for future team members and custom GPT integrations.
