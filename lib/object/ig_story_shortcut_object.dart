import 'package:instagram/object/user_object.dart';
import 'package:instagram/object_key/ig_story_shortcut_object_key.dart';

class IgStoryShortcutObject {
  UserObject? userObject;
  bool? isSeen;
  bool? isLive;
  DateTime? createAt;
  int? friendPoint;

  IgStoryShortcutObject({
    this.userObject,
    this.isSeen,
    this.isLive,
    this.createAt,
    this.friendPoint,
  });

  IgStoryShortcutObject.fromJson(Map<String, dynamic> json) {
    userObject = json[IgStoryShortcutObjectKey.userObject] != null ? UserObject.fromJson(json[IgStoryShortcutObjectKey.userObject]) : null;
    isSeen = json[IgStoryShortcutObjectKey.isSeen];
    isLive = json[IgStoryShortcutObjectKey.isLive];
    createAt = json[IgStoryShortcutObjectKey.createAt];
    friendPoint = json[IgStoryShortcutObjectKey.friendPoint];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userObject != null) data[IgStoryShortcutObjectKey.userObject] = userObject!.toJson();
    data[IgStoryShortcutObjectKey.isSeen] = isSeen;
    data[IgStoryShortcutObjectKey.isLive] = isLive;
    data[IgStoryShortcutObjectKey.createAt] = createAt;
    data[IgStoryShortcutObjectKey.friendPoint] = friendPoint;
    return data;
  }
}
