# Quiz Master - Panduan Implementasi Lengkap

## 📖 Petunjuk Penggunaan Aplikasi

### 1️⃣ **Login / Mulai Tanpa Login**
```
┌─────────────────────────────────┐
│   Quiz Master                   │
│   Selamat datang kembali!       │
├─────────────────────────────────┤
│ Nama Anda: [Input nama]         │
│ Email:     [Input email]        │
│                                 │
│ [    Login    ]                 │
│ Lanjutkan tanpa login           │
└─────────────────────────────────┘
```

**Opsi:**
- ✅ Login: Simpan data user untuk tracking statistik
- 📱 Tanpa Login: Lanjut langsung ke home (anonim)

### 2️⃣ **Home Screen - Pilih Kategori**
```
┌─────────────────────────────────┐
│ Quiz Master                     │
│ Test pengetahuan Anda           │
├─────────────────────────────────┤
│ Selamat datang, [Nama User]!   │
│ Kuis diselesaikan: 2            │
│ Rata-rata skor: 85.5%          │
├─────────────────────────────────┤
│ Pilih Kategori:                 │
│ [Umum] [Matematika] [Sains]    │
│ [Geografi] [Sejarah]           │
├─────────────────────────────────┤
│ [    Mulai Kuis    ]            │
│ [    Logout         ]           │
└─────────────────────────────────┘
```

**Fitur:**
- 6 kategori tersedia (expandable)
- Statistik user (jika login)
- Logout button

### 3️⃣ **Quiz Screen - Jawab Soal**
```
┌─────────────────────────────────┐
│ Kuis                    [⏱ 3:45] 3/8
├─────────────────────────────────┤
│ Soal 3 dari 8                   │
│ ▓▓▓░░░░░░░░░░░░░░░░░░ 37%      │
├─────────────────────────────────┤
│ Ibu kota Indonesia adalah?      │
│                                 │
│ ┌─────────────────────────────┐ │
│ │ A Surabaya                  │ │
│ └─────────────────────────────┘ │
│ ┌─────────────────────────────┐ │
│ │ B Jakarta         ✓(selected)│ │
│ └─────────────────────────────┘ │
│ ┌─────────────────────────────┐ │
│ │ C Bandung                   │ │
│ └─────────────────────────────┘ │
│ ┌─────────────────────────────┐ │
│ │ D Medan                     │ │
│ └─────────────────────────────┘ │
├─────────────────────────────────┤
│ [  Sebelumnya  ]  [ Berikutnya ] │
│                   (atau Selesai) │
└─────────────────────────────────┘
```

**Fitur:**
- ⏱ Timer real-time dengan warning (merah saat < 20%)
- 📊 Progress bar visual
- 🔘 Seleksi jawaban dengan visual feedback
- ◀️▶️ Navigasi soal
- ✅ Pengecekan jawaban otomatis

### 4️⃣ **Result Screen - Lihat Skor**
```
┌─────────────────────────────────┐
│              85.5%              │
│         Sangat Baik!            │
│        [   ◯   ]                │
│                                 │
├─────────────────────────────────┤
│ Total Soal:        8            │
│ Benar:            7             │
│ Salah:            1             │
│ Waktu:    3 menit 45 detik     │
├─────────────────────────────────┤
│ Statistik Anda                  │
│ ┌───────────────────────────────┤
│ │ Kuis Diselesaikan:     4      │
│ │ Rata-rata Skor:   82.3%      │
│ │ Skor Terbaik:      90.0%      │
│ └───────────────────────────────┤
├─────────────────────────────────┤
│ [  Kuis Lagi   ]                │
│ [ Kembali Beranda ]             │
└─────────────────────────────────┘
```

**Info:**
- 🎯 Score dengan grade classification
- 📈 Statistik menyeluruh user
- 🔄 Opsi untuk ulangi atau kembali

## 🔧 Panduan Implementasi Kode

### A. Setup Awal (main.dart)

```dart
// Setup Provider dengan MultiProvider
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => QuizViewModel()),
    ChangeNotifierProvider(create: (_) => UserViewModel()),
  ],
  child: MaterialApp(...)
)
```

### B. Mengakses State

#### Read (Satu kali)
```dart
final score = context.read<QuizViewModel>().finishQuiz();
```

#### Watch (Reactive)
```dart
context.watch<QuizViewModel>().currentQuestionIndex
```

#### Consumer (Best Practice)
```dart
Consumer<QuizViewModel>(
  builder: (context, quizViewModel, child) {
    return Text(quizViewModel.currentQuestion.text);
  }
)
```

