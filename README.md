# User Management App 

A Flutter application for managing users with authentication, pagination, and user editing.  
Built using **Clean Architecture** with **MVVM + BLoC (Cubit)** and proper dependency injection.

---

=> Features

-  Authentication (Login)
-  Users List with Pagination (DummyJSON API)
-  View User Details
-  Edit User Data
-  Local update cache for edited users
-  Clean Architecture structure
-  Dependency Injection using GetIt
-  Scalable & production-ready setup

---

=>  Architecture

This project follows **Clean Architecture** with **MVVM** using **BLoC (Cubit)**.

```
lib/
│
├── core/
│   ├── constants/
│   ├── dialogs/
│   ├── errors/
│   ├── network/
│   ├── usecases/
│   └── utils/
│
├── feature/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── users/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── injection_container.dart
└── main.dart
```

---

=> Why this architecture?

-  Clear separation of concerns
-  Easy to test & maintain
-  Scalable for large projects
-  Real-world production-ready structure
-  Clean dependency flow

---

=>  Tech Stack

- Flutter
- Dart
- BLoC (Cubit)
- MVVM
- Clean Architecture
- Dio
- GetIt
- DummyJSON API

---

=>  Screenshots

| Login | Users List |
|------|-----------|
| ![](assets/screenshots/login.jpg) | ![](assets/screenshots/users_list.jpg) |

| User Details | Edit User |
|-------------|-----------|
| ![](assets/screenshots/user_details.jpg) | ![](assets/screenshots/edit_user.jpg) |

---

=>  Demo Video
> [🔗 Google Drive](https://drive.google.com/file/d/1ys8YSCZttPAPCBZ6REhEfB2_Ds0BayCQ/view?usp=drive_link)
> *(You can open demo app in google drive)*
> 
 **Screen Recording – Demo Video**

https://github.com/user-attachments/assets/3d8d0fbb-59a1-4202-a4a3-f7a3e6580411

> If the video doesn’t play on GitHub, download it and open it locally.

---

=>  Getting Started

=> Clone the repository
```bash
git clone https://github.com/Marco-Mina-Moris/user-management-app.git
```

=> Install dependencies
```bash
flutter pub get
```

=> Run the app
```bash
flutter run
```

---
