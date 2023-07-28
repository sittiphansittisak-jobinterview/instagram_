import 'dart:math';

DateTime randomDateTime() {
  final random = Random();

  final year = DateTime.now().year;
  final month = DateTime.now().month;

  // Generate a random day between 1 and the number of days in the selected month
  final daysInMonth = DateTime(year, month + 1, 0).day;
  final day = random.nextInt(daysInMonth) + 1;

  // Generate random hours, minutes, and seconds between 0 and 59
  final hour = random.nextInt(24);
  final minute = random.nextInt(60);
  final second = random.nextInt(60);

  // Return the generated random DateTime
  return DateTime(year, month, day, hour, minute, second);
}
