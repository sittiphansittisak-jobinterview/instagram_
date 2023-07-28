import 'package:flutter/material.dart';
import 'package:instagram/widget_style/font_size_style.dart';
import 'package:intl/intl.dart';

class UserStatisticWidget extends StatelessWidget {
  final int count;
  final String title;
  const UserStatisticWidget({super.key, required this.count, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(NumberFormat.decimalPattern().format(count), style: const TextStyle(fontSize: FontSizeStyle.large, fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(fontSize: FontSizeStyle.normal)),
      ],
    );
  }
}
