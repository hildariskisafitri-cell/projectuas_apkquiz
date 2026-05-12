class QuizScore {
  final String id;
  final String userId;
  final String quizId;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final double percentage;
  final DateTime completedAt;
  final int timeTaken; // dalam detik

  QuizScore({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.percentage,
    required this.completedAt,
    required this.timeTaken,
  });

  factory QuizScore.fromJson(Map<String, dynamic> json) {
    return QuizScore(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      quizId: json['quizId'] ?? '',
      totalQuestions: json['totalQuestions'] ?? 0,
      correctAnswers: json['correctAnswers'] ?? 0,
      incorrectAnswers: json['incorrectAnswers'] ?? 0,
      percentage: (json['percentage'] ?? 0).toDouble(),
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt']) 
          : DateTime.now(),
      timeTaken: json['timeTaken'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'quizId': quizId,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'percentage': percentage,
      'completedAt': completedAt.toIso8601String(),
      'timeTaken': timeTaken,
    };
  }
}
