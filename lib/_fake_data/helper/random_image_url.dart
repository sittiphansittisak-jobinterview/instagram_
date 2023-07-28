import 'dart:math';

String randomImageUrl({bool isLarge = false, bool isRequiredBg = false}) {
  const targetString = '*****';
  final size = isLarge ? '500' : '100';
  final urlList = [
    'https://picsum.photos/id/$targetString/$size/$size',
    if (!isRequiredBg) 'https://robohash.org/$targetString?size=${size}x$size',
    if (!isRequiredBg) 'https://avatars.dicebear.com/api/avataaars/$targetString.jpg',
  ];
  final random = Random();
  final index = random.nextInt(urlList.length);
  final newIndexOfUserLiked = random.nextInt(100);
  return urlList[index].replaceAll(targetString, newIndexOfUserLiked.toString());
}
