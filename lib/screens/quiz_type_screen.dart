import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'quiz_screen.dart';

class QuizTypeScreen extends StatelessWidget {
  const QuizTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        title: const Text(
          'Деңгейді таңда',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),

              Text(
                'Куизге дайынсың ба?\nҚиындық деңгейін таңда!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 0.3, duration: 500.ms),

              const SizedBox(height: 50),

              _buildLevelButton(
                context,
                label: '🟢 Оңай',
                levelSlug: 'easy',
                color: Colors.green.shade400,
              ).animate().fadeIn().slideX(begin: -0.3, duration: 500.ms),

              const SizedBox(height: 20),

              _buildLevelButton(
                context,
                label: '🟡 Орташа',
                levelSlug: 'medium',
                color: Colors.orange.shade400,
              ).animate().fadeIn().slideX(begin: 0.2, duration: 550.ms),

              const SizedBox(height: 20),

              _buildLevelButton(
                context,
                label: '🔴 Қиын',
                levelSlug: 'hard',
                color: Colors.red.shade400,
              ).animate().fadeIn().slideX(begin: 0.4, duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton(BuildContext context,
      {required String label, required String levelSlug, required Color color}) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuizScreen(level: levelSlug), // Pass the slug here
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 6,
        shadowColor: Colors.black26,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
