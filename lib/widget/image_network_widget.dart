import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';
import 'package:instagram/widget_style/space_style.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageNetworkWidget extends StatelessWidget {
  final bool isCached;
  final String? imageUrl;
  final double iconSize;
  final Color textColor;
  final bool isLoadingCenter;
  final double? imageWidth;
  final double? imageHeight;
  final bool useSizeAssetImage;
  final Color? imageColor;
  final BoxFit boxFit;

  const ImageNetworkWidget({
    Key? key,
    this.isCached = true,
    required this.imageUrl,
    this.iconSize = FontSizeStyle.big,
    this.textColor = ColorStyle.primary,
    this.isLoadingCenter = false,
    this.imageWidth,
    this.imageHeight,
    this.useSizeAssetImage = false,
    this.imageColor,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTried = Rx(0); //tried to load image again.

    final Widget loadingWidget = Container(padding: SpaceStyle.allBasic, width: iconSize, height: iconSize, child: CircularProgressIndicator(strokeWidth: 1, color: textColor));
    final Widget errorWidget = Icon(Icons.image_not_supported_rounded, color: textColor, size: iconSize);

    Widget frameBuilder(BuildContext context, Widget child, int? frame, bool wasSynchronouslyLoaded) {
      if (wasSynchronouslyLoaded) return child;
      if (frame != null) return child;
      if (isLoadingCenter) return Center(child: loadingWidget);
      return loadingWidget;
    }

    Widget errorBuilder(BuildContext context, Object error, dynamic stackTrace) {
      if (isTried.value < 3) Future.delayed(Duration(seconds: isTried.value), () => isTried.value++);
      return Image.asset(
        ImagePath.loadImageFailed,
        width: imageWidth,
        height: imageHeight,
        fit: boxFit,
        frameBuilder: frameBuilder,
        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => errorWidget,
      );
    }

    if (imageUrl == null) return errorWidget;
    if (isCached) {
      return Obx(() {
        isTried.value;
        return CachedNetworkImage(
          imageUrl: imageUrl!,
          width: imageWidth,
          height: imageHeight,
          fit: boxFit,
          color: imageColor,
          placeholder: (context, url) => frameBuilder(context, const SizedBox(), null, true),
          errorWidget: errorBuilder,
        );
      });
    } else {
      return Obx(() {
        isTried.value;
        return Image.network(
          imageUrl!,
          width: imageWidth,
          height: imageHeight,
          fit: boxFit,
          color: imageColor,
          frameBuilder: frameBuilder,
          loadingBuilder: (context, child, lp) => lp == null ? child : errorWidget,
          errorBuilder: errorBuilder,
        );
      });
    }
  }
}
