import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final percent = (score / total * 100).round();

    String title;
    String subtitle;
    String emoji;

    if (percent == 100) {
      title = 'Керемет жұмыс!';
      subtitle = 'Сен барлық сұраққа дұрыс жауап бердің!';
      emoji = '🏆';
    } else if (percent >= 80) {
      title = 'Жарайсың!';
      subtitle = 'Өте жақсы нәтиже көрсеттің!';
      emoji = '🎉';
    } else if (percent >= 60) {
      title = 'Жақсы талпыныс!';
      subtitle = 'Әлі де жетілдіруге болады!';
      emoji = '👍';
    } else {
      title = 'Бәрі алда!';
      subtitle = 'Келесі жолы жақсырақ болатынына сенемін.';
      emoji = '💪';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Emoji animation
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 96),
                ).animate().scale(duration: 600.ms).then().shakeX(),

                // Main title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade800,
                  ),
                ).animate().fadeIn(duration: 600.ms),

                // Subtitle
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),

                const SizedBox(height: 30),

                // Score display
Container(
  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
  decoration: BoxDecoration(
    color: Colors.amber.shade50,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.amber.shade200, width: 1.5),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$score / $total',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      const SizedBox(width: 20),  // Space between score and percentage
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$percent%',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.amber.shade800,
            ),
          ),
        ],
      ),
    ],
  ),
).animate().fadeIn().slideY(begin: 0.2),


                const SizedBox(height: 40),

                // Restart button
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Басты бетке оралу',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ).animate().fadeIn().slideY(begin: 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
