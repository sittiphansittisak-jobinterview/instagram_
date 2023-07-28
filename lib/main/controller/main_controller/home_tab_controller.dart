import 'dart:math';
import 'package:get/get.dart';
import 'package:instagram/_fake_data/ig_story_shortcut_fake.dart';
import 'package:instagram/_fake_data/post_fake.dart';
import 'package:instagram/object/ig_story_shortcut_object.dart';
import 'package:instagram/object/post_object.dart';
import 'package:instagram/object/user_object.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/utility/sort_object_list.dart';
import 'package:instagram/widget/snack_bar_dialog_widget.dart';

class HomeTabController {
  bool isIgStoryShortcutLoading = false;
  bool isPostLoading = false;

  final igStoryShortcutObjectListRx = Rx(<IgStoryShortcutObject>[IgStoryShortcutObject(userObject: UserObject(id: 'myId', displayName: 'Your Story', displayImageUrl: ImagePath.userImageUrl))]);
  final postObjectListRx = Rx(<PostObject>[]);

  void onTapCamera() {
    snackBarDialogWidget('Camera');
  }

  void onTapLiveTv() {
    snackBarDialogWidget('Live TV');
  }

  void onTapMessage() {
    snackBarDialogWidget('Message');
  }

  void onTapIgStoryShortcut(dynamic id) {
    snackBarDialogWidget('Ig Story Shortcut $id');
  }

  void onTapUser(dynamic id) {
    snackBarDialogWidget('User $id');
  }

  void onTapLocation(dynamic id) {
    snackBarDialogWidget('onTapLocation $id');
  }

  void onTapMore(dynamic id) {
    snackBarDialogWidget('More $id');
  }


  void onTapShare(dynamic id) {
    snackBarDialogWidget('onTapShare $id');
  }
  void onTapComment(dynamic id) {
    snackBarDialogWidget('onTapComment $id');
  }
  void onTapLikeDetail(dynamic id) {
    snackBarDialogWidget('Like Detail $id');
  }

  Future<bool> getIgStoryShortcutList() async {
    if (isIgStoryShortcutLoading) return false;
    isIgStoryShortcutLoading = true;
    final igStoryShortcutObjectList = await igStoryShortcutFake(currentIndex: igStoryShortcutObjectListRx.value.length);
    SortObjectList.igStoryShortcut(igStoryShortcutObjectList); //should sorted from backend
    igStoryShortcutObjectListRx.value = [...igStoryShortcutObjectListRx.value, ...igStoryShortcutObjectList];
    isIgStoryShortcutLoading = false;
    return true;
  }

  Future<bool> getPostList() async {
    if (isPostLoading) return false;
    isPostLoading = true;
    postObjectListRx.value = [...postObjectListRx.value, ...await postFake(currentIndex: postObjectListRx.value.length)];
    isPostLoading = false;
    return true;
  }

  Future<bool> likePost({required dynamic postId, required bool isLike}) async {
    await Future.delayed(const Duration(seconds: 1));
    final random = Random();
    return random.nextBool();
  }

  Future<bool> savePost({required dynamic postId, required bool isSave}) async {
    await Future.delayed(const Duration(seconds: 1));
    final random = Random();
    return random.nextBool();
  }
}
