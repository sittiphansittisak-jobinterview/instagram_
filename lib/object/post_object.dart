import 'package:instagram/object/user_object.dart';
import 'package:instagram/object_key/post_object_key.dart';

class PostObject {
  dynamic id;
  UserObject? userObject;
  DateTime? createAt;
  String? location;
  List<String>? imageUrlList;
  bool? isLike;
  bool? isSave;
  UserObject? userLikeObject;
  int? likeCount;
  String? description;

  PostObject({this.id, this.userObject, this.createAt, this.location, this.imageUrlList, this.isLike, this.isSave, this.userLikeObject, this.likeCount, this.description});

  PostObject.fromJson(Map<String, dynamic> json) {
    id = json[PostObjectKey.id];
    userObject = json[PostObjectKey.userObject] != null ? UserObject.fromJson(json[PostObjectKey.userObject]) : null;
    createAt = DateTime.parse(json[PostObjectKey.createAt]);
    location = json[PostObjectKey.location];
    imageUrlList = json[PostObjectKey.imageUrlList].cast<String>();
    isLike = json[PostObjectKey.postLike];
    isSave = json[PostObjectKey.postSave];
    userLikeObject = json[PostObjectKey.userLikeObject] != null ? UserObject.fromJson(json[PostObjectKey.userLikeObject]) : null;
    likeCount = json[PostObjectKey.likeCount];
    description = json[PostObjectKey.description];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[PostObjectKey.id] = id;
    data[PostObjectKey.userObject] = userObject?.toJson();
    data[PostObjectKey.createAt] = createAt.toString();
    data[PostObjectKey.location] = location;
    data[PostObjectKey.imageUrlList] = imageUrlList;
    data[PostObjectKey.postLike] = isLike;
    data[PostObjectKey.postSave] = isSave;
    data[PostObjectKey.userLikeObject] = userLikeObject?.toJson();
    data[PostObjectKey.likeCount] = likeCount;
    data[PostObjectKey.description] = description;
    return data;
  }
}
