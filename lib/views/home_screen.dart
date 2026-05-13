import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/quiz_service.dart';
import '../services/audio_service.dart';
import '../viewmodels/quiz_viewmodel.dart';
import '../viewmodels/user_viewmodel.dart';
import '../widgets/luxury_background.dart';
import 'quiz_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final QuizService _quizService = QuizService();
  final AudioService _audioService = AudioService();
  String _selectedCategory = 'Umum';
  bool _isLoading = false;
  late AnimationController _headerAnimController;
  late AnimationController _categoryAnimController;
  late Animation<double> _headerFadeAnimation;
  late Animation<double> _categoryFadeAnimation;

  final List<String> categories = [
    'Umum',
    'Matematika',
    'Sains',
    'Geografi',
    'Sejarah',
  ];

  @override
  void initState() {
    super.initState();
    // Setup header animation
    _headerAnimController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _headerAnimController, curve: Curves.easeIn),
    );

    // Setup category animation
    _categoryAnimController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _categoryFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _categoryAnimController, curve: Curves.easeIn),
    );

    // Start animations with stagger
    _headerAnimController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _categoryAnimController.forward();
      }
    });
  }

  @override
  void dispose() {
    _headerAnimController.dispose();
    _categoryAnimController.dispose();
    super.dispose();
  }

  void _startQuiz() async {
    _audioService.playClickSound();
    
    setState(() {
      _isLoading = true;
    });

    try {
      final questions = await _quizService.fetchQuestions(
        category: _selectedCategory,
      );

      if (!mounted) return;

      final quizViewModel = context.read<QuizViewModel>();
      quizViewModel.initializeQuiz(questions);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const QuizScreen(),
        ),
      );
    } catch (e) {
      _audioService.playIncorrectSound();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading quiz: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LuxuryBackgroundScaffold(
      addBackgroundOverlay: true,
      overlayOpacity: 0.1,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan animasi
              FadeTransition(
                opacity: _headerFadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Quiz Master',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD4A574),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Test pengetahuan Anda dengan kuis interaktif',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Category selection dengan animasi
              FadeTransition(
                opacity: _categoryFadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pilih Kategori',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: categories.map((category) {
                        bool isSelected = _selectedCategory == category;
                        return GestureDetector(
                          onTap: () {
                            _audioService.playClickSound();
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF6C63FF)
                                  : Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF6C63FF)
                                    : const Color(0xFFD4A574).withValues(alpha: 0.3),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey[200],
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // Start button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _startQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    disabledBackgroundColor: Colors.grey[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Mulai Kuis',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Logout button (jika sudah login)
              Consumer<UserViewModel>(
                builder: (context, userViewModel, _) {
                  if (userViewModel.isLoggedIn) {
                    return SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          _audioService.playClickSound();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Logout'),
                                content: const Text('Apakah Anda yakin ingin logout?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text('Tidak'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      userViewModel.logout();
                                      Navigator.of(context).pop();
                                        Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (_) => const LoginScreen(),
                                          ),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text('Ya'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFF6C63FF),
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFF6C63FF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

