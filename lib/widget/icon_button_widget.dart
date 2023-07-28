import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final Widget icon;
  final BoxConstraints? constraints;
  const IconButtonWidget({super.key, this.onPressed, required this.icon, this.constraints});

  @override
  Widget build(BuildContext context) {
    bool isOnPressedWorking = false;
    Future onPressedSafe() async {
      if (isOnPressedWorking) return;
      isOnPressedWorking = true;
      if (onPressed != null) await onPressed!();
      isOnPressedWorking = false;
    }

    return IconButton(
      padding: const EdgeInsets.all(0),
      constraints: constraints,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: onPressedSafe,
      icon: icon,
    );
  }
}
