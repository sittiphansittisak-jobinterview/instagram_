import 'package:flutter/material.dart';

class BorderRadiusStyle {
  static const BorderRadius none = BorderRadius.all(Radius.circular(0)),
      small = BorderRadius.all(Radius.circular(5)),
      basic = BorderRadius.all(Radius.circular(10)),
      big = BorderRadius.all(Radius.circular(20)),
      topBasic = BorderRadius.vertical(top: Radius.circular(10)),
      botSmall = BorderRadius.vertical(bottom: Radius.circular(5)),
      botBasic = BorderRadius.vertical(bottom: Radius.circular(10)),
      circle = BorderRadius.all(Radius.circular(1000));
}
