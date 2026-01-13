import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../data/questions.dart';
import 'result_screen.dart';
import 'quiz_screen_util.dart';
import 'storage_util.dart';

class QuizScreen extends StatefulWidget {
  final String level;

  const QuizScreen({super.key, required this.level});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  final TextEditingController answerController = TextEditingController();
  late List<Question> questions;
  late Timer _timer;
  int timeLeft = 0;

  bool isAnswered = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    questions = getInitialQuestions(widget.level);
    startTimer();
  }

  void startTimer() {
    timeLeft = getTimeForLevelUtil(widget.level);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft == 0) {
        _timer.cancel();
        setState(() {
          isAnswered = true;
          isCorrect = false;
        });
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  void stopTimer() => _timer.cancel();

  void checkAnswer() {
    final correct = checkUserAnswer(
      answerController.text,
      questions[currentIndex].answer,
    );

    stopTimer();
    setState(() {
      isAnswered = true;
      isCorrect = correct;
      if (correct) score++;
    });
  }

  // Modified function for QuizScreen class
void goToNextQuestion() {
  if (currentIndex + 1 < questions.length) {
    setState(() {
      currentIndex++;
      isAnswered = false;
      answerController.clear();
    });
    startTimer();
  } else {
    // Save quiz stats before navigating to results
    saveQuizStats(questions.length, score).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(score: score, total: questions.length),
        ),
      );
    });
  }
}

  @override
  void dispose() {
    _timer.cancel();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
    final percent =
        (timeLeft / getTimeForLevelUtil(widget.level)).clamp(0, 1).toDouble();

    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(
        title: Text('Сұрақ ${currentIndex + 1} / ${questions.length}'),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          // Wrap the main Column in a SingleChildScrollView
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 
                    AppBar().preferredSize.height - 
                    MediaQuery.of(context).padding.top - 
                    MediaQuery.of(context).padding.bottom - 
                    48, // 48 for padding
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LinearProgressIndicator(
                    value: percent,
                    backgroundColor: Colors.grey.shade300,
                    color: timeLeft < 10 ? Colors.redAccent : Colors.amber,
                    minHeight: 10,
                  ).animate().scaleX(duration: 500.ms),

                  const SizedBox(height: 24),
                  // Put the question text inside a container to handle long text properly
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      question.question,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ).animate().fadeIn(duration: 500.ms),
                  ),

                  TextField(
                    controller: answerController,
                    enabled: !isAnswered,
                    decoration: InputDecoration(
                      hintText: 'Жауабыңды жаз...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onSubmitted: (_) => checkAnswer(),
                  ),
                  const SizedBox(height: 20),

                  if (!isAnswered)
                    ElevatedButton(
                      onPressed: checkAnswer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Тексеру',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ).animate().slideY(begin: 0.2),

                  if (isAnswered)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: isCorrect ? Colors.green : Colors.red,
                          size: 60,
                        ).animate().scaleXY(duration: 500.ms),
                        const SizedBox(height: 12),
                        if (!isCorrect)
                          Text(
                            'Дұрыс жауап: ${question.answer}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ).animate().fadeIn(duration: 400.ms),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: goToNextQuestion,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Келесі сұрақ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ).animate().fadeIn().slideY(begin: 0.1),
                      ],
                    ),

                  SizedBox(height: 40),
                  Text(
                    'Уақыт: $timeLeft с',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: timeLeft < 10 ? Colors.redAccent : Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}