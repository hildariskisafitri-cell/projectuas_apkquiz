import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/quiz_viewmodel.dart';
import '../widgets/option_card.dart';
import '../widgets/progress_bar.dart';
import '../widgets/timer_widget.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    // Start quiz setelah build selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizViewModel>().startQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        title: const Text(
          'Kuis',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Keluar Kuis?'),
                  content: const Text('Apakah Anda yakin ingin keluar? Progress Anda akan hilang.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Tidak'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ya'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      body: Consumer<QuizViewModel>(
        builder: (context, quizViewModel, _) {
          if (quizViewModel.questions.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6C63FF),
              ),
            );
          }

          return SafeArea(
            child: Column(
              children: [
                // Timer
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Timer widget
                      TimerWidget(
                        remainingSeconds: quizViewModel.remainingSeconds,
                        totalSeconds: quizViewModel.remainingSeconds + 60, // Contoh total
                        textColor: Colors.black,
                      ),
                      // Question counter
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${quizViewModel.currentQuestionIndex + 1}/${quizViewModel.totalQuestions}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ProgressBar(
                    currentQuestion: quizViewModel.currentQuestionIndex + 1,
                    totalQuestions: quizViewModel.totalQuestions,
                  ),
                ),

                // Question and options
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          // Question text
                          Text(
                            quizViewModel.currentQuestion.text,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Options
                          ...List.generate(
                            quizViewModel.currentQuestion.options.length,
                            (index) {
                              bool isSelected =
                                  quizViewModel.selectedAnswers[
                                      quizViewModel.currentQuestionIndex] ==
                                  index;
                              bool isCorrect =
                                  index ==
                                  quizViewModel
                                      .currentQuestion.correctAnswerIndex;

                              return OptionCard(
                                optionText: quizViewModel
                                    .currentQuestion.options[index],
                                optionIndex: index,
                                isSelected: isSelected,
                                isCorrect: isCorrect,
                                showResult: false,
                                onTap: () {
                                  quizViewModel.selectAnswer(index);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Navigation buttons
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Previous button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed:
                              quizViewModel.currentQuestionIndex == 0
                                  ? null
                                  : () {
                                      quizViewModel.previousQuestion();
                                    },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Sebelumnya'),
                          style: OutlinedButton.styleFrom(
                            disabledForegroundColor: Colors.grey,
                            side: BorderSide(
                              color: quizViewModel.currentQuestionIndex == 0
                                  ? Colors.grey
                                  : const Color(0xFF6C63FF),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Next/Submit button
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (quizViewModel.isLastQuestion) {
                              // Submit quiz
                              final score =
                                  quizViewModel.finishQuiz();
                              Navigator.of(context)
                                  .pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ResultScreen(score: score),
                                ),
                              );
                            } else {
                              // Go to next question
                              quizViewModel.nextQuestion();
                            }
                          },
                          icon: Icon(
                            quizViewModel.isLastQuestion
                                ? Icons.check
                                : Icons.arrow_forward,
                          ),
                          label: Text(
                            quizViewModel.isLastQuestion
                                ? 'Selesai'
                                : 'Berikutnya',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    context.read<QuizViewModel>().dispose();
    super.dispose();
  }
}
