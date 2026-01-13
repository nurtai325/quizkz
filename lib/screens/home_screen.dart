import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'quiz_type_screen.dart';
import 'storage_util.dart'; // Import the storage utility

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Default values before loading
  int totalQuestions = 0;
  int answeredCorrectly = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load stats when screen initializes
    _loadStats();
  }

  // Load stats from storage
  Future<void> _loadStats() async {
    final stats = await getQuizStats();
    setState(() {
      totalQuestions = stats['totalQuestions'] ?? 0;
      answeredCorrectly = stats['answeredCorrectly'] ?? 0;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // TOP: Cool Header
              Column(
                children: [
                  Text(
                    'Сәлем, батыр!',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      foreground:
                          Paint()
                            ..shader = LinearGradient(
                              colors: [Colors.amber.shade800, Colors.orange],
                            ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Миға шабуыл жасауға дайынсың ба?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 70),

              // START BUTTON
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizTypeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  'Куизді бастау',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),

              const SizedBox(height: 30),

              // LAST SCORE - Now showing data from storage
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 28),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Соңғы нәтиже',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        isLoading
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.amber,
                                ),
                              )
                            : Text(
                                '$answeredCorrectly / $totalQuestions',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 700.ms).slideX(begin: -0.3),

              const SizedBox(height: 10),

              // ANIMATED EMOJI 🧠
              Center(
                child: Text(
                      '🧠',
                      style: const TextStyle(
                        fontSize: 100,
                      ), // BIGGER emoji size
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scaleXY(
                      end: 1.1,
                      duration: 1000.ms,
                      curve: Curves.easeInOut,
                    ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}