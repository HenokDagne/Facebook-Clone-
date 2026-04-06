# Facebook Clone

A full-featured Facebook clone built with Flutter and Firebase.

## 🚀 Overview

This project replicates core features of Facebook, including:

- News Feed (now fetched live from a third-party API)
- Stories
- User Authentication (Sign Up, Login)
- Notifications
- People/Contacts
- Profile Pages

## 📸 Screenshots & Demo

Watch the demo video:

[![Demo Video](https://img.youtube.com/vi/h_Qt7FwxamU/0.jpg)](https://youtube.com/shorts/h_Qt7FwxamU?feature=share)

<!-- Add screenshots or demo GIFs here -->

## 🛠️ Tech Stack

- **Flutter** (cross-platform UI)
- **Firebase** (authentication, backend)
- **Dart** (programming language)
- **NewsAPI.org** (live news feed)

## 🏁 Getting Started

### Prerequisites

- Flutter SDK (https://flutter.dev/docs/get-started/install)
- Dart SDK
- Firebase account & project

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/facebook_clone.git
   cd facebook_clone
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Configure Firebase:
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective folders.
4. Run the app:
   ```bash
   flutter run
   ```

## 🌐 News Feed Source

**Note:** The News Feed is now fetched live from [NewsAPI.org](https://newsapi.org/). The app no longer uses the local `asset/news.json` file. Instead, it retrieves the latest news articles using the NewsAPI endpoint:

```
https://newsapi.org/v2/everything?q=tesla&from=2026-02-27&sortBy=publishedAt&apiKey=YOUR_API_KEY
```

You can change the query or API key in `lib/news_api_handler.dart`.

**Why this change?**

- Ensures the news feed is always up-to-date with real-world news.
- Demonstrates integration with external REST APIs in Flutter.

**How it works:**

- The app uses the [`http`](https://pub.dev/packages/http) package to fetch news from NewsAPI.
- News data is parsed and displayed in the News Feed section.

## 📁 Folder Structure

```
lib/
  main.dart
  login_page.dart
  signup.dart
  news_feed.dart
  stories_page.dart
  notification.dart
  people_page.dart
  facebook_page.dart
  firebase_options.dart
asset/
  images/
  news.json
android/
ios/
web/
test/
```

## 🤝 Contribution Guidelines

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Credits

- Flutter team for the framework
- Firebase for backend services
