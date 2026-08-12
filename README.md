<div align="center">
  <h1>🌟 Jameya Admin (لوحة تحكم إدارة الجمعيات) 🌟</h1>
  <p>
    <b>The official administrative dashboard app for governing and managing the Jameya (ROSCA) ecosystem. Designed specifically for system admins.</b>
  </p>
  <br/>

  [![Flutter Version](https://img.shields.io/badge/Flutter-3.9+-02569B?logo=flutter)](https://flutter.dev/)
  [![Dart Version](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev/)
  [![State Management](https://img.shields.io/badge/State_Management-Bloc-blue)](https://bloclibrary.dev/)
  [![Architecture](https://img.shields.io/badge/Architecture-MVVM-success)](#-architecture--folder-structure)
  
</div>

---

## ⚠️ Important Note: Admin App
> **This is the Admin Application, NOT the customer-facing app.**  
> It is strictly built for system administrators to control and monitor the Jameya platform, verify members, oversee financial transactions, and manage the complete lifecycle of savings groups (Circles).

---

## 📖 What is Jameya Admin?

**Jameya Admin** is a robust and highly secure Flutter application that acts as the backbone of the Jameya operations. It provides a comprehensive suite of tools for admins to review Pending KYC requests, authorize memberships, track installment payments in real-time, and enforce administrative policies seamlessly.

---

## ✨ Core Admin Features (المميزات الأساسية)

تطبيق **Jameya Admin** يحتوي على مجموعة ضخمة من الميزات اللي بتغطي كل احتياجات الإدارة للجمعيات المالية (ROSCA)، متقسمة حسب الـ Features الموجودة في النظام:

### 1. 🏠 Admin Dashboard (لوحة التحكم الرئيسية)
- **Home Overview:** نظرة عامة سريعة على حالة النظام بالكامل من الشاشة الرئيسية (Home).
- **Tasks Management (إدارة المهام):** متابعة وإدارة المهام الإدارية المطلوبة من فريق العمل.
- **Onboarding & Splash:** شاشات ترحيب وتعريف سريعة لتسهيل دخول الأدمن الجديد للمنظومة.

### 2. 🔐 Authentication & Profile (التحكم في الوصول)
- **Secure Login (تسجيل دخول آمن):** نظام حماية وتسجيل دخول مخصص لصلاحيات الأدمن فقط.
- **Admin Profile (الملف الشخصي):** إدارة بيانات حساب الإدمن وإعدادات التطبيق.

### 3. 👥 Members Management (إدارة الأعضاء الشاملة)
- **Member Verification (توثيق الأعضاء - KYC):**
  - مراجعة طلبات الانضمام المعلقة (Pending Requests).
  - التحقق من صور الأعضاء وبيانات الهوية الوطنية (National ID).
  - قبول أو رفض الطلبات (Approve/Reject)، ليتم مزامنتها فوراً مع قاعدة البيانات.
- **All Members Directory (سجل الأعضاء):** استعراض قائمة بجميع الأعضاء المسجلين في النظام.
- **Member Details (تفاصيل العضو):** ملف شخصي كامل لكل عضو يوضح بياناته وتاريخه في المنصة.
- **Member Circles (جمعيات العضو):** عرض جميع الجمعيات اللي العضو مشترك فيها حالياً أو سابقاً.
- **Member Payments (مدفوعات العضو):** تتبع مدفوعات العضو بشكل فردي (ما تم دفعه، المتبقي، المتأخرات).

### 4. 🔄 Society & Circle Management (إدارة الجمعيات)
- **Create Jameya (إنشاء جمعية جديدة):** تأسيس وبناء جمعية جديدة وتحديد الشروط والمبالغ والمدة.
- **Full Lifecycle Control (التحكم في حالة الجمعية):**
  - **Activate (تفعيل):** تحويل الجمعية من حالة "مسودة" (Draft) إلى "نشطة" (Upcoming/Active).
  - **Pause (إيقاف مؤقت):** تجميد نشاط الجمعية وإيقاف العمليات مؤقتاً.
  - **End (إنهاء):** إغلاق الجمعية بعد اكتمال جميع أدوارها بنجاح.
  - **Delete / Cancel (حذف / إلغاء):** الحذف النهائي أو الإلغاء للجمعية في حالات الطوارئ.
- **Circle Details (تفاصيل الجمعية):** متابعة شاملة للجمعية تشمل عرض قائمة الأعضاء المشاركين فيها وتفاصيل كل دور (Role).

### 5. 💰 Financial Tracking & Metrics (التتبع المالي)
- **Installment Monitoring (مراقبة الأقساط):** تتبع الإجمالي المالي للجمعية عبر شريط تقدم (Progress).
- **Payment Badges (حالة المدفوعات):** 
  - إجمالي المبالغ المطلوبة (الإجمالي).
  - المبالغ القادمة (Upcoming).
  - المبالغ الجزئية/المعلقة (Pending).
  - المبالغ المكتملة المدفوعة (Completed).
- **Financial Reports:** شاشات ديناميكية تتحدث تلقائياً لتعكس الوضع المالي الحقيقي للجمعيات والأعضاء.

---

## 🏗️ Architecture & Folder Structure

This project follows the **MVVM (Model-View-ViewModel)** architectural pattern. This guarantees separation of logic from the UI, resulting in high testability and maintainability. ViewModels are implemented using **Cubit/Bloc**.

```text
lib/
 ├── core/                      # Global Configurations & Utilities
 │   ├── api/                   # Dio setup, Endpoints, and Interceptors
 │   ├── services/              # Dependency Injection (GetIt)
 │   ├── utils/                 # AppColors, Constants, and Theming
 │   └── widgets/               # Shared generic UI components (Buttons, Loaders)
 │
 ├── features/                  # App Features grouped by modules
 │   ├── auth/                  # Admin Login & Authentication
 │   ├── member_verification/   # KYC & Member Verification flow
 │   └── society_management/    # Circle (Jameya) Management & Financials
 │       ├── data/              # Models, Repositories, Data Sources (Model Layer)
 │       └── presentation/      
 │           ├── viewmodel/     # Cubit / Logic layer (ViewModel Layer)
 │           └── view/          # UI Screens and Widgets (View Layer)
 │
 └── main.dart                  # App Entry Point
```

---

## 🛠 Tech Stack & Libraries

We use the industry's best practices and most reliable packages:

- **State Management:** [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubit for logic isolation)
- **Dependency Injection:** [get_it](https://pub.dev/packages/get_it)
- **Networking:** [dio](https://pub.dev/packages/dio) (Robust HTTP requests & Interceptors)
- **Routing:** [go_router](https://pub.dev/packages/go_router) (Declarative deep-linking)
- **Responsive UI:** [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) (Pixel-perfect design across all devices)
- **Local Storage:** [shared_preferences](https://pub.dev/packages/shared_preferences) & `flutter_secure_storage`
- **UI Components:** `flutter_svg`, `shimmer`, `percent_indicator`, `google_fonts`

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>=3.9.0`
- Dart SDK `>=3.0.0`
- An active backend server for the Jameya Admin API Phase 1.

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/jameya-admin.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd jameya_admin
   ```

3. **Install dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🎨 UI & Localization
The app is designed **exclusively in Arabic (RTL)**. There is no multi-language support required, as the administration team operates natively in Arabic. It utilizes a custom color palette (`AppColors`), smooth animations, and interactive `SnackBar` feedback loops for every administrative action.

---

## 🤝 Contributing

This is a private repository for the Jameya administration team. If you are a team developer, please ensure that:
1. You create a new branch (`feature/TaskName`).
2. Follow the established MVVM architecture patterns (separating Models, ViewModels, and Views).
3. Submit a Pull Request for review.

---
<p align="center">Made with ❤️ for Jameya Administrators</p>
