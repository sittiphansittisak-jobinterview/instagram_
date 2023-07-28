import 'package:instagram/object/ig_story_shortcut_object.dart';

class SortObjectList {
  static void igStoryShortcut(List<IgStoryShortcutObject> objectList) {
    objectList.sort((a, b) {
      if ((a.isSeen != true || a.isLive == true) && (b.isSeen != true || b.isLive == true)) return b.friendPoint!.compareTo(a.friendPoint!);
      if (a.isSeen != true || a.isLive == true) return -1;
      return 1;
    });
  }
}
