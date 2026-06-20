# Specification: Habit Tracker Mobile App

## 1. Overview
A minimalist, one-page Habit Tracking mobile application built with Flutter. The app allows users to register and login locally, add habits, mark them as completed for the day (binary tracking: done/not done), and view progress via a visual dashboard.

## 2. Key Features
- **Local Authentication:** SQLite-based secure registration and login.
- **Single-Page Architecture:** Everything (Habit List, Create Habit, Progress Dashboard) is accessible from a unified, modern, premium one-page dashboard with dynamic views or clean scrollable sections.
- **Binary Mechanism for Daily Tracking:** Each habit has a simple "Done/Not Done" checkbox or toggle for the current day.
- **Local Persistence:** All habit configurations and daily tracking records are synced with a local SQLite database.
- **Visual Progress Dashboard:** Micro-statistics, progress rings/bars, or a weekly streak visualization to see habit completion rates.

## 3. Data Architecture
### Users Table (`users`)
```json
{
  "uid": "String",
  "email": "String",
  "displayName": "String",
  "password": "String"
}
```

### Habits Table (`habits`)
```json
{
  "id": "String",
  "uid": "String",
  "name": "String",
  "category": "String",
  "colorValue": "Integer",
  "icon": "String",
  "createdAt": "String (ISO 8601)",
  "history": {
    "YYYY-MM-DD": "Boolean"
  }
}
```

## 4. UI/UX Design & Aesthetics
- **Core Aesthetic:** Sleek, high-end "Soft Minimalism" with a dark mode or tailored HSL color palette.
- **Modern Typography:** Inter or Outfit from Google Fonts.
- **Responsive Layout:** Well-spaced sections for tracking today's completion, adding a new habit, and reviewing overall progress.
- **Micro-Animations:** Fluid transitions for marking a habit as completed, dynamic progress bars adjusting on-the-fly.

## 5. Technology Stack
- **Framework:** Flutter (Dart)
- **State Management:** Riverpod (for responsive, reactive UI state) or direct local state notifiers
- **Backend/Auth & Storage:** SQLite (`sqflite` package) for both data and user registration/login

