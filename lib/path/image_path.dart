import 'package:flutter/material.dart';

class ImagePath {
  static const logo = "asset/image/logo/logo.png";
  static const logoTransparent = "asset/image/logo/logo_transparent.png";
  static const logoTextTransparent = "asset/image/logo/logo_text_transparent.png";
  static const loadImageFailed = "asset/image/utility/load_image_failed.png";
  static const applicationFormMenu = "asset/image/menu/se_application_form_menu.png";

  static const loading = "asset/image/utility/loading.png";
  static const loadingGifFast = "asset/image/utility/loading_fast.gif";
  static const loadingGifSlow = "asset/image/utility/loading_slow.gif";

  static const userImageUrl = 'https://avatars.githubusercontent.com/u/132801198?v=4';

  static void prepareImageAsset(BuildContext context) {
    precacheImage(Image.asset(ImagePath.logo).image, context);
    precacheImage(Image.asset(ImagePath.logoTransparent).image, context);
    precacheImage(Image.asset(ImagePath.logoTextTransparent).image, context);
    precacheImage(Image.asset(ImagePath.loadImageFailed).image, context);
    precacheImage(Image.asset(ImagePath.applicationFormMenu).image, context);
    precacheImage(Image.asset(ImagePath.loading).image, context);
    precacheImage(Image.asset(ImagePath.loadingGifFast).image, context);
    precacheImage(Image.asset(ImagePath.loadingGifSlow).image, context);
  }
}
