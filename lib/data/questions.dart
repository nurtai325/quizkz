import "./questions_data.dart";
import 'dart:math';
import '../screens/storage_util.dart'; // Import the storage utility

class Question {
  final String question;
  final String answer;
  final String level;
  
  Question({
    required this.question,
    required this.answer,
    required this.level,
  });
}

// Helper to get questions by level
List<Question> getQuestionsByLevel(String level) {
  switch (level) {
    case 'easy':
      return easyQuestions;
    case 'medium':
      return mediumQuestions;
    case 'hard':
      return hardQuestions;
    default:
      return [];
  }
}

// Add this to questions.dart
// Cache of offsets to avoid async calls
Map<String, int> _cachedOffsets = {
  'easy': 0,
  'medium': 0,
  'hard': 0
};
bool _offsetsLoaded = false;

// Load offsets from SharedPreferences into memory
Future<void> loadQuestionOffsets() async {
  _cachedOffsets['easy'] = await getQuestionOffset('easy');
  _cachedOffsets['medium'] = await getQuestionOffset('medium');
  _cachedOffsets['hard'] = await getQuestionOffset('hard');
  _offsetsLoaded = true;
}

// Now make the function synchronous using the cached values
List<Question> getNextFiveQuestions(String level) {
  if (!_offsetsLoaded) {
    throw Exception("Question offsets not loaded. Call loadQuestionOffsets() first.");
  }

  // Get all questions for this level
  List<Question> allQuestions = getQuestionsByLevel(level);
  
  // Get the current offset from cache
  int offset = _cachedOffsets[level] ?? 0;
  
  // If we're near the end or past the end, reset the offset
  if (offset + 5 > allQuestions.length) {
    offset = 0;
    _cachedOffsets[level] = 0;
    // Schedule async save without waiting
    saveQuestionOffset(level, 0);
  }
  
  // Calculate the end index
  int endIndex = min(offset + 5, allQuestions.length);
  
  // Get the 5 questions
  List<Question> fiveQuestions = allQuestions.sublist(offset, endIndex);
  
  // Update the offset for next time
  _cachedOffsets[level] = endIndex;
  // Schedule async save without waiting
  saveQuestionOffset(level, endIndex);
  
  return fiveQuestions;
}