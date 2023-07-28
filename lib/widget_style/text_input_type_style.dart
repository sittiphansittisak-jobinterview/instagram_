import 'package:flutter/services.dart';

class TextInputTypeStyle {
  static const TextInputType none = TextInputType.none,
      text = TextInputType.text,
      email = TextInputType.emailAddress,
      phone = TextInputType.phone,
      number = TextInputType.number,
      area = TextInputType.multiline,
      double = TextInputType.numberWithOptions(decimal: true),
      int = TextInputType.numberWithOptions(decimal: false);
}
