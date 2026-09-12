# 🚀 Ayush Panchal - Personal Portfolio Website

A modern, responsive, high-performance portfolio website built with **Flutter Web** and **GetX**. Designed to showcase software engineering experience, enterprise and academic projects, technical skills, and interactive UI components.

---

## 🌟 Key Features

- **Responsive Architecture**: Adaptive layout (`ResponsiveHelper`) optimized across Mobile, Tablet, and Desktop screens.
- **Dynamic Project Showcase**: Structured project cards loaded from `assets/projects.json` featuring modal detail views, tech stack tags, and confidential project notices.
- **Experience & Resume Section**: Career timeline highlighting enterprise contributions, product modules, and technical accomplishments.
- **Interactive Easter Egg**: Custom built-in Flutter Snake Game widget.
- **Modern UI/UX**: Dark theme aesthetic, custom gradients (`AppGradients`), typography (`Google Fonts`), and typewriter header animations.
- **State Management**: Fast and reactive state handling powered by **GetX**.

---

## 🛠️ Tech Stack & Dependencies

- **Framework**: Flutter Web (Dart)
- **State Management**: [GetX](https://pub.dev/packages/get) (`^4.6.5`)
- **Typography & Icons**: `google_fonts`, `font_awesome_flutter`
- **Utilities**: `url_launcher`, `http`
- **Full-Stack Competencies**: Flutter, REST APIs, Django, Firebase, MySQL, Bootstrap

---

## 📁 Directory Structure

```text
Portfolio/
├── assets/
│   ├── images/              # Profile pictures, company logos, and tech badges
│   └── projects.json        # Structured JSON dataset for portfolio projects
├── lib/
│   ├── main.dart            # Application entry point
│   └── app/
│       ├── data/            # Data models (Project model)
│       ├── modules/         # Page views & GetX controllers
│       ├── theme/           # App colors, dark themes, and custom gradients
│       ├── utils/           # Responsive helper utilities
│       └── widgets/         # Modular components (Hero, About, Resume, Projects, Snake Game, Footer)
├── web/                     # HTML index, manifests, and favicon assets
└── pubspec.yaml             # Flutter project dependencies and asset registrations
```

---

## 💻 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.0.0 < 4.0.0`)
- Google Chrome or any modern web browser

### Run Locally

1. **Clone repository**:
   ```bash
   git clone https://github.com/ayushpanchal-dev/portfolio.git
   cd portfolio
   ```

2. **Fetch dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run on Chrome**:
   ```bash
   flutter run -d chrome
   ```

4. **Build for Web Deployment**:
   ```bash
   flutter build web --release
   ```

---

## 👤 Author

**Ayush Panchal**
- GitHub: [@ayushpanchal-dev](https://github.com/ayushpanchal-dev)

