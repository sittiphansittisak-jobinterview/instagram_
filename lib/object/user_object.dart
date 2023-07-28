import 'package:instagram/object_key/user_object_key.dart';

class UserObject {
  dynamic id;
  bool? isOfficial;
  String? displayName;
  String? displayImageUrl;

  UserObject({this.id, this.isOfficial, this.displayName, this.displayImageUrl});

  UserObject.fromJson(Map<String, dynamic> json) {
    id = json[UserObjectKey.id];
    isOfficial = json[UserObjectKey.isOfficial];
    displayName = json[UserObjectKey.displayName];
    displayImageUrl = json[UserObjectKey.displayImageUrl];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[UserObjectKey.id] = id;
    data[UserObjectKey.isOfficial] = isOfficial;
    data[UserObjectKey.displayName] = displayName;
    data[UserObjectKey.displayImageUrl] = displayImageUrl;
    return data;
  }
}
