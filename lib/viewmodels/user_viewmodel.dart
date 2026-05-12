import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/quiz_score.dart';

class UserViewModel extends ChangeNotifier {
  User? _currentUser;
  List<QuizScore> _userScores = [];

  // Getters
  User? get currentUser => _currentUser;
  List<QuizScore> get userScores => _userScores;
  bool get isLoggedIn => _currentUser != null;

  /// Set current user
  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  /// Login user
  void loginUser(String name, String email) {
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );
    notifyListeners();
  }

  /// Logout user
  void logout() {
    _currentUser = null;
    _userScores = [];
    notifyListeners();
  }

  /// Tambahkan score baru
  void addScore(QuizScore score) {
    _userScores.add(score);
    notifyListeners();
  }

  /// Get average score
  double getAverageScore() {
    if (_userScores.isEmpty) return 0.0;
    double total = _userScores.fold(0, (sum, score) => sum + score.percentage);
    return total / _userScores.length;
  }

  /// Get best score
  QuizScore? getBestScore() {
    if (_userScores.isEmpty) return null;
    return _userScores.reduce((a, b) => a.percentage > b.percentage ? a : b);
  }

  /// Get total quizzes completed
  int getTotalQuizzesCompleted() {
    return _userScores.length;
  }
}
