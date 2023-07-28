import 'package:flutter/material.dart';
import 'package:instagram/object/ig_story_shortcut_object.dart';
import 'package:instagram/widget/image_network_widget.dart';
import 'package:instagram/widget_style/color_style.dart';

class ProfileImageStoryWidget extends StatelessWidget {
  final double radius;
  final IgStoryShortcutObject object;
  const ProfileImageStoryWidget({super.key, required this.radius, required this.object});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(shape: BoxShape.circle, gradient: object.isLive == true || object.isSeen != true ? const LinearGradient(colors: [Color(0xFFFBAA47), Color(0xFFD91A46), Color(0xFFA60F93)]) : const LinearGradient(colors: [Color(0xFFC7C7CC), Color(0xFFC7C7CC)])),
      child: Container(
        padding: const EdgeInsets.all(1.5),
        decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorStyle.light),
        child: ClipOval(
          child: SizedBox.fromSize(size: Size.fromRadius(radius), child: ImageNetworkWidget(imageUrl: object.userObject?.displayImageUrl)),
        ),
      ),
    );
  }
}
