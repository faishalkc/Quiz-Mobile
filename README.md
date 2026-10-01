# Quiz Mobile (Flutter)

A simple Flutter-based quiz application that combines Firebase Realtime Database with a MySQL authentication system. Users can create an account, log in, answer randomized quiz questions, and view their final score after completing the quiz.

## Features

- User authentication (Login & Register)
- MySQL-based user management through PHP API
- Quiz questions stored in Firebase Realtime Database
- Randomized question order for each quiz session
- Real-time score tracking
- Final result screen after completing all questions
- Clean and simple Flutter UI

## Tech Stack

- Flutter
- Dart
- Firebase Realtime Database
- MySQL
- PHP REST API
- HTTP Package
- WebView Flutter

## Application Flow

1. User registers an account.
2. User logs into the application.
3. Quiz questions are fetched from Firebase.
4. Questions are shuffled randomly.
5. User answers each question.
6. The application calculates the score.
7. The final score is displayed at the end of the quiz.

## Project Structure

```
lib/
├── models/
│   ├── db_connect.dart
│   └── question_model.dart
├── widgets/
│   ├── question_widget.dart
│   ├── option_card.dart
│   ├── next_button.dart
│   └── result_box.dart
├── login.dart
├── register.dart
├── inpage.dart
├── constants.dart
└── main.dart
```

## Backend

This project uses two different backend services:

- **MySQL + PHP**
  - User Login
  - User Registration

- **Firebase Realtime Database**
  - Quiz question storage
  - Question retrieval

## Dependencies

- flutter
- http
- webview_flutter

## Getting Started

```bash
git clone https://github.com/faishalkc/quiz-mobile.git

cd quiz-mobile

flutter pub get

flutter run
```

## Notes

This project was developed as a university assignment to demonstrate the integration of Flutter with multiple backend technologies, including Firebase Realtime Database and a MySQL-based authentication system.
