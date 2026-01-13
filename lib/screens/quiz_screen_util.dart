import '../data/questions.dart';

/// Returns the allowed time (in seconds) based on the provided level.
int getTimeForLevelUtil(String level) {
  switch (level) {
    case 'easy':
      return 30;
    case 'medium':
      return 60;
    case 'hard':
      return 120;
    default:
      return 30;
  }
}

/// Retrieves an initial list of questions for the given level (max 10).
List<Question> getInitialQuestions(String level) {
  // Assumes that getQuestionsByLevel() is defined in your questions.dart file.
  return getQuestionsByLevel(level).take(10).toList();
}

/// Checks the user answer against the correct answer with multiple validation options.
bool checkUserAnswer(
  String userAnswer,
  String correctAnswer, {
  bool caseSensitive = false,
  bool allowPartialMatch = false,
  double partialMatchThreshold = 0.8,
  bool allowSynonyms = false,
  List<String> acceptableAlternatives = const [],
  bool ignoreSpecialChars = true,
  bool ignoreArticles = false,
  bool normalizeWhitespace = true,
}) {
  // Handle null or empty inputs
  if (userAnswer.isEmpty || correctAnswer.isEmpty) {
    return false;
  }

  // Prepare answers based on options
  String processedUserAnswer = userAnswer.trim();
  String processedCorrectAnswer = correctAnswer.trim();

  // Normalize whitespace (collapse multiple spaces into single space)
  if (normalizeWhitespace) {
    processedUserAnswer = processedUserAnswer.replaceAll(RegExp(r'\s+'), ' ');
    processedCorrectAnswer = processedCorrectAnswer.replaceAll(RegExp(r'\s+'), ' ');
  }

  // Case sensitivity handling
  if (!caseSensitive) {
    processedUserAnswer = processedUserAnswer.toLowerCase();
    processedCorrectAnswer = processedCorrectAnswer.toLowerCase();
  }

  // Special character handling
  if (ignoreSpecialChars) {
    final pattern = RegExp(r'[^\w\s]');
    processedUserAnswer = processedUserAnswer.replaceAll(pattern, '');
    processedCorrectAnswer = processedCorrectAnswer.replaceAll(pattern, '');
    
    // Additionally normalize remaining whitespace after removing special characters
    if (normalizeWhitespace) {
      processedUserAnswer = processedUserAnswer.replaceAll(RegExp(r'\s+'), ' ').trim();
      processedCorrectAnswer = processedCorrectAnswer.replaceAll(RegExp(r'\s+'), ' ').trim();
    }
  }

  // Articles handling (a, an, the)
  if (ignoreArticles) {
    final articles = [' a ', ' an ', ' the '];
    for (final article in articles) {
      processedUserAnswer = processedUserAnswer.replaceAll(article, ' ');
      processedCorrectAnswer = processedCorrectAnswer.replaceAll(article, ' ');
    }
    
    // Handle articles at the beginning of the answer
    for (final article in articles.map((a) => a.trim())) {
      if (processedUserAnswer.startsWith('$article ')) {
        processedUserAnswer = processedUserAnswer.substring(article.length + 1);
      }
      if (processedCorrectAnswer.startsWith('$article ')) {
        processedCorrectAnswer = processedCorrectAnswer.substring(article.length + 1);
      }
    }
    
    // Handle articles at the end of the answer
    for (final article in articles.map((a) => a.trim())) {
      if (processedUserAnswer.endsWith(' $article')) {
        processedUserAnswer = processedUserAnswer.substring(0, processedUserAnswer.length - article.length - 1);
      }
      if (processedCorrectAnswer.endsWith(' $article')) {
        processedCorrectAnswer = processedCorrectAnswer.substring(0, processedCorrectAnswer.length - article.length - 1);
      }
    }
    
    // Normalize whitespace again after removing articles
    if (normalizeWhitespace) {
      processedUserAnswer = processedUserAnswer.replaceAll(RegExp(r'\s+'), ' ').trim();
      processedCorrectAnswer = processedCorrectAnswer.replaceAll(RegExp(r'\s+'), ' ').trim();
    }
  }

  // Check for exact match after processing
  if (processedUserAnswer == processedCorrectAnswer) {
    return true;
  }

  // Process acceptable alternatives with the same rules
  if (acceptableAlternatives.isNotEmpty) {
    for (String alternative in acceptableAlternatives) {
      String processedAlternative = alternative.trim();
      
      if (normalizeWhitespace) {
        processedAlternative = processedAlternative.replaceAll(RegExp(r'\s+'), ' ');
      }
      
      if (!caseSensitive) {
        processedAlternative = processedAlternative.toLowerCase();
      }
      
      if (ignoreSpecialChars) {
        processedAlternative = processedAlternative.replaceAll(RegExp(r'[^\w\s]'), '');
        if (normalizeWhitespace) {
          processedAlternative = processedAlternative.replaceAll(RegExp(r'\s+'), ' ').trim();
        }
      }
      
      if (ignoreArticles) {
        final articles = [' a ', ' an ', ' the '];
        for (final article in articles) {
          processedAlternative = processedAlternative.replaceAll(article, ' ');
        }
        
        for (final article in articles.map((a) => a.trim())) {
          if (processedAlternative.startsWith('$article ')) {
            processedAlternative = processedAlternative.substring(article.length + 1);
          }
          if (processedAlternative.endsWith(' $article')) {
            processedAlternative = processedAlternative.substring(0, processedAlternative.length - article.length - 1);
          }
        }
        
        if (normalizeWhitespace) {
          processedAlternative = processedAlternative.replaceAll(RegExp(r'\s+'), ' ').trim();
        }
      }
      
      if (processedUserAnswer == processedAlternative) {
        return true;
      }
    }
  }

  // Check for partial match if allowed
  if (allowPartialMatch) {
    final similarity = _calculateSimilarity(processedUserAnswer, processedCorrectAnswer);
    if (similarity >= partialMatchThreshold) {
      return true;
    }
    
    // Also check similarity against alternatives if they exist
    if (acceptableAlternatives.isNotEmpty) {
      for (String alternative in acceptableAlternatives) {
        String processedAlternative = alternative.trim();
        
        if (normalizeWhitespace) {
          processedAlternative = processedAlternative.replaceAll(RegExp(r'\s+'), ' ');
        }
        
        if (!caseSensitive) {
          processedAlternative = processedAlternative.toLowerCase();
        }
        
        if (ignoreSpecialChars) {
          processedAlternative = processedAlternative.replaceAll(RegExp(r'[^\w\s]'), '');
          if (normalizeWhitespace) {
            processedAlternative = processedAlternative.replaceAll(RegExp(r'\s+'), ' ').trim();
          }
        }
        
        if (ignoreArticles) {
          final articles = [' a ', ' an ', ' the '];
          for (final article in articles) {
            processedAlternative = processedAlternative.replaceAll(article, ' ');
          }
          
          for (final article in articles.map((a) => a.trim())) {
            if (processedAlternative.startsWith('$article ')) {
              processedAlternative = processedAlternative.substring(article.length + 1);
            }
            if (processedAlternative.endsWith(' $article')) {
              processedAlternative = processedAlternative.substring(0, processedAlternative.length - article.length - 1);
            }
          }
          
          if (normalizeWhitespace) {
            processedAlternative = processedAlternative.replaceAll(RegExp(r'\s+'), ' ').trim();
          }
        }
        
        final altSimilarity = _calculateSimilarity(processedUserAnswer, processedAlternative);
        if (altSimilarity >= partialMatchThreshold) {
          return true;
        }
      }
    }
  }

  return false;
}

/// Calculates string similarity using Levenshtein distance
double _calculateSimilarity(String s1, String s2) {
  if (s1.isEmpty || s2.isEmpty) {
    return 0.0;
  }

  // Calculate Levenshtein distance
  List<List<int>> dp = List.generate(
    s1.length + 1,
    (i) => List.generate(s2.length + 1, (j) => j == 0 ? i : (i == 0 ? j : 0)),
  );

  for (int i = 1; i <= s1.length; i++) {
    for (int j = 1; j <= s2.length; j++) {
      int cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
      dp[i][j] = [
        dp[i - 1][j] + 1, // deletion
        dp[i][j - 1] + 1, // insertion
        dp[i - 1][j - 1] + cost, // substitution
      ].reduce((curr, next) => curr < next ? curr : next);
    }
  }

  // Convert distance to similarity score
  final maxLength = s1.length > s2.length ? s1.length : s2.length;
  final distance = dp[s1.length][s2.length];
  return 1 - (distance / maxLength);
}