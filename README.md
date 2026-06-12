# Density

Density is a mobile-first full-stack application by callmeaheng.

- Backend: Python + Django REST Framework
- Frontend: Flutter
- Runtime: Docker Compose for the API
- App target: iOS and Android, ready to generate native projects with Flutter

## Project Layout

```text
backend/          Django API
frontend/         Flutter client
docker-compose.yaml
.env.example
```

## Local Backend

```bash
cp .env.example .env
python3 -m venv backend/.venv
backend/.venv/bin/python -m pip install -r backend/requirements.txt
cd backend
.venv/bin/python manage.py migrate
.venv/bin/python manage.py runserver 0.0.0.0:8000
```

Open:

- http://127.0.0.1:8000/api/health/
- http://127.0.0.1:8000/api/home/

## Docker Backend

```bash
cp .env.example .env
docker compose up --build
```

The API will be available at http://127.0.0.1:8000.

## Flutter App

Install Flutter first, then generate the native platform folders:

```bash
cd frontend
flutter create . --platforms=ios,android
flutter pub get
flutter run --dart-define=API_BASE_URL=http://127.0.0.1:8000
```

For an iOS simulator, `127.0.0.1` points to your Mac. For a physical device, use your Mac LAN IP or a deployed HTTPS API URL.

## App Store Path

1. Generate iOS files with `flutter create . --platforms=ios`.
2. Set a real bundle identifier in Xcode.
3. Use a production API URL:

```bash
flutter build ipa --release --dart-define=API_BASE_URL=https://api.example.com
```

4. Archive and upload with Xcode Organizer or Transporter.
