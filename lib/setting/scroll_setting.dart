import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//ทำให้ ScrollBar ทำงานได้
class ScrollSetting extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
