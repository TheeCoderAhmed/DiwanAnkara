<div align="center">

# 🇾🇪 Diwan Ankara | ديوان أنقرة

**The Official App of the Union of Yemeni Students in Ankara.**
`<br>`
**التطبيق الرسمي لاتحاد الطلاب اليمنيين في أنقرة**

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)]()
[![Google Play](https://img.shields.io/badge/Google%20Play-Coming%20Soon-00ADF2?style=for-the-badge&logo=google-play&logoColor=white)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)](LICENSE)

[English](#-english) | [العربية](#-arabic)

</div>

---

`<a id="english"></a>`

## 🇬🇧 English

### ✨ About the Project

Welcome to **Diwan Ankara**, the official platform of the **Union of Yemeni Students in Ankara (اتحاد الطلاب اليمنيين)**. This application acts as a digital bridge, providing essential resources, real-time updates, and a unified space for the Yemeni student community and residents in Ankara.

Whether you are looking for the latest university news, community events, or a directory of local services, **Diwan Ankara** has you covered.

> [!TIP]
> **🚀 Coming Soon:** We are working hard to bring **Diwan Ankara** to the **Google Play Store** very soon! Stay tuned!

### 🚀 Key Features

The app is packed with features designed to support the student community:

*   **📢 Announcements Hook**: Instantly receive the latest news, official statements, and important updates.
*   **📅 Dynamic Events Calendar**: Keep track of workshops, gatherings, and celebrations.
*   **📒 Digital Directory**: A comprehensive guide to Yemeni businesses, student services, and contacts.
*   **📍 Places & Guidance**: Discover recommended locations, mosques, restaurants, and cultural centers.
*   **🎨 Personalized Experience**: Choose your preferred **language** and **theme** (Light, Dark, or System) during onboarding.
*   **🔔 Smart Notifications**: Real-time push notifications ensure you're always in the loop.
*   **📄 Resource Library**: Access and view important PDFs, guides, and documentation.
*   **🏗️ Projects & Committees**: View ongoing community projects and oversight committees.
*   **🌍 Multi-Language Support**: Fully localized in Arabic, English, and Turkish.

### 🛠️ Built With

We use a modern, robust tech stack to ensure performance, scalability, and security:

| Category                   | Technology                                                                                                                         |
| :------------------------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| **Framework**        | ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white) **Flutter** (Dart)      |
| **State Management** | ![Riverpod](https://img.shields.io/badge/Riverpod-%232D3748.svg?style=flat&logo=riverpod&logoColor=white) **flutter_riverpod** |
| **Backend / BaaS**   | ![Firebase](https://img.shields.io/badge/Firebase-%23039BE5.svg?style=flat&logo=firebase) **Firestore, Cloud Messaging**       |
| **Security**         | **Dart Define (Secure Secret Metadata)**                                                                                      |
| **Navigation**       | **GoRouter**                                                                                                                 |
| **UI Components**    | `flutter_animate`, `shimmer`, `google_fonts`, `lucide_icons`                                                               |

### 🔐 Security & Secrets

This project uses **Dart Define** to securely manage API keys and credentials. These are never committed to version control.

1.  Copy `secrets.json.example` to `secrets.json`.
2.  Fill in your Firebase API keys and other credentials.
3.  The `secrets.json` file is automatically ignored by Git.

### 🏁 Getting Started

1.  **Clone the repository**
    ```bash
    git clone https://github.com/your-username/yc_ankara_app.git
    cd yc_ankara_app
    ```
2.  **Install dependencies**
    ```bash
    flutter pub get
    ```
3.  **Run the application** (Required: Use secrets file)
    ```bash
    flutter run --dart-define-from-file=secrets.json
    ```

---

`<a id="arabic"></a>`

## 🇾🇪 العربية

### ✨ عن المشروع

مرحبًا بكم في **ديوان أنقرة**، المنصة الرسمية لـ **اتحاد الطلاب اليمنيين في أنقرة**. يعمل هذا التطبيق كجسر رقمي يوفر الموارد التعليمية والخدمية، والتحديثات الفورية، ومساحة موحدة للتفاعل بين الطلاب وأبناء الجالية اليمنية المقيمين في أنقرة.

> [!TIP]
> **🚀 قريباً:** نحن نعمل بجد لإطلاق **ديوان أنقرة** على **متجر جوجل بلاي** في القريب العاجل! انتظرونا!

### 🚀 المميزات الرئيسية

تطبيق متكامل بالمميزات المصممة لجعل الحياة أسهل وأكثر ترابطًا:

* **📢 منصة الإعلانات**: احصل فورًا على آخر الأخبار والبيانات الرسمية والتحديثات المهمة.
* **📅 تقويم الفعاليات**: تابع ورش العمل، والتجمعات، والاحتفالات.
* **📒 الدليل الرقمي**: دليل شامل للأعمال الطلابية، والخدمات، وجهات الاتصال.
* **📍 أماكن وإرشادات**: اكتشف المواقع الموصى بها، المساجد، المطاعم، والمراكز الثقافية.
* **🎨 تجربة مخصصة**: اختر **اللغة** و **المظهر** المفضل (فاتح، داكن، أو تلقائي) عند بدء الاستخدام.
* **🔔 إشعارات ذكية**: ابقَ على اطلاع دائم حتى عندما يكون التطبيق مغلقًا.
* **📄 مكتبة المصادر**: عرض ملفات PDF المهمة، والأدلة مباشرة داخل التطبيق.
* **🏗️ المشاريع واللجان**: استعرض مشاريع الجالية المستمرة وتعرف على لجان الرقابة.
* **🌍 دعم متعدد اللغات**: مترجم بالكامل (العربية والإنجليزية والتركية).

### 🔐 الأمان وإدارة المفاتيح

يستخدم هذا المشروع **Dart Define** لإدارة مفاتيح واجهة برمجة التطبيقات (API Keys) بشكل آمن. لا يتم رفع هذه المفاتيح مطلقاً إلى GitHub.

1.  قم بنسخ ملف `secrets.json.example` إلى `secrets.json`.
2.  قم بتعبئة مفاتيح Firebase والبيانات السرية الأخرى.
3.  يتم تجاهل ملف `secrets.json` تلقائياً بواسطة Git.

### 🏁 ابدأ الاستخدام

1. **نسخ المستودع**
   ```bash
   git clone https://github.com/your-username/yc_ankara_app.git
   cd yc_ankara_app
   ```
2. **تثبيت الحزم والمكتبات**
   ```bash
   flutter pub get
   ```
3. **تشغيل التطبيق** (يتطلب ملف المفاتيح)
   ```bash
   flutter run --dart-define-from-file=secrets.json
   ```

---

<p align="center">
  Made with ❤️ for the 🇾🇪 Community in Ankara
</p>
