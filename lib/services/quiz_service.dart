import '../models/question.dart';

class QuizService {
  /// Fetch quiz questions - bisa dari API atau local database
  /// Untuk sekarang menggunakan dummy data
  Future<List<Question>> fetchQuestions({String? category}) async {
    // Simulasi API delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Return dummy data
    return getDummyQuestions(category);
  }

  /// Get dummy questions untuk testing
  List<Question> getDummyQuestions(String? category) {
    List<Question> allQuestions = [
      // Sains - Biologi
      Question(
        id: '1',
        text: 'Organisme mana yang menghasilkan oksigen melalui fotosintesis?',
        options: ['Bakteri', 'Tumbuhan dan Alga', 'Jamur', 'Hewan Mamalia'],
        correctAnswerIndex: 1,
        timeLimit: 25,
      ),
      // Sains - Kimia
      Question(
        id: '2',
        text: 'Berapa jumlah atom hidrogen dalam satu molekul air (H2O)?',
        options: ['1', '2', '3', '4'],
        correctAnswerIndex: 1,
        timeLimit: 20,
      ),
      // Sejarah Dunia
      Question(
        id: '3',
        text: 'Dalam tahun berapa Perang Dunia II berakhir?',
        options: ['1943', '1944', '1945', '1946'],
        correctAnswerIndex: 2,
        timeLimit: 25,
      ),
      // Logika Dasar
      Question(
        id: '4',
        text: 'Jika semua kucing adalah hewan, dan Mitzy adalah kucing, maka Mitzy adalah?',
        options: ['Tanaman', 'Hewan', 'Benda Mati', 'Tidak dapat ditentukan'],
        correctAnswerIndex: 1,
        timeLimit: 25,
      ),
      // Sains - Fisika
      Question(
        id: '5',
        text: 'Kecepatan cahaya di vakum sekitar berapa km per detik?',
        options: ['30 ribu', '100 ribu', '300 ribu', '500 ribu'],
        correctAnswerIndex: 2,
        timeLimit: 25,
      ),
      // Sejarah Dunia
      Question(
        id: '6',
        text: 'Siapa yang menemukan benua Amerika sekitar tahun 1492?',
        options: ['Marco Polo', 'Christopher Columbus', 'Vasco da Gama', 'Ferdinand Magellan'],
        correctAnswerIndex: 1,
        timeLimit: 25,
      ),
      // Logika Dasar
      Question(
        id: '7',
        text: 'Jika A > B dan B > C, maka apa hubungan antara A dan C?',
        options: ['A < C', 'A = C', 'A > C', 'Tidak dapat ditentukan'],
        correctAnswerIndex: 2,
        timeLimit: 25,
      ),
      // Sains - Astronomi
      Question(
        id: '8',
        text: 'Planet mana yang paling dekat dengan Matahari?',
        options: ['Venus', 'Merkurius', 'Bumi', 'Mars'],
        correctAnswerIndex: 1,
        timeLimit: 25,
      ),
      // Sejarah Dunia
      Question(
        id: '9',
        text: 'Dinasti mana yang membangun Tembok Besar China?',
        options: ['Dinasti Ming', 'Dinasti Han', 'Dinasti Tang', 'Dinasti Qin'],
        correctAnswerIndex: 0,
        timeLimit: 25,
      ),
      // Logika Dasar
      Question(
        id: '10',
        text: 'Berapa banyak garis yang dibutuhkan untuk membagi lingkaran menjadi 4 bagian sama besar?',
        options: ['2 garis', '3 garis', '4 garis', '5 garis'],
        correctAnswerIndex: 0,
        timeLimit: 25,
      ),
    ];

    // Filter berdasarkan kategori jika ada
    if (category != null && category.isNotEmpty) {
      // Implementasi filter kategori bisa ditambahkan di sini
      return allQuestions;
    }

    return allQuestions;
  }

  /// Save user score ke database/API
  Future<bool> saveScore({
    required String userId,
    required String quizId,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    try {
      // Simulasi menyimpan ke database
      await Future.delayed(const Duration(milliseconds: 300));
      return true;
    } catch (e) {
      // Error saving score
      return false;
    }
  }
}
