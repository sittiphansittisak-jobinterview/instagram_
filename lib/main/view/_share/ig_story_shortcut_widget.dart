import 'package:flutter/material.dart';
import 'package:instagram/main/view/_share/image_story_widget.dart';
import 'package:instagram/object/ig_story_shortcut_object.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';

class IgStoryShortcutWidget extends StatelessWidget {
  final IgStoryShortcutObject object;
  final Function(dynamic id) onTapStory;
  final Function(dynamic id) onTapUser;
  const IgStoryShortcutWidget({super.key, required this.object, required this.onTapStory, required this.onTapUser});

  @override
  Widget build(BuildContext context) {
    final profileImageWidget = ProfileImageStoryWidget(radius: 28, object: object);
    final liveWidget = Container(
      alignment: Alignment.center,
      width: 26,
      height: 16,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), border: Border.all(color: ColorStyle.light, width: 2), gradient: const LinearGradient(colors: [Color(0xFFC90083), Color(0xFFD22463), Color(0xFFE10038)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: const Text('LIVE', style: TextStyle(color: ColorStyle.light, fontSize: FontSizeStyle.mini, height: 1.0)),
    );
    final nameWidget = Text(object.userObject?.displayName ?? '-', style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.small));

    final openStoryButtonWidget = InkWell(
      onTap: () => onTapStory(object.userObject?.id),
      child: object.isLive == true
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                profileImageWidget,
                liveWidget,
              ],
            )
          : profileImageWidget,
    );
    final openProfileButtonWidget = InkWell(onTap: () => onTapUser(object.userObject?.id), child: nameWidget);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        openStoryButtonWidget,
        openProfileButtonWidget,
      ],
    );
  }
}
