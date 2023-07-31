import 'package:instagram/_fake_data/helper/random_datetime.dart';
import 'package:instagram/_fake_data/helper/random_display_name.dart';
import 'package:instagram/_fake_data/helper/random_image_url.dart';
import 'package:instagram/_fake_data/helper/random_title.dart';
import 'package:instagram/object/ig_story_shortcut_object.dart';
import 'dart:math';

import 'package:instagram/object/user_object.dart';

Future<List<IgStoryShortcutObject>> igStoryShortcutFake({required int currentIndex, bool isMe = false}) async {
  await Future.delayed(const Duration(seconds: 1));
  return List<IgStoryShortcutObject>.generate(
      10,
      (index) => IgStoryShortcutObject(
            userObject: UserObject(id: index += currentIndex + 1, displayName: isMe ? randomTitle() : randomDisplayName(), displayImageUrl: randomImageUrl()),
            isSeen: isMe ? true : Random().nextBool(),
            isLive: isMe ? false : Random().nextBool(),
            createAt: randomDateTime(),
            friendPoint: isMe ? null : Random().nextInt(100),
          ));
}
