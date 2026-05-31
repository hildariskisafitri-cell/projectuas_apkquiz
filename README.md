ThinkUP

1. Arsitektur & Struktur Proyek
Untuk skala akademis, disarankan menggunakan pola Clean Architecture atau MVVM (Model-View-ViewModel). Ini memisahkan logika bisnis dari tampilan (UI).
Struktur Folder:
lib/models/: Definisi data (Pertanyaan, User, Skor).
lib/views/: Layar aplikasi (Home, Quiz, Result).
lib/widgets/: Komponen UI yang dapat digunakan kembali (Tombol kuis, Progress bar).
lib/viewmodels/: Logika untuk mengelola status kuis (Timer, penghitungan skor).
lib/services/: Penanganan data (API atau Local database).

2. Rencana Fitur Utama
Aplikasi kuis yang efektif biasanya mencakup modul berikut:
A. Quiz Engine
Randomization: Mengacak urutan soal dan pilihan jawaban.
Timer: Memberikan batas waktu per soal atau per sesi kuis.
Scoring System: Kalkulasi nilai akhir berdasarkan bobot soal.
B. User Interface (UI)
Layar Utama: Pemilihan kategori mata pelajaran atau tingkat kesulitan.
Layar Kuis: Menampilkan soal teks/gambar, pilihan ganda, dan indikator progres.
Layar Hasil: Ringkasan nilai, jumlah jawaban benar/salah, dan tombol untuk mengulang.

3. Tech Stack yang Disarankan
Komponen
Teknologi

Framework
Flutter

State Management
Provider atau Bloc (untuk mengelola skor & timer)

Database (Opsional)
SQLite (Lokal) atau Firebase Firestore (Cloud)

Penyimpanan Gambar
Firebase Storage (jika soal menggunakan ilustrasi)
class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

5. Tahapan Pengembangan (Roadmap)
Fase 1: UI Mockup
Buat StatelessWidget untuk layar beranda dan hasil.
Buat StatefulWidget untuk layar kuis karena perlu memperbarui tampilan saat soal berganti.
Fase 2: Quiz Logic
Implementasi fungsi pindah soal saat pilihan diklik.
Tambahkan logika pengecekan jawaban (benar/salah).
Fase 3: State Management
Gunakan Provider untuk menyimpan skor agar bisa diakses di layar hasil tanpa perlu mempassing data secara manual lewat konstruktor.
Fase 4: Final Touch
Tambahkan animasi transisi antar soal menggunakan AnimatedSwitcher.
Implementasi fitur Countdown Timer.


4. Struktur Data (Model)
Contoh sederhana bagaimana Anda mendefinisikan objek kuis dalam Dart:
Dart