### C. Menambah Soal Baru

File: `lib/services/quiz_service.dart`

```dart
Question(
  id: '9',
  text: 'Pertanyaan baru?',
  options: ['Opsi A', 'Opsi B', 'Opsi C', 'Opsi D'],
  correctAnswerIndex: 2, // Index jawaban benar (0-3)
  timeLimit: 30,
)
```

### D. Custom Widget Usage

#### QuizButton
```dart
QuizButton(
  label: 'Mulai',
  onPressed: () {},
  backgroundColor: Colors.blue,
)
```

#### OptionCard
```dart
OptionCard(
  optionText: 'Jawaban A',
  optionIndex: 0,
  isSelected: true,
  isCorrect: true,
  showResult: false,
  onTap: () => viewModel.selectAnswer(0),
)
```

#### TimerWidget
```dart
TimerWidget(
  remainingSeconds: 45,
  totalSeconds: 60,
)
```

## 🎓 Contoh Use Case

### Use Case 1: Menampilkan Pertanyaan
```
1. User tap "Mulai Kuis"
2. QuizService.fetchQuestions() dipanggil
3. QuizViewModel.initializeQuiz() dijalankan
4. Navigator push ke QuizScreen
5. QuizScreen.initState() → quizViewModel.startQuiz()
6. Timer dimulai, soal ditampilkan
```

### Use Case 2: Menjawab Soal
```
1. User tap pilihan (OptionCard)
2. quizViewModel.selectAnswer(index) dipanggil
3. selectedAnswers[currentIndex] = index
4. Notifier update → UI rebuild
5. OptionCard menampilkan selected state
```

### Use Case 3: Selesai Kuis
```
1. User tap "Selesai" pada soal terakhir
2. quizViewModel.finishQuiz() dipanggil:
   - Timer dibatalkan
   - Skor dihitung
   - Waktu pengerjaan dicatat
3. QuizScore object dibuat
4. Navigator push ke ResultScreen
5. UserViewModel.addScore() menyimpan skor
6. Result ditampilkan dengan statistik
```

## 🚀 Cara Testing

### Test Login
1. Jalankan app
2. Input nama: "Budi" dan email: "budi@email.com"
3. Tap Login
4. Cek home screen menampilkan greeting

### Test Quiz
1. Pilih kategori
2. Tap "Mulai Kuis"
3. Jawab beberapa soal
4. Cek timer berjalan
5. Tap "Selesai"
6. Verifikasi skor dihitung benar

### Test Navigation
1. Login → Home → Quiz → Result → Home
2. Logout dari home
3. Reset app

## 📝 Tips & Tricks

### Debug Timer Issues
Tambah print di QuizViewModel._startTimer():
```dart
void _startTimer() {
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    print('Remaining: $_remainingSeconds'); // Debug
    _remainingSeconds--;
  });
}
```

### Hot Reload vs Hot Restart
- **Hot Reload**: Ubah UI saja, state tetap
- **Hot Restart**: Reset total, state kembali default (gunakan ini untuk reset kuis)

### Tambah Print untuk Debug
```dart
debugPrint('Quiz started with ${_questions.length} questions');
```

## 🎨 Customization Cepat

### Ubah Warna Primary
File: `main.dart`
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.deepOrange // Ubah ini
)
```

### Ubah Jumlah Soal
File: `quiz_service.dart`
```dart
// Duplicate Question di getDummyQuestions()
```

### Ubah Waktu Per Soal
File: `models/question.dart`
```dart
timeLimit: 45, // Dari 30 menjadi 45 detik
```

## ✅ Checklist Implementasi

- [x] Folder structure sesuai Clean Architecture
- [x] Models (Question, User, QuizScore)
- [x] ViewModels dengan Provider
- [x] Widgets reusable
- [x] Services untuk data handling
- [x] 4 main screens (Login, Home, Quiz, Result)
- [x] Timer countdown dengan visual
- [x] Scoring system otomatis
- [x] Navigation antar screens
- [x] User statistics tracking
- [x] Responsive UI

## 🔜 Feature Roadmap (Optional)

- [ ] Database lokal (SQLite) untuk persistent storage
- [ ] Firebase integration
- [ ] Image/Video dalam soal
- [ ] Leaderboard
- [ ] Achievement badges
- [ ] Offline mode
- [ ] Share score ke social media
- [ ] Export hasil ke PDF

---

**Dokumentasi ini lengkap untuk Fase 1-4 Development**
