<div align="center">

# 🇾🇪 Diwan Ankara | ديوان أنقرة

**The Official Digital Infrastructure for the Union of Yemeni Students in Ankara**
`<br>`
**المنصة الرقمية الرسمية لاتحاد الطلاب اليمنيين في أنقرة**

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge)](LICENSE)

[English](#-english) | [العربية](#-arabic)

</div>

---

<a id="english"></a>

## 🇬🇧 English

### Overview
**Diwan Ankara** is the official mobile application of the **Union of Yemeni Students in Ankara**. It serves as a comprehensive digital ecosystem designed to consolidate essential academic, social, and logistical resources for the Yemeni student community and broader expatriate resident population in Ankara, Turkey.

The initiative aims to enhance community connectivity, streamline information dissemination, and provide a centralized gateway for institutional updates and local guidance.

### Core Functional Modules
The application architecture is structured around several critical service pillars:

*   **Institutional Communications**: A centralized channel for official announcements, statements, and administrative updates.
*   **Operational Calendar**: A systematic schedule of academic workshops, community gatherings, and cultural events.
*   **Civic Directory**: A verified repository of student services, Yemeni businesses, and professional contacts.
*   **Urban Navigation & Support**: Curated guidance for essential locations, including academic institutions, religious centers, and culinary services.
*   **Adaptive UI/UX**: Sophisticated onboarding with support for dynamic theme switching (Light, Dark, System) and granular language preferences.
*   **Automated Notifications**: Real-time push notification infrastructure for critical alerts and community updates.
*   **Document Management**: Integrated viewer for official PDF resources, procedural guides, and legal documentation.
*   **Governance & Transparency**: Documentation of ongoing community projects and active oversight committees.
*   **Localization**: Native support for Arabic, English, and Turkish languages.

### Technical Specification
The platform utilizes a modern software stack optimized for cross-platform performance and industrial-grade security.

| Layer | Specification |
| :--- | :--- |
| **Framework** | **Flutter** (Dart SDK) |
| **State Architecture** | **Riverpod** (Functional Reactive Programming) |
| **Backend Services** | **Firebase** (Firestore, Cloud Messaging) |
| **Security Protocol** | **Dart Define** (Environment Variable Encapsulation) |
| **Routing Management** | **GoRouter** (Declarative Routing) |
| **Enhanced UX** | `flutter_animate`, `shimmer`, `google_fonts`, `lucide_icons` |

### Security Configuration
This repository implements strict security standards. Sensitive credentials and API keys are managed via **Dart Define** and are excluded from version control to maintain system integrity.

1.  Initialize local environment: `cp secrets.json.example secrets.json`
2.  Configure necessary environment variables within `secrets.json`.
3.  Note that `secrets.json` is pre-configured in `.gitignore` to prevent accidental disclosure.

### Deployment & Execution

1.  **Repository Acquisition**
    ```bash
    git clone https://github.com/TheeCoderAhmed/DiwanAnkara.git
    cd DiwanAnkara
    ```
2.  **Dependency Synchronization**
    ```bash
    flutter pub get
    ```
3.  **Development Execution** (Requires secure definition file)
    ```bash
    flutter run --dart-define-from-file=secrets.json
    ```

---

<a id="arabic"></a>

## 🇾🇪 العربية

### نظرة عامة
**ديوان أنقرة** هو التطبيق الرسمي لـ **اتحاد الطلاب اليمنيين في أنقرة**. يمثل المشروع بيئة رقمية متكاملة تهدف إلى توحيد الموارد الأكاديمية والاجتماعية واللوجستية الأساسية لمجتمع الطلاب اليمنيين والمقيمين في العاصمة التركية أنقرة.

يهدف هذا التطبيق إلى تعزيز الروابط المجتمعية، وتسهيل الوصول إلى المعلومات، وتوفير بوابة مركزية للتحديثات المؤسسية والإرشادات المحلية.

### الوحدات الوظيفية الرئيسية
تم تصميم هيكلية التطبيق لخدمة عدة ركائز أساسية:

*   **الاتصال المؤسسي**: قناة مركزية للإعلانات الرسمية، البيانات، والتحديثات الإدارية.
*   **التقويم التشغيلي**: جدول زمني منظم لورش العمل الأكاديمية، التجمعات المجتمعية، والفعاليات الثقافية.
*   **الدليل الرقمي**: مستودع موثق للخدمات الطلابية، المصالح التجارية، وجهات الاتصال المهنية.
*   **الإرشاد والتوجيه**: أدلة منسقة للمواقع الحيوية بما في ذلك المؤسسات الأكاديمية، المراكز الدينية، والمرافق الخدمية.
*   **تجربة المستخدم التكيفية**: واجهة متطورة تدعم التبديل بين الأنماط (فاتح، داكن، تلقائي) وتخصيص اللغة.
*   **الإشعارات الأوتوماتيكية**: بنية تحتية للإشعارات الفورية للتنبيهات العاجلة وتحديثات المجتمع.
*   **إدارة المستندات**: قارئ مدمج للملفات الرسمية (PDF)، الأدلة الإجرائية، واللوائح القانونية.
*   **الحوكمة والشفافية**: استعراض المشاريع المجتمعية القائمة واللجان الرقابية النشطة.
*   **التعريب والتدويل**: دعم كامل للغات العربية، الإنجليزية، والتركية.

### المواصفات التقنية
تعتمد المنصة على بنية تقنية حديثة مصممة للأداء العالي والأمان المستدام.

| الطبقة التقنية | التقنية المستخدمة |
| :--- | :--- |
| **إطار العمل** | **Flutter** (Dart SDK) |
| **إدارة الحالة** | **Riverpod** |
| **خدمات الخلفية** | **Firebase** (Firestore, Cloud Messaging) |
| **بروتوكول الأمان** | **Dart Define** (تشفير المتغيرات البيئية) |
| **إدارة التنقل** | **GoRouter** |

---

<p align="center">
  Developed for the 🇾🇪 Community in Ankara
</p>
