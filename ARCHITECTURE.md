# Quiz Master - Dokumentasi Lengkap

## 📋 Ringkasan Proyek
Quiz Master adalah aplikasi mobile Flutter untuk membuat dan mengikuti kuis interaktif dengan fitur-fitur lengkap seperti timer, scoring system, dan tracking statistik pengguna.

## 🏗️ Arsitektur Proyek

### Clean Architecture + MVVM Pattern
Proyek ini menggunakan kombinasi Clean Architecture dan MVVM (Model-View-ViewModel) untuk memisahkan concern dan membuat kode lebih maintainable.

```
lib/
├── models/              # Data models
│   ├── question.dart    # Model untuk soal kuis
│   ├── user.dart        # Model untuk user
│   └── quiz_score.dart  # Model untuk skor kuis
├── views/              # Presentation layer (Screens)
│   ├── login_screen.dart      # Layar login
│   ├── home_screen.dart       # Layar beranda dengan kategori
│   ├── quiz_screen.dart       # Layar utama kuis
│   └── result_screen.dart     # Layar hasil & statistik
├── widgets/            # Reusable UI components
│   ├── quiz_button.dart      # Tombol kuis custom
│   ├── progress_bar.dart     # Progress bar untuk soal
│   ├── option_card.dart      # Kartu pilihan jawaban
│   └── timer_widget.dart     # Widget timer countdown
├── viewmodels/         # Business logic (MVVM)
│   ├── quiz_viewmodel.dart   # Mengelola state kuis & timer
│   └── user_viewmodel.dart   # Mengelola user & skor
├── services/           # Data layer
│   └── quiz_service.dart     # Fetch data (API/Database)
└── main.dart           # Entry point dengan Provider setup
```

## 🎯 Fitur Utama

### 1. **Quiz Engine**
- ✅ Randomization: Mengacak urutan soal dan pilihan jawaban
- ✅ Timer: Countdown timer per sesi kuis dengan visual warning
- ✅ Scoring System: Kalkulasi skor otomatis dengan persentase

### 2. **User Interface**
- 🔐 Login Screen: Login dengan nama dan email
- 🏠 Home Screen: Pemilihan kategori dan start kuis
- 📝 Quiz Screen: Menampilkan soal, pilihan, dan progress bar
- 🎓 Result Screen: Statistik skor dan kemampuan replay

### 3. **State Management**
- Provider untuk QuizViewModel: Mengelola quiz state, timer, scoring
- Provider untuk UserViewModel: Mengelola user data dan history skor

### 4. **Data Models**

#### Question
```dart
class Question {
  final String id;           // ID unik soal
  final String text;         // Pertanyaan
  final List<String> options;// Pilihan jawaban
  final int correctAnswerIndex; // Index jawaban benar
  final int timeLimit;       // Batas waktu per soal (detik)
}
```

#### User
```dart
class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
}
```

#### QuizScore
```dart
class QuizScore {
  final String id;
  final String userId;
  final int correctAnswers;
  final int totalQuestions;
  final double percentage;
  final int timeTaken;       // Waktu pengerjaan (detik)
  final DateTime completedAt;
}
```

## 🎮 Alur Aplikasi

### 1. **Login/Start**
User melakukan login atau melanjutkan tanpa login → Home Screen

### 2. **Home Screen**
- Pilih kategori kuis
- Klik "Mulai Kuis"
- Fetch soal dari QuizService

### 3. **Quiz Screen**
- Timer dimulai otomatis
- User memilih jawaban
- Navigasi antar soal dengan Previous/Next
- Klik "Selesai" untuk submit

### 4. **Result Screen**
- Tampilkan skor final dengan grade
- Detail: Jumlah soal, jawaban benar/salah
- Statistik pengguna (rata-rata, best score)
- Opsi untuk kuis lagi atau kembali ke home

## 🔧 Tech Stack

| Komponen | Teknologi |
|----------|-----------|
| Framework | Flutter (Dart) |
| State Management | Provider 6.0.0 |
| Architecture | Clean Architecture + MVVM |
| UI Components | Material Design 3 |
| Database | Lokal (dummy data, expandable) |

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

## 🚀 Setup & Running

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Run Application
```bash
flutter run
```

### 3. Build APK
```bash
flutter build apk
```

## 📱 Fitur Fase Demi Fase

### ✅ Fase 1: UI Mockup (Selesai)
- StatelessWidget untuk layar statis (ResultScreen UI)
- StatefulWidget untuk layar dinamis (QuizScreen)
- Custom widgets untuk reusability

### ✅ Fase 2: Quiz Logic (Selesai)
- Pindah soal saat option diklik
- Pengecekan jawaban (benar/salah)
- Tracking jawaban user
- Kalkulasi skor otomatis

### ✅ Fase 3: State Management (Selesai)
- Provider untuk QuizViewModel
- Provider untuk UserViewModel
- Access state dari multiple screens tanpa prop drilling

### 🚧 Fase 4: Final Touch (Partial)
- ✅ Countdown Timer dengan visual warning
- 🔄 Animasi transisi (dapat ditambahkan dengan AnimatedSwitcher)
- 📊 Statistik mendalam (dapat diperluas)

## 🔌 Extensibility

### Menambah Kategori Baru
Edit `lib/services/quiz_service.dart` → `getDummyQuestions()`:
```dart
if (category == 'Matematika') {
  return mathQuestions;
} else if (category == 'IPA') {
  return scienceQuestions;
}
```

### Integrasi API/Database
Replace dummy data di `QuizService.fetchQuestions()`:
```dart
Future<List<Question>> fetchQuestions({String? category}) async {
  final response = await http.get(Uri.parse('$apiUrl/quizzes'));
  return (response.json()['data'] as List)
      .map((q) => Question.fromJson(q))
      .toList();
}
```

### Menambah Fitur Analytics
Extend `UserViewModel.addScore()`:
```dart
void addScore(QuizScore score) {
  _userScores.add(score);
  _analyticsService.trackQuizCompletion(score);
  notifyListeners();
}
```

## 🎨 Customization

### Warna Tema
Ubah primary color di `main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
```

### Font Custom
Tambah di `pubspec.yaml`:
```yaml
fonts:
  - family: CustomFont
    fonts:
      - asset: assets/fonts/CustomFont-Regular.ttf
```

## 🐛 Troubleshooting

### Timer tidak berjalan
Pastikan `QuizViewModel.startQuiz()` dipanggil di `initState` QuizScreen.

### State tidak update
Gunakan `Consumer<ViewModel>` atau `.watch()` dari Provider.

### Navigasi error
Pastikan semua screen ada di context dengan Provider wrapping.

## 📚 Referensi Kode

### Menggunakan QuizViewModel
```dart
context.read<QuizViewModel>().selectAnswer(0);
context.watch<QuizViewModel>().currentQuestion;
```

### Menggunakan UserViewModel
```dart
context.read<UserViewModel>().loginUser('John', 'john@email.com');
context.watch<UserViewModel>().getAverageScore();
```

## 📝 Lisensi
Open source untuk penggunaan pendidikan

---

**Created:** May 2026
**Version:** 1.0.0
