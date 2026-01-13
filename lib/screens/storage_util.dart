// storage_util.dart
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/// Gets the current question offset for a specific difficulty level
Future<int> getQuestionOffset(String level) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('${level}QuestionOffset') ?? 0;
}

/// Saves the question offset for a specific difficulty level
Future<void> saveQuestionOffset(String level, int offset) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('${level}QuestionOffset', offset);
}

/// Resets all question offsets (to start over with all questions)
Future<void> resetAllQuestionOffsets() async {
  final prefs = await SharedPreferences.getInstance();
  
  await prefs.setInt('easyQuestionOffset', 0);
  await prefs.setInt('mediumQuestionOffset', 0);
  await prefs.setInt('hardQuestionOffset', 0);
}

/// Saves the quiz results to persistent storage
Future<void> saveQuizStats(int total, int answered) async {
  final prefs = await SharedPreferences.getInstance();
  
  // Get existing values or use 0 as default
  final existingTotal = prefs.getInt('totalQuestions') ?? 0;
  final existingAnswered = prefs.getInt('answeredCorrectly') ?? 0;
  
  // Update with new values
  await prefs.setInt('totalQuestions', existingTotal + total);
  await prefs.setInt('answeredCorrectly', existingAnswered + answered);
}

/// Retrieves the saved quiz statistics
Future<Map<String, int>> getQuizStats() async {
  log("hello");

  final prefs = await SharedPreferences.getInstance();
  log("hello");

  return {
    'totalQuestions': prefs.getInt('totalQuestions') ?? 0,
    'answeredCorrectly': prefs.getInt('answeredCorrectly') ?? 0,
  };
}