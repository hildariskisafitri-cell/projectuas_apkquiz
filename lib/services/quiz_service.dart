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
      Question(
        id: '1',
        text: 'Berapa hasil dari 2 + 2?',
        options: ['3', '4', '5', '6'],
        correctAnswerIndex: 1,
        timeLimit: 20,
      ),
      Question(
        id: '2',
        text: 'Ibu kota Indonesia adalah?',
        options: ['Surabaya', 'Jakarta', 'Bandung', 'Medan'],
        correctAnswerIndex: 1,
        timeLimit: 20,
      ),
      Question(
        id: '3',
        text: 'Planet terbesar di tata surya adalah?',
        options: ['Saturnus', 'Jupiter', 'Mars', 'Venus'],
        correctAnswerIndex: 1,
        timeLimit: 20,
      ),
      Question(
        id: '4',
        text: 'Berapa banyak benua di bumi?',
        options: ['5', '6', '7', '8'],
        correctAnswerIndex: 2,
        timeLimit: 20,
      ),
      Question(
        id: '5',
        text: 'Siapa penemu bola lampu?',
        options: ['Nikola Tesla', 'Thomas Edison', 'Alexander Graham Bell', 'Benjamin Franklin'],
        correctAnswerIndex: 1,
        timeLimit: 20,
      ),
      Question(
        id: '6',
        text: 'Berapa jumlah sisi pada kubus?',
        options: ['4', '5', '6', '8'],
        correctAnswerIndex: 2,
        timeLimit: 20,
      ),
      Question(
        id: '7',
        text: 'Negara dengan populasi terbesar adalah?',
        options: ['India', 'Indonesia', 'China', 'USA'],
        correctAnswerIndex: 2,
        timeLimit: 20,
      ),
      Question(
        id: '8',
        text: 'Laut terbesar di dunia adalah?',
        options: ['Laut Merah', 'Samudera Pasifik', 'Laut Hitam', 'Selat Inggris'],
        correctAnswerIndex: 1,
        timeLimit: 20,
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
