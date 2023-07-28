import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/object/post_object.dart';
import 'package:instagram/widget/icon_button_widget.dart';
import 'package:instagram/widget/image_network_widget.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  final PostObject object;
  final Function(dynamic id) onTapUser;
  final Function(dynamic id) onTapLocation;
  final Function(dynamic id) onTapMore;
  final Function(dynamic id) onTapLikeDetail;
  final Function(dynamic id) onTapShare;
  final Function(dynamic id) onTapComment;
  final Future<bool> Function({required dynamic postId, required bool isLike})? onLike;
  final Future<bool> Function({required dynamic postId, required bool isSave})? onSave;
  const PostWidget({super.key, required this.object, required this.onTapUser, required this.onTapLocation, required this.onTapMore, required this.onTapLikeDetail, required this.onTapShare, required this.onTapComment, this.onLike, this.onSave});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);
    final imageIndex = Rx(0);
    final isLike = Rx(object.isLike == true)..listen((value) => object.isLike = value);
    final isSave = Rx(object.isSave == true)..listen((value) => object.isSave = value);

    final screenWidth = MediaQuery.of(context).size.width < 375.0 ? MediaQuery.of(context).size.width : 375.0;
    const textRegStyle = TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.normal);
    const textBoldStyle = TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.normal, fontWeight: FontWeight.bold);

    late final userImageWidget = InkWell(
      onTap: () => onTapUser(object.userObject!.id),
      child: ClipOval(child: SizedBox.fromSize(size: const Size.fromRadius(16), child: ImageNetworkWidget(imageUrl: object.userObject!.displayImageUrl!))),
    );
    final userNameWidget = InkWell(
      onTap: () => onTapUser(object.userObject!.id),
      child: Text(object.userObject?.displayName ?? '-', style: textBoldStyle),
    );
    const userOfficialWidget = Icon(Icons.check_circle, size: 10, color: ColorStyle.link);
    final locationWidget = InkWell(
      onTap: () => onTapLocation(object.id),
      child: Text(object.location ?? '-', style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.tiny)),
    );
    final moreWidget = IconButtonWidget(
      onPressed: () => onTapMore(object.id),
      icon: const Icon(Icons.more_horiz, color: ColorStyle.dark),
      constraints: const BoxConstraints(maxWidth: 14),
    );
    final imageListWidget = SizedBox(
      width: double.infinity,
      height: screenWidth,
      child: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        itemCount: object.imageUrlList!.length,
        itemBuilder: (context, index) {
          Future.delayed(Duration.zero, () => imageIndex.value = index);
          return ImageNetworkWidget(imageUrl: object.imageUrlList![index], isCached: index == 0); //to cache cover photo
        },
      ),
    );
    final imageNumberIndicatorWidget = Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: ColorStyle.dark.withOpacity(0.5), borderRadius: BorderRadius.circular(13)), child: Obx(() => Text('${imageIndex.value + 1}/${object.imageUrlList!.length}', style: const TextStyle(color: ColorStyle.light, fontSize: FontSizeStyle.small))));
    final imageDotIndicatorListWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate((object.imageUrlList ?? []).length, (index) {
          final sizePercent = 1 - 0.25 * (object.imageUrlList!.length / 10).floor(); //to make indicator size smaller when image count is more than 10
          if (object.imageUrlList!.length == 1 || (sizePercent < 0 && index != 0)) return const SizedBox();
          const size = 6.0;
          if (sizePercent < 0) return Container(margin: const EdgeInsets.symmetric(horizontal: 2.0), width: size, height: size, decoration: const BoxDecoration(shape: BoxShape.circle, color: ColorStyle.link));
          return InkWell(
            onTap: () {
              pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
            },
            child: Obx(() => Container(margin: EdgeInsets.symmetric(horizontal: 2.0 * sizePercent), width: size * sizePercent, height: size * sizePercent, decoration: BoxDecoration(shape: BoxShape.circle, color: index == imageIndex.value ? ColorStyle.link : ColorStyle.dark.withOpacity(0.15)))),
          );
        }));
    final likeWidget = IconButtonWidget(
      onPressed: () async {
        if (onLike == null) return;
        isLike.value = !isLike.value;
        final isSuccess = await onLike!(postId: object.id, isLike: isLike.value);
        if (!isSuccess) isLike.value = !isLike.value;
      },
      icon: Obx(() => Icon(isLike.value ? Icons.favorite : Icons.favorite_border, color: isLike.value ? ColorStyle.like : ColorStyle.dark)),
      constraints: const BoxConstraints(maxWidth: 13.66),
    );
    final commentWidget = IconButtonWidget(
      onPressed: () => onTapComment(object.id),
      icon: const Icon(Icons.chat_bubble_outline, color: ColorStyle.dark),
      constraints: const BoxConstraints(maxWidth: 22),
    );
    final shareWidget = IconButtonWidget(
      onPressed: () => onTapShare(object.id),
      icon: const Icon(Icons.send_outlined, color: ColorStyle.dark),
      constraints: const BoxConstraints(maxWidth: 22.73),
    );
    final saveWidget = IconButtonWidget(
      onPressed: () async {
        if (onSave == null) return;
        isSave.value = !isSave.value;
        final isSuccess = await onSave!(postId: object.id, isSave: isSave.value);
        if (!isSuccess) isSave.value = !isSave.value;
      },
      icon: Obx(() => Icon(isSave.value ? Icons.bookmark : Icons.bookmark_border, color: ColorStyle.dark)),
      constraints: const BoxConstraints(maxWidth: 20.5),
    );
    final likeUserImageWidget = InkWell(
      onTap: () => onTapUser(object.userLikeObject!.id),
      child: ClipOval(child: SizedBox.fromSize(size: const Size.fromRadius(8.5), child: ImageNetworkWidget(imageUrl: object.userLikeObject!.displayImageUrl!))),
    );
    const likedByWidget = Text('Liked by ', style: textRegStyle);
    final likeUserNameWidget = InkWell(
      onTap: () => onTapUser(object.userLikeObject!.id),
      child: Text(object.userLikeObject?.displayName ?? '-', style: textBoldStyle),
    );
    const andWidget = Text(' and ', style: textRegStyle);
    final likeUserCountWidget = InkWell(
      onTap: () => onTapLikeDetail(object.id),
      child: Text('${object.likeCount == null ? '-' : NumberFormat.decimalPattern().format(object.likeCount)} others', style: textBoldStyle),
    );
    final descriptionWidget = RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '${object.userObject?.displayName ?? '-'} ', style: textBoldStyle, recognizer: TapGestureRecognizer()..onTap = () => onTapUser(object.userObject!.id)),
          TextSpan(text: ' ${object.description ?? ''}', style: textRegStyle),
        ],
      ),
    );
    final createAtWidget = Text(object.createAt == null ? '-' : DateFormat('MMMM dd').format(object.createAt!), style: TextStyle(color: ColorStyle.dark.withOpacity(0.4), fontSize: FontSizeStyle.tiny));

    final userBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: userImageWidget),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    userNameWidget,
                    if (object.userObject?.isOfficial == true) const Padding(padding: EdgeInsets.only(left: 9), child: userOfficialWidget),
                  ],
                ),
                if (object.location != null) locationWidget,
              ],
            )
          ],
        ),
        Padding(padding: const EdgeInsets.only(right: 15), child: moreWidget),
      ],
    );
    final imageBody = Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            imageListWidget,
            if (object.imageUrlList!.length > 1) Padding(padding: const EdgeInsets.all(14), child: imageNumberIndicatorWidget),
          ],
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 14),
                    likeWidget,
                    const SizedBox(width: 17),
                    commentWidget,
                    const SizedBox(width: 17),
                    shareWidget,
                  ],
                ),
                Padding(padding: const EdgeInsets.only(right: 16), child: saveWidget),
              ],
            ),
            imageDotIndicatorListWidget,
          ],
        ),
      ],
    );
    final likeBar = Row(
      children: [
        Padding(padding: const EdgeInsets.only(left: 15), child: likeUserImageWidget),
        const SizedBox(width: 8),
        likedByWidget,
        likeUserNameWidget,
        andWidget,
        likeUserCountWidget,
      ],
    );

    return Column(
      children: [
        SizedBox(height: 54, child: userBar),
        imageBody,
        const SizedBox(height: 14),
        likeBar,
        const SizedBox(height: 9),
        Container(alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 15), child: descriptionWidget),
        const SizedBox(height: 15),
        Container(alignment: Alignment.centerLeft, padding: const EdgeInsets.symmetric(horizontal: 15), child: createAtWidget),
        const SizedBox(height: 11),
      ],
    );
  }
}
