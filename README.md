# Wlingo 🌍

**Wlingo** — это современное мобильное приложение на Flutter, разработанное для эффективного изучения иностранных языков. Основная концепция проекта заключается в изучении языка через погружение в чтение книг и интерактивную практику словарного запаса.

## ✨ Основные возможности

- 🔐 **Аутентификация:** Надежная система регистрации и входа пользователей через **Supabase Auth**.
- 📚 **Чтение книг (PDF Viewer):** Продвинутый просмотрщик PDF-файлов с поддержкой инструментов для обучения.
- 🗣️ **Голосовые функции:**
  - **Text-to-Speech (TTS):** Озвучивание текста для отработки произношения.
  - **Speech-to-Text:** Голосовой ввод для тренировки разговорной речи.
- 🧠 **Практика слов (Word Practice):** Интерактивные упражнения для закрепления изученной лексики.
- 🌐 **Локализация:** Полная поддержка русского и английского языков (L10n).
- 📶 **Мониторинг сети:** Динамическое отслеживание состояния интернет-соединения.
- 🌗 **Кастомизация:** Тщательно проработанная тема приложения с использованием Google Fonts.

## 🛠 Технологический стек

- **Core:** [Flutter](https://flutter.dev) (Dart)
- **State Management:** [Riverpod](https://riverpod.dev) (с использованием генераторов и хуков)
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router)
- **Backend/Database:** [Supabase](https://supabase.com)
- **Logging:** [Talker](https://pub.dev/packages/talker) (для продвинутого логирования)
- **PDF Engine:** [Syncfusion Flutter PDF Viewer](https://pub.dev/packages/syncfusion_flutter_pdfviewer)
- **Storage:** [Shared Preferences](https://pub.dev/packages/shared_preferences) & [Flutter Cache Manager](https://pub.dev/packages/flutter_cache_manager)

## 📁 Структура проекта

```text
lib/
├── core/             # Ядро приложения: роутер, провайдеры, общие модели
├── features/         # Функциональные модули (Auth, Home, BookView, Practice и др.)
├── l10n/             # Файлы локализации (ru, en)
├── theme/            # Конфигурация стилей и тем
├── widgets/          # Общие UI компоненты
└── app.dart          # Основной виджет приложения
```

## 🚀 Быстрый старт

### Требования
- Flutter SDK (последняя стабильная версия)
- Ключи доступа к проекту Supabase

### Установка

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/your-username/wlingo.git
   ```

2. Установите зависимости:
   ```bash
   flutter pub get
   ```

3. Запустите генерацию кода (Freezed, Riverpod, JSON):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Запустите приложение:
   ```bash
   flutter run
   ```