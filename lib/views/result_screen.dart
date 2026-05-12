import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_score.dart';
import '../viewmodels/quiz_viewmodel.dart';
import '../viewmodels/user_viewmodel.dart';
import '../widgets/quiz_button.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final QuizScore score;

  const ResultScreen({
    super.key,
    required this.score,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    // Save score ke user viewmodel
    final userViewModel = context.read<UserViewModel>();
    final scoreWithUserId = QuizScore(
      id: widget.score.id,
      userId: userViewModel.currentUser?.id ?? 'anonymous',
      quizId: widget.score.quizId,
      totalQuestions: widget.score.totalQuestions,
      correctAnswers: widget.score.correctAnswers,
      incorrectAnswers: widget.score.incorrectAnswers,
      percentage: widget.score.percentage,
      completedAt: widget.score.completedAt,
      timeTaken: widget.score.timeTaken,
    );
    userViewModel.addScore(scoreWithUserId);
  }

  Color _getScoreColor(double percentage) {
    if (percentage >= 80) {
      return const Color(0xFF4CAF50); // Hijau
    } else if (percentage >= 60) {
      return const Color(0xFFFFC107); // Kuning
    } else {
      return const Color(0xFFF44336); // Merah
    }
  }

  String _getScoreGrade(double percentage) {
    if (percentage >= 90) {
      return 'Sempurna!';
    } else if (percentage >= 80) {
      return 'Sangat Baik!';
    } else if (percentage >= 70) {
      return 'Baik';
    } else if (percentage >= 60) {
      return 'Cukup';
    } else {
      return 'Perlu Perbaikan';
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '$minutes menit $secs detik';
  }

  Color _getColorWithAlpha(Color color, double alpha) {
    return color.withValues(alpha: alpha);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Score circle
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getColorWithAlpha(_getScoreColor(widget.score.percentage), 0.1),
                      border: Border.all(
                        color: _getScoreColor(widget.score.percentage),
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.score.percentage.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.bold,
                              color:
                                  _getScoreColor(widget.score.percentage),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getScoreGrade(widget.score.percentage),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color:
                                  _getScoreColor(widget.score.percentage),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Summary
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Total Soal',
                          '${widget.score.totalQuestions}',
                          Colors.blue,
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(
                          'Benar',
                          '${widget.score.correctAnswers}',
                          const Color(0xFF4CAF50),
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(
                          'Salah',
                          '${widget.score.incorrectAnswers}',
                          const Color(0xFFF44336),
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow(
                          'Waktu',
                          _formatTime(widget.score.timeTaken),
                          Colors.orange,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // User stats (jika sudah login)
                  Consumer<UserViewModel>(
                    builder: (context, userViewModel, _) {
                      if (userViewModel.isLoggedIn &&
                          userViewModel.getTotalQuizzesCompleted() > 1) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Statistik Anda',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F1FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  _buildStatsRow(
                                    'Kuis Diselesaikan',
                                    '${userViewModel.getTotalQuizzesCompleted()}',
                                  ),
                                  const SizedBox(height: 12),
                                  _buildStatsRow(
                                    'Rata-rata Skor',
                                    '${userViewModel.getAverageScore().toStringAsFixed(1)}%',
                                  ),
                                  const SizedBox(height: 12),
                                  _buildStatsRow(
                                    'Skor Terbaik',
                                    '${userViewModel.getBestScore()?.percentage.toStringAsFixed(1) ?? 0}%',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  // Buttons
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        QuizButton(
                          label: 'Kuis Lagi',
                          onPressed: () {
                            context.read<QuizViewModel>().resetQuiz();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                            );
                          },
                          backgroundColor: const Color(0xFF6C63FF),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              context.read<QuizViewModel>().resetQuiz();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF6C63FF),
                                width: 2,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Kembali ke Beranda',
                              style: TextStyle(
                                color: Color(0xFF6C63FF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C63FF),
          ),
        ),
      ],
    );
  }
}