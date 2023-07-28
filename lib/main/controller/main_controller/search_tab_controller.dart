import 'dart:math';
import 'package:get/get.dart';
import 'package:instagram/_fake_data/helper/random_image_url.dart';
import 'package:instagram/_fake_data/ig_story_shortcut_fake.dart';
import 'package:instagram/_fake_data/post_fake.dart';
import 'package:instagram/object/ig_story_shortcut_object.dart';
import 'package:instagram/object/post_object.dart';
import 'package:instagram/object/user_object.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/utility/sort_object_list.dart';
import 'package:instagram/widget/snack_bar_dialog_widget.dart';

class SearchTabController {
  bool isImageListLoading = false;

  final imageListRx = Rx(<String>[]);

  void onTapLive() {
    snackBarDialogWidget('Live');
  }

  void onTapIgtv() {
    snackBarDialogWidget('IGTV');
  }

  void onTapShop() {
    snackBarDialogWidget('Shop');
  }

  void onTapStyle() {
    snackBarDialogWidget('Style');
  }

  void onTapSport() {
    snackBarDialogWidget('Sport');
  }

  void onTapAuto() {
    snackBarDialogWidget('Auto');
  }

  void onTapMusic() {
    snackBarDialogWidget('Music');
  }

  void onTapImage(int index) {
    snackBarDialogWidget('Image $index');
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
}
