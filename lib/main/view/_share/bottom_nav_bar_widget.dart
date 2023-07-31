import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/path/page_path.dart';
import 'package:instagram/widget/icon_button_widget.dart';
import 'package:instagram/widget/snack_bar_dialog_widget.dart';
import 'package:instagram/widget_style/color_style.dart';

class BottomNavBarWidget extends StatelessWidget {
  final bool isHome;
  final bool isSearch;
  final bool isLikes;
  final bool isProfile;
  const BottomNavBarWidget({super.key, this.isHome = false, this.isSearch = false, this.isLikes = false, this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    const iconSize = 24.00;
    const iconColor = ColorStyle.dark;

    final homeButtonWidget = IconButtonWidget(
      onPressed: () {
        Navigator.pushNamed(context, PagePath.home);
      },
      icon: Icon(isHome ? Icons.home_filled : Icons.home_outlined, size: iconSize, color: iconColor),
    );
    final searchButtonWidget = IconButtonWidget(
      onPressed: () {
        Navigator.pushNamed(context, PagePath.search);
      },
      icon: Icon(isSearch ? Icons.saved_search_outlined : Icons.search_outlined, size: iconSize, color: iconColor),
    );
    final squarePlusButtonWidget = IconButtonWidget(
      onPressed: () {
        snackBarDialogWidget('squarePlusButtonWidget');
      },
      icon: const Icon(FontAwesomeIcons.squarePlus, size: iconSize, color: iconColor),
    );
    final likesButtonWidget = IconButtonWidget(
      onPressed: () {
        Navigator.pushNamed(context, PagePath.likes);
      },
      icon: Icon(isLikes ? Icons.favorite : Icons.favorite_border, size: iconSize, color: iconColor),
    );
    final profileButtonWidget = InkWell(
      onTap: () {
        Navigator.pushNamed(context, PagePath.profile);
      },
      child: const CircleAvatar(radius: iconSize / 2, backgroundImage: NetworkImage(ImagePath.userImageUrl)),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [homeButtonWidget, searchButtonWidget, squarePlusButtonWidget, likesButtonWidget, profileButtonWidget],
    );
  }
}
