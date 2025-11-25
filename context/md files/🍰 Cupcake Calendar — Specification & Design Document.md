
## **1. Purpose & Philosophy**

The Cupcake Calendar is a **relationship-first timeline** built for long-distance couples.  
Its purpose is to act as a **one-glance information space** containing all shared life events, emotional cues, and sprinkle-based activities.

### **Core Principles**

- **Centralized hub** for shared routines, reminders, and emotional syncing
    
- **Toggleable views** that let partners choose the kind of information they want displayed
    
- Designed around **connection**, not productivity
    
- **Soft, pastel, warm visuals** that reflect the Cupcake brand
    
- **Local-first** with seamless Supabase sync for shared events
    

---

## **2. Types of Events**

### **2.1 Manually Added by Users**

Users can create:

- **Date Nights**
    
- **Travel Plans**
    
- **Routine Reminders**
    
    - Examples: weekly call, Friday movie night, Sunday planning
        
- **Custom Events**
    
    - Flexible text/name
        
    - Optional icon or emoji
        

### **2.2 Automatically Added via Sprinkles**

Each category can produce calendar events:

- **Wellness** — workout sessions, meditation
    
- **Journaling** — reflection reminders
    
- **Games** — challenge deadlines
    
- **Reflections** — weekly/fortnight reviews
    
- **Habits** — shared goals or streak-based reminders
    
- **Period Tracking** — predicted cycle dates, comfort suggestions
    

Each source is **color-coded** and can be filtered independently.

---

## **3. Shared vs Private**

- Cupcake Calendar events are **shared between partners** by default
    
- Local-first data stored on device → synced through Supabase
    
- No private/solo mode in MVP (optional later)
    

---

## **4. Calendar Views**

The calendar supports multiple view modes at MVP, all toggleable through a small bar above/below the grid:

### **4.1 Standard Views**

- **Timeline View** (default — relationship-focused)
    
- **Month View**
    
- **Week View**
    

### **4.2 Emotional Views**

- **Mood Ring View**
    
    - Each day shows a small ring/emoji based on daily mood
        
- **Habit Tracker View**
    
- **Countdown View**
    
    - “X days until next meet/trip/date night”
        

---

## **5. Filters (Sprinkle Tabs)**

Below/above the calendar is a row of toggleable filters:

- Wellness
    
- Journaling
    
- Games
    
- Reflections
    
- Habits
    

**User Action:**  
Toggling a filter shows or hides all events from that sprinkle category.  
This allows the calendar to become:

- A wellness planner
    
- A relationship timeline
    
- A habit-only tracker
    
- A pure emotional/mood board
    
- Or a combined calendar of everything
    

---

## **6. UX Details & Interactions**

### **6.1 Reactions & Social Interaction**

Partners can:

- ❤️ React to events
    
- 👍 Mark them as acknowledged
    
- 💬 Comment under any event
    
- 📝 Suggest edits (owner accepts or applies changes)
    

### **6.2 Visual Cues**

- **Color-coded event types**
    
- Small **emoji/dot icons** for category identification
    
- **Mood ring** at the corner of each date
    
- Events use soft shadows, pastel theme, and micro-animations
    

---

## **7. Event Behaviors**

- **Recurring Events** supported (weekly, monthly, yearly)
    
- **Timezone-aware events**
    
    - Each event displays correctly for each partner
        
    - Optional “Show in partner’s local time” toggle
        
- **Countdowns** auto-generate for:
    
    - Travel events
        
    - Upcoming date nights
        
    - Anniversaries
        
- **Editing**
    
    - Both partners can edit
        
    - Edits synced locally → Supabase
        

---

## **8. Notifications**

Example notifications:

- **“Your partner updated the calendar — check it out!”**
    
- Event reminders (e.g., 30 min before)
    
- Category-based reminders:
    
    - “Today is a wellness day”
        
    - “Your mood board isn’t filled today — want to update it?”
        
    - “Habit streak at risk — check your planner”
        

---

## **9. Data Structure (High-level)**

### **Event Object**

```java
event_id  
title  
type (date_night, travel, routine, custom, sprinkle_source)  
category (wellness, journaling, games, reflections, habits, mood, period)  
start_time  
end_time  
timezone  
is_recurring  
recurrence_pattern  
created_by  
updated_by  
mood_ring (optional)  
color_code  
shared = true  
comments[]  
reactions[]  
```

---

## **10. Storage & Sync**

- **Local-first architecture**
    
    - Calendar cached on device
        
    - Works even with no internet
        
- **Supabase sync**
    
    - Events, comments, reactions, and sprinkle-generated entries synced
        
- Conflict resolution handled via timestamps + last-write priority
    

---

## **11. Design & Aesthetic Notes**

- Cupcake’s default soft peach palette
    
- Gentle curves and round corners
    
- Emphasis on warmth & emotional connection
    
- Mood rings match the brand identity
    
- Subtle sparkles or breathing animations on special dates