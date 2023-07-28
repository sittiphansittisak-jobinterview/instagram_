import 'dart:math';
import 'package:get/get.dart';
import 'package:instagram/_fake_data/helper/random_image_url.dart';
import 'package:instagram/_fake_data/ig_story_shortcut_fake.dart';
import 'package:instagram/object/ig_story_shortcut_object.dart';
import 'package:instagram/object/profile_object.dart';
import 'package:instagram/object/user_object.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/widget/snack_bar_dialog_widget.dart';

class ProfileController {
  bool isUserProfileLoading = false;
  bool isIgStoryShortcutLoading = false;
  bool isImageListLoading = false;
  bool isImageTagListLoading = false;

  final profileObjectRx = Rx(ProfileObject(
    userObject: UserObject(id: 'myId', displayName: 'Your Name', displayImageUrl: ImagePath.userImageUrl), //should be get from local storage after login
    bio: 'Digital goodies designer @pixsellz\nEverything is designed.',
  ));
  final igStoryShortcutObjectRx = Rx(IgStoryShortcutObject(
    userObject: UserObject(id: 'myId', displayName: 'Your Name', displayImageUrl: ImagePath.userImageUrl), //should be get from local storage after login
    isSeen: true,
    isLive: false,
  ));
  final igStoryShortcutObjectListRx = Rx(<IgStoryShortcutObject>[]);
  final imageListRx = Rx(<String>[]);
  final imageTagListRx = Rx(<String>[]);

  void onTapNameTopBar() {
    snackBarDialogWidget('onTapNameTopBar');
  }

  void onTapAddIgStory() {
    snackBarDialogWidget('onTapAddIgStory');
  }

  void onTapIgStoryShortcut(dynamic id) {
    snackBarDialogWidget('onTapIgStoryShortcut $id');
  }

  void onTapImage(int index) {
    snackBarDialogWidget('onTapImage $index');
  }

  Future<bool> getUserProfile() async {
    if (isUserProfileLoading) return false;
    await Future.delayed(const Duration(seconds: 1));
    isUserProfileLoading = true;
    final random = Random();
    final profileObject = ProfileObject(
      userObject: UserObject(id: 'myId', displayName: 'Your New Name', displayImageUrl: ImagePath.userImageUrl),
      postCount: random.nextInt(9999),
      followerCount: random.nextInt(9999),
      followingCount: random.nextInt(9999),
      bio: 'Digital goodies designer @pixsellz\nEverything is designed.',
    );
    igStoryShortcutObjectRx.value = IgStoryShortcutObject(userObject: profileObject.userObject, isSeen: false, isLive: false);
    profileObjectRx.value = profileObject;
    isUserProfileLoading = false;
    return true;
  }

  Future<bool> getIgStoryShortcutList() async {
    if (isIgStoryShortcutLoading) return false;
    isIgStoryShortcutLoading = true;
    final igStoryShortcutObjectList = await igStoryShortcutFake(currentIndex: igStoryShortcutObjectListRx.value.length, isMe: true);
    igStoryShortcutObjectListRx.value = [...igStoryShortcutObjectListRx.value, ...igStoryShortcutObjectList];
    isIgStoryShortcutLoading = false;
    return true;
  }

  Future<bool> getImageList() async {
    if (isImageListLoading) return false;
    await Future.delayed(const Duration(seconds: 1));
    isImageListLoading = true;
    final imageList = List<String>.generate(10, (index) => randomImageUrl(isLarge: true, isRequiredBg: true));
    imageListRx.value = [...imageListRx.value, ...imageList];
    isImageListLoading = false;
    return true;
  }

  Future<bool> getImageTagList() async {
    if (isImageTagListLoading) return false;
    await Future.delayed(const Duration(seconds: 1));
    isImageTagListLoading = true;
    final imageList = List<String>.generate(10, (index) => randomImageUrl(isLarge: true, isRequiredBg: true));
    imageTagListRx.value = [...imageTagListRx.value, ...imageList];
    isImageTagListLoading = false;
    return true;
  }
}
