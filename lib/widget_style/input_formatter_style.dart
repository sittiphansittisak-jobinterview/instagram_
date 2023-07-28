import 'package:flutter/services.dart';

class InputFormatterStyle {
  static final List<TextInputFormatter> none = [],
      doublePositive = [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,2})'))],
      intPositive = [
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
      ],
      phone = [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(RegExp(r'^[1-9]+')),
      ],
      number = [FilteringTextInputFormatter.digitsOnly],
      idCard = [LengthLimitingTextInputFormatter(13), FilteringTextInputFormatter.digitsOnly];
}
