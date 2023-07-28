import 'dart:math';

String randomDescription() {
  final random = Random();
  final descriptions = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    "Vestibulum quis odio id nisi sollicitudin congue.",
    "Nulla facilisi. Vivamus a ex sit amet est pellentesque fermentum.",
    "Fusce vehicula dolor at augue hendrerit, eu gravida nisi consectetur.",
    "Maecenas laoreet nisi at sapien venenatis, vel bibendum ex venenatis.",
    "Nunc malesuada est eget rhoncus aliquet.",
    "Praesent cursus metus vel sem pharetra dictum.",
    "Sed nec est nec nulla suscipit pellentesque.",
    "Aenean bibendum metus vel augue vulputate luctus.",
    "Proin eu mi id nulla mattis interdum nec ac quam.",
  ];

  return descriptions[random.nextInt(descriptions.length)];
}
