import 'dart:math';

String randomDisplayName() {
  final random = Random();
  final firstNames = ["John", "Emma", "Michael", "Sophia", "Robert", "Olivia", "William", "Ava", "James", "Isabella", "David", "Mia", "Joseph", "Emily", "Matthew", "Abigail", "Daniel", "Harper", "Alexander", "Charlotte"];
  final lastNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Lee", "Harris"];

  final firstName = firstNames[random.nextInt(firstNames.length)];
  final lastName = lastNames[random.nextInt(lastNames.length)];

  return "$firstName $lastName";
}
