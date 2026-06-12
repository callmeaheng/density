# Density Flutter Client

This directory contains the Flutter source for the mobile client.

Generate native platform files after installing Flutter:

```bash
flutter create . --platforms=ios,android
flutter pub get
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:8000
```

Use a production HTTPS URL for App Store builds:

```bash
flutter build ipa --release --dart-define=API_BASE_URL=https://api.example.com
```
