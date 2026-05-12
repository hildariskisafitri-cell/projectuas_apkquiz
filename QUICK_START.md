# 🚀 QUICK START GUIDE - QUIZ MASTER

## ⚡ Jalankan Aplikasi dalam 3 Langkah

### Langkah 1: Buka Terminal
```bash
cd c:\Users\DELL\Music\projectapk\apkuas
```

### Langkah 2: Get Dependencies (jika belum)
```bash
flutter pub get
```

### Langkah 3: Run Application
```bash
flutter run
```

✅ **Aplikasi akan terbuka dalam hitungan detik!**

---

## 📱 Fitur Utama yang Bisa Dicoba

### 1️⃣ **Login Screen**
- Masukkan nama: "Budi"
- Masukkan email: "budi@email.com"
- Tap **Login** (atau skip dengan "Lanjutkan tanpa login")

### 2️⃣ **Home Screen**
- Pilih kategori (Umum, Matematika, Sains, dll)
- Lihat statistik user jika sudah login
- Tap **Mulai Kuis**

### 3️⃣ **Quiz Screen**
- Lihat soal dengan timer countdown
- Pilih jawaban (highlight akan berubah)
- Progress bar menunjukkan progress
- Tap **Berikutnya** untuk soal berikutnya
- Tap **Selesai** di soal terakhir

### 4️⃣ **Result Screen**
- Lihat skor final dengan grade
- Lihat detail: benar/salah/waktu
- Lihat statistik user (jika ada history)
- **Kuis Lagi** atau **Kembali Beranda**

---

## 🎮 Test Scenarios

### Test Scenario 1: Basic Quiz
```
1. Tap "Lanjutkan tanpa login"
2. Pilih kategori "Umum"
3. Tap "Mulai Kuis"
4. Jawab semua 8 soal dengan memilih opsi
5. Tap "Selesai"
6. Lihat hasil skor
```

### Test Scenario 2: Dengan Login
```
1. Input nama dan email di login screen
2. Tap Login
3. Lihat greeting di home screen
4. Mulai kuis (statistik akan tercatat)
5. Selesaikan quiz
6. Lihat statistik terupdate
7. Mulai kuis lagi → statistik akan terakumulasi
```

### Test Scenario 3: Timer Test
```
1. Mulai quiz
2. Lihat timer di top right (format: M:SS)
3. Perhatikan warna: 
   - 🟢 Hijau: waktu cukup (>50%)
   - 🟠 Orange: waktu kurang (<50%)
   - 🔴 Merah: waktu hampir habis (<20%)
4. Soal 8 detik akan habis dan ke soal berikutnya otomatis
```

---

## 🎨 Customization Cepat

### Ubah Jumlah Soal
File: `lib/services/quiz_service.dart`
- Tambah Question objects di getDummyQuestions()

### Ubah Warna Tema
File: `lib/main.dart` line 23
```dart
seedColor: const Color(0xFF6C63FF)  // Ganti warna ini
```

### Ubah Waktu Per Soal
File: `lib/models/question.dart`
```dart
timeLimit: 30,  // Ubah dari 30 ke nilai lain (detik)
```

### Ubah Kategori
File: `lib/views/home_screen.dart` line 29
```dart
final List<String> categories = [
  'Umum',        // Tambah/ubah kategori di sini
  'Matematika',
  'Sains',
  'Geografi',
  'Sejarah',
  'TAMBAH_KATEGORI_BARU',
];
```

---

## 🐛 Troubleshooting

### ❌ Error: "flutter: command not found"
**Solusi**: Install Flutter atau tambah ke PATH

### ❌ Error: Dependencies issue
**Solusi**: 
```bash
flutter pub get
flutter pub upgrade
```

### ❌ UI looks weird
**Solusi**: 
```bash
flutter clean
flutter pub get
flutter run
```

### ❌ Timer tidak jalan
**Solusi**: Pastikan QuizScreen sudah di-build (tidak error di console)

---

## 📚 File Penting

| File | Fungsi |
|------|--------|
| `lib/main.dart` | Entry point + Provider setup |
| `lib/views/quiz_screen.dart` | Screen kuis utama |
| `lib/viewmodels/quiz_viewmodel.dart` | Quiz logic + timer |
| `lib/services/quiz_service.dart` | Soal kuis |
| `lib/models/question.dart` | Question data model |

---

## 💡 Tips & Tricks

1. **Hot Reload**: Ubah code → Save → Soal langsung ter-update UI (tapi state tetap)
2. **Hot Restart**: Restart total app (state reset)
3. **Debug Print**: Tambahkan `print()` untuk debug
4. **Provider Inspect**: Gunakan `Consumer` untuk lihat state changes

---

## ✅ Status

```
✅ Code Quality: ZERO ISSUES (flutter analyze)
✅ Dependencies: ALL RESOLVED (flutter pub get)
✅ Compilation: CLEAN (no errors)
✅ Ready: YES (siap run)
```

---

## 🎓 Struktur Pembelajaran

Jika ingin belajar dari kode ini:

1. **Mulai dari**: `lib/main.dart` - Setup Provider
2. **Kemudian**: `lib/views/login_screen.dart` - Simple screen
3. **Lanjut ke**: `lib/views/home_screen.dart` - Category selection
4. **Pelajari**: `lib/viewmodels/quiz_viewmodel.dart` - State management
5. **Deep dive**: `lib/views/quiz_screen.dart` - Complex logic
6. **Finish**: `lib/views/result_screen.dart` - Results handling

---

## 🚀 Next Steps (Optional)

Untuk upgrade aplikasi:

1. **Add Firebase** untuk cloud storage
2. **Add SQLite** untuk persistent storage
3. **Add Images** untuk quiz questions
4. **Add Leaderboard** untuk competition
5. **Add Push Notifications** untuk reminders
6. **Add Share Feature** untuk share scores

---

**SIAP UNTUK DIMULAI! 🎉**

```bash
flutter run
```

Enjoy Quiz Master! 🎓
