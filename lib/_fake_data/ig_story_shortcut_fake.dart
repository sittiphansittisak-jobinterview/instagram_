import 'package:instagram/_fake_data/helper/random_display_name.dart';
import 'package:instagram/_fake_data/helper/random_image_url.dart';
import 'package:instagram/object/ig_story_shortcut_object.dart';
import 'dart:math';

import 'package:instagram/object/user_object.dart';

Future<List<IgStoryShortcutObject>> igStoryShortcutFake({required int currentIndex}) async {
  await Future.delayed(const Duration(seconds: 1));
  return List<IgStoryShortcutObject>.generate(
      10,
      (index) => IgStoryShortcutObject(
            userObject: UserObject(id: index += currentIndex + 1, displayName: randomDisplayName(), displayImageUrl: randomImageUrl()),
            isSeen: Random().nextBool(),
            isLive: Random().nextBool(),
            friendPoint: Random().nextInt(100),
          ));
}
