import 'package:instagram/_fake_data/helper/random_datetime.dart';
import 'package:instagram/_fake_data/helper/random_description.dart';
import 'package:instagram/_fake_data/helper/random_display_name.dart';
import 'package:instagram/_fake_data/helper/random_image_url.dart';
import 'package:instagram/object/post_object.dart';
import 'dart:math';

import 'package:instagram/object/user_object.dart';

Future<List<PostObject>> postFake({required int currentIndex}) async {
  await Future.delayed(const Duration(seconds: 1));
  final random = Random();
  final postObjectList = <PostObject>[];
  for (var i = 1; i <= 10; i++) {
    final newIndexOfPost = currentIndex + i;
    final newIndexOfUser = currentIndex + i;
    final newIndexOfUserLiked = currentIndex + i + 1;
    final userObject = UserObject(
      id: 'userId $newIndexOfUser',
      isOfficial: random.nextBool(),
      displayName:  randomDisplayName(),
      displayImageUrl: randomImageUrl(),
    );
    final userLikeObject = UserObject(
      id: 'userLikeId $newIndexOfUserLiked',
      isOfficial: random.nextBool(),
      displayName:  randomDisplayName(),
      displayImageUrl: randomImageUrl(),
    );
    final postObject = PostObject(
      id: 'postId $newIndexOfPost',
      userObject: userObject,
      userLikeObject: userLikeObject,
      location: random.nextBool() ? 'location $newIndexOfPost' : null,
      imageUrlList: List<String>.generate(random.nextInt(50) + 1, (index) => randomImageUrl(isLarge: true)),
      description: randomDescription(),
      createAt: randomDateTime(),
      isLike: random.nextBool(),
      likeCount: random.nextInt(random.nextBool() ? 99999999 : 9999),
      isSave: random.nextBool(),
    );
    postObjectList.add(postObject);
  }
  return postObjectList;
}
