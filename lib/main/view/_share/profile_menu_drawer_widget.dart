import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';

class ProfileMenuDrawerWidget extends StatelessWidget {
  const ProfileMenuDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget menuBuilder({required IconData icon, required String text, required Function() onTap}) => ListTile(
          leading: Icon(icon, size: 24, color: ColorStyle.dark),
          title: Text(text, style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.big)),
          onTap: onTap,
        );

    const nameWidget = Text('s.khasanov_'); //fake user
    //waiting for upgrade
    final archiveWidget = menuBuilder(icon: FontAwesomeIcons.clockRotateLeft, text: 'Archive', onTap: () {});
    final yourActivityWidget = menuBuilder(icon: FontAwesomeIcons.clock, text: 'Your Activity', onTap: () {});
    final nameTagWidget = menuBuilder(icon: FontAwesomeIcons.qrcode, text: 'Nametag', onTap: () {});
    final savedWidget = menuBuilder(icon: FontAwesomeIcons.bookmark, text: 'Saved', onTap: () {});
    final closeFriendsWidget = menuBuilder(icon: FontAwesomeIcons.listUl, text: 'Close Friends', onTap: () {});
    final discoverPeopleWidget = menuBuilder(icon: FontAwesomeIcons.userPlus, text: 'Discover People', onTap: () {});
    final openFacebookWidget = menuBuilder(icon: FontAwesomeIcons.facebook, text: 'Open Facebook', onTap: () {});
    final settingsWidget = menuBuilder(icon: FontAwesomeIcons.gear, text: 'Settings', onTap: () {});

    return Drawer(
      backgroundColor: ColorStyle.light,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 14, left: 15), child: nameWidget),
                archiveWidget,
                yourActivityWidget,
                nameTagWidget,
                savedWidget,
                closeFriendsWidget,
                discoverPeopleWidget,
                openFacebookWidget,
              ],
            ),
            settingsWidget,
          ],
        ),
      ),
    );
  }
}
