
---

# 🎟️ Ticket App – Flutter

A simple Flutter application developed as part of the **Mobile App Developer – Flutter** task for **Gain Solutions Ltd**.
The app demonstrates **MVVM architecture**, **Repository pattern**, **State Management with Provider**, and **API simulation using static JSON data**.

---

* Filter button in the **top-right corner**.
* Navigates to a **Filter Screen**.
* User can **select multiple filter options** dynamically (from simulated JSON API).

Here’s the refined part of the README 👇 (only the **Features section**, rest stays same):

---

## 🚀 Features

### 1. Ticket Screen

* Displays a **list of tickets**.
* Includes a **Filter button in the top-right corner**.
* On tap, navigates to the **Filter Screen**.

### 2. Filter Screen

* Fetches **filter options** dynamically from static JSON (simulated API).
* **Number of filters is dynamic** (sometimes 3, sometimes 5).
* UI adapts automatically.
* Allows the user to **select multiple filter options at once**.
* Selected filters are applied back to the **Ticket Screen**.

### 3. Contact Screen

* Search screen for user contacts.
* Displays results from static JSON data.

### 4. Profile Screen

* Shows user details such as **Name, Email, and Profile Picture**.

---


## 🛠️ Tech Stack

* **Flutter** (UI + Business logic)
* **Dart** (OOP, clean code principles)
* **Provider** (state management)
* **MVVM + Repository Pattern**

  * Repository layer abstracts **local JSON fetching** (API simulation).
  * Easy to replace with real APIs later.
* **Service Locator (GetIt)** for **Dependency Injection**
* **AppUtils Static Functions** (optimized for lower RAM consumption).
* **CI/CD with GitHub Actions** (automated build & test pipeline).
* **Light & Dark Theme support** 


---

## 📂 Project Structure

```
lib/
│── app/
│   ├── core/
│   │   ├── base/                # Base classes (theme, remote source, widget mixin, etc.)
│   │   ├── data/
│   │   │   ├── local/           # Local data sources (JSON simulation)
│   │   │   │   ├── profile_local/
│   │   │   │   ├── tickets_local/
│   │   │   │   └── contacts_local/
│   │   │   ├── remote/          # Remote data sources (future APIs)
│   │   │   └── repository/      # Repository layer
│   │   ├── network/             # Dio setup (kept for demonstration)
│   │   ├── provider/            # Providers setup
│   │   ├── services/            # Service locator (dependency injection)
│   │   └── utils/               # App utilities, constants, singleton
│   ├── model/                   # Data models (Ticket, Contact, Profile, Filters)
│   ├── presentation/            # UI layer (MVVM)
│   │   ├── component/           # Shared reusable widgets
│   │   ├── contacts/            # Contacts screen
│   │   ├── home_bottom/         # Bottom navigation
│   │   ├── profile/             # Profile screen (page, view_model, widgets)
│   │   └── tickets/             # Ticket screen (page, view_model, widgets)
│   ├── route/                   # App routing (paths, service)
│   └── flavors/                 # Multiple environment configs (dev, prod)
│
├── main.dart                    # App entry
├── main_dev.dart                 # Dev flavor
├── main_prod.dart                # Prod flavor
```

---

## ⚡ API Simulation

* Static JSON files under **assets/** simulate API responses.
* Example:

  * `tickets_local_source.dart` → loads `assets/tickets.json`
  * `contacts_local_source.dart` → loads `assets/contacts.json`
  * `profile_local_source.dart` → loads `assets/profile.json`
* Repository layer provides an abstraction for fetching data.
* Service Locator injects repositories into ViewModels.
* ViewModels expose data to the UI using **Provider**.

---

## 🔄 CI/CD

* GitHub Actions workflow added for:

  * Automated build
  * Lint checks

---

Got it 👍 — here’s the corrected **README section** with the requested change:

---



## 📦 Download APK

You can download and test the latest build of the app from Google Drive:

👉 [Download APK](https://drive.google.com/your-apk-link-here)

This project is integrated with **GitHub Actions** for continuous integration and delivery.
Whenever you push to the repository, a workflow is triggered to build the Flutter APK.

🔗 [GitHub Actions Workflow](https://github.com/your-repo/actions)


---



## 📌 Notes

* This project’s **core implementation is local JSON + MVVM + Repository Pattern**.
* **Dio setup** is included only as a **reference** to show how real API integration can be achieved.

  * Implemented as **Singleton** for optimization.
  * Includes **Interceptors** (logging, headers, error handling).
  * Makes migration to real API seamless.

---

## 📸 UI Reference

Based on: [Figma Design](https://www.figma.com/design/7fwf4IQMfmxI4ZAvOpndCJ/Design-Task-for-Flutter-Dev?m=auto&t=u434GodirhhEjVk8-1)

---

## 👨‍💻 Author

**Niaj Mahmud**
Mobile App Developer – Flutter
3+ years experience in Flutter, Kotlin, Java, MVVM, and Clean Architecture

---


