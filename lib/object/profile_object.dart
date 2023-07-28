import 'package:instagram/object/user_object.dart';
import 'package:instagram/object_key/profile_object_key.dart';

class ProfileObject {
  UserObject? userObject;
  int? postCount;
  int? followerCount;
  int? followingCount;
  String? bio;

  ProfileObject({this.userObject, this.postCount, this.followerCount, this.followingCount,  this.bio});

  ProfileObject.fromJson(Map<String, dynamic> json) {
    userObject = json[ProfileObjectKey.userObject] != null ? UserObject.fromJson(json[ProfileObjectKey.userObject]) : null;
    postCount = json[ProfileObjectKey.postCount];
    followerCount = json[ProfileObjectKey.followerCount];
    followingCount = json[ProfileObjectKey.followingCount];
    bio = json[ProfileObjectKey.bio];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userObject != null) data[ProfileObjectKey.userObject] = userObject!.toJson();
    data[ProfileObjectKey.postCount] = postCount;
    data[ProfileObjectKey.followerCount] = followerCount;
    data[ProfileObjectKey.followingCount] = followingCount;
    data[ProfileObjectKey.bio] = bio;
    return data;
  }
}
