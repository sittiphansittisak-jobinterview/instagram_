import 'dart:math';

String randomTitle() {
  final random = Random();
  final titles = ["Friend", "Exercise", "Working", "Game", "Reading", "Travel", "Cooking", "Music", "Study", "Adventure", "Sports", "Movie", "Art", "Coding", "Hiking", "Dancing", "Shopping", "Yoga", "Photography", "Gardening"];

  return titles[random.nextInt(titles.length)];
}
