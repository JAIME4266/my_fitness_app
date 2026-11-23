# 🏃‍♂️ PulseTrack — Daily Nutrition & Activity Dashboard

> **A modern, privacy-first Flutter fitness companion that bridges wearable activity data with real-time daily calorie and macronutrient tracking.**

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android Health Connect](https://img.shields.io/badge/Health_Connect-Integrated-34A853?style=for-the-badge&logo=android&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-Android_8.0%2B-black?style=for-the-badge&logo=android&logoColor=white)

---

## ✨ Key Features

* **⌚ Wearable & Health Connect Sync:** Seamlessly pulls daily step counts and active burned calories from Android **Health Connect** (supporting Mi Fitness, Zepp Life, Google Fit, and system step counters).
* **🔥 Dynamic Calorie Budgeting:** Automatically recalculates your **Calories Remaining** in real time (`Target - Food + Active Burned`) so your nutrition budget adapts to your movement.
* **🥗 Visual Macros Breakdown:** Clean, color-coded progress indicators for daily **Protein**, **Carbohydrates**, and **Fats**.
* **⚡ Resilient Data Pipeline:** Built-in fallback aggregation and calorie estimation engine ensuring accurate metrics across different Android OEMs and wearable ecosystems.

---

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter & Dart
* **Health Integration:** `health` plugin (Android Health Connect SDK)
* **Permissions & Manifest Routing:** Custom Android 14+ `VIEW_PERMISSION_USAGE` activity-alias and rationale intent handling
* **Charts & UI:** Material 3 design system, `google_fonts`, `fl_chart`

---

## 🚀 Getting Started

### Prerequisites
* Flutter SDK installed (`minSdk = 26` / Android 8.0+)
* Physical Android device with **Health Connect** installed

### Installation

1. **Clone the repository**
   ```bash
   git clone [https://github.com/JAIME4266/my_fitness_app.git](https://github.com/JAIME4266/my_fitness_app.git)
   cd my_fitness_app
