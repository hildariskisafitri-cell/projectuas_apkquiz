import 'package:flutter/foundation.dart';
import 'dart:async';
import '../models/question.dart';
import '../models/quiz_score.dart';

class QuizViewModel extends ChangeNotifier {
  late List<Question> _questions;
  late List<int?> _selectedAnswers; // null jika belum dipilih
  int _currentQuestionIndex = 0;
  late Timer _timer;
  int _remainingSeconds = 0;
  bool _isQuizStarted = false;
  bool _isQuizFinished = false;
  DateTime? _startTime;

  // Getters
  List<Question> get questions => _questions;
  List<int?> get selectedAnswers => _selectedAnswers;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get remainingSeconds => _remainingSeconds;
  bool get isQuizStarted => _isQuizStarted;
  bool get isQuizFinished => _isQuizFinished;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;
  int get totalQuestions => _questions.length;

  QuizViewModel() {
    _questions = [];
    _selectedAnswers = [];
  }

  /// Initialize quiz dengan list soal
  void initializeQuiz(List<Question> questions, {int totalTimeSeconds = 0}) {
    _questions = questions;
    _selectedAnswers = List<int?>.filled(questions.length, null);
    _currentQuestionIndex = 0;
    _isQuizStarted = false;
    _isQuizFinished = false;
    
    // Hitung total waktu jika tidak diberikan
    if (totalTimeSeconds == 0) {
      totalTimeSeconds = questions.fold<int>(0, (sum, q) => sum + q.timeLimit);
    }
    
    _remainingSeconds = totalTimeSeconds;
    _startTime = null;
    notifyListeners();
  }

  /// Start quiz dan timer
  void startQuiz() {
    _isQuizStarted = true;
    _startTime = DateTime.now();
    _startTimer();
    notifyListeners();
  }

  /// Mulai countdown timer
  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          notifyListeners();
        } else {
          _timer.cancel();
          finishQuiz(); // Quiz selesai jika waktu habis
        }
      },
    );
  }

  /// Select jawaban untuk soal saat ini
  void selectAnswer(int optionIndex) {
    if (!_isQuizFinished) {
      _selectedAnswers[_currentQuestionIndex] = optionIndex;
      notifyListeners();
    }
  }

  /// Pindah ke soal berikutnya
  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  /// Pindah ke soal sebelumnya
  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  /// Jump ke soal tertentu
  void jumpToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentQuestionIndex = index;
      notifyListeners();
    }
  }

  /// Hitung jumlah jawaban benar
  int _calculateCorrectAnswers() {
    int correct = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctAnswerIndex) {
        correct++;
      }
    }
    return correct;
  }

  /// Hitung persentase nilai
  double _calculatePercentage(int correct) {
    return (correct / _questions.length) * 100;
  }

  /// Selesaikan kuis dan hitung skor
  QuizScore finishQuiz() {
    _timer.cancel();
    _isQuizFinished = true;

    int correctAnswers = _calculateCorrectAnswers();
    int incorrectAnswers = _questions.length - correctAnswers;
    double percentage = _calculatePercentage(correctAnswers);
    
    int timeTaken = _startTime != null 
        ? DateTime.now().difference(_startTime!).inSeconds 
        : 0;

    notifyListeners();

    return QuizScore(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user_001', // Akan diupdate dengan userId sebenarnya
      quizId: 'quiz_001',
      totalQuestions: _questions.length,
      correctAnswers: correctAnswers,
      incorrectAnswers: incorrectAnswers,
      percentage: percentage,
      completedAt: DateTime.now(),
      timeTaken: timeTaken,
    );
  }

  /// Reset kuis ke state awal
  void resetQuiz() {
    _currentQuestionIndex = 0;
    _selectedAnswers = List<int?>.filled(_questions.length, null);
    _isQuizStarted = false;
    _isQuizFinished = false;
    _remainingSeconds = 0;
    _startTime = null;
    notifyListeners();
  }

  /// Shuffle soal untuk randomization
  void shuffleQuestions() {
    _questions.shuffle();
    notifyListeners();
  }

  /// Shuffle jawaban untuk soal tertentu
  void shuffleOptions({int? questionIndex}) {
    int index = questionIndex ?? _currentQuestionIndex;
    if (index >= 0 && index < _questions.length) {
      Question question = _questions[index];
      List<String> shuffledOptions = List.from(question.options);
      int correctIndex = question.correctAnswerIndex;
      String correctAnswer = shuffledOptions[correctIndex];

      shuffledOptions.shuffle();
      int newCorrectIndex = shuffledOptions.indexOf(correctAnswer);

      _questions[index] = Question(
        id: question.id,
        text: question.text,
        options: shuffledOptions,
        correctAnswerIndex: newCorrectIndex,
        timeLimit: question.timeLimit,
      );
      notifyListeners();
    }
  }

  @override
  void dispose() {
    if (_isQuizStarted && !_isQuizFinished) {
      _timer.cancel();
    }
    super.dispose();
  }
}
