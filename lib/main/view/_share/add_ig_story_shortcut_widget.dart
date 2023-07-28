import 'package:flutter/material.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';

class AddIgStoryShortcutWidget extends StatelessWidget {
  final String? title;
  final Function() onTap;
  const AddIgStoryShortcutWidget({super.key, this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final circularIconWidget = Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      padding: const EdgeInsets.all(1.5),
      decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFFC7C7CC), Color(0xFFC7C7CC)])),
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorStyle.light),
        child: ClipOval(child: SizedBox.fromSize(size: const Size.fromRadius(28), child: const Icon(Icons.add, size: 18, color: ColorStyle.dark))),
      ),
    );
    final iconButtonWidget = InkWell(onTap: onTap, child: circularIconWidget);
    final titleButtonWidget = InkWell(onTap: onTap, child: Text(title ?? 'New', style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.small)));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconButtonWidget,
        titleButtonWidget,
      ],
    );
  }
}
