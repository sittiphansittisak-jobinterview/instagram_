import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram/main/view/_share/screen_template_widget.dart';
import 'package:instagram/main/view/main_page/add_tab_page.dart';
import 'package:instagram/main/view/main_page/home_tab_page.dart';
import 'package:instagram/main/view/main_page/likes_tab_page.dart';
import 'package:instagram/main/view/main_page/profile_tab_page.dart';
import 'package:instagram/main/view/main_page/search_tab_page.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/path/page_path.dart';
import 'package:instagram/widget_style/color_style.dart';
import "package:universal_html/html.dart";

class MainPage extends StatefulWidget {
  final String path;

  const MainPage({super.key, required this.path});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  //controller
  late final TabController _tabBarController;
  final currentTabIndex = Rx(0);

  //widget helper
  final iconSize = 24.00;
  final iconColor = ColorStyle.dark;

  //widget
  late final _tabBarList = [
    Tab(icon: Obx(() => Icon(currentTabIndex.value == 0 ? Icons.home_filled : Icons.home_outlined, size: iconSize, color: iconColor))),
    Tab(icon: Obx(() => Icon(currentTabIndex.value == 1 ? Icons.saved_search_rounded : Icons.search_outlined, size: iconSize, color: iconColor))),
    Tab(icon: Icon(FontAwesomeIcons.squarePlus, size: iconSize, color: iconColor)),
    Tab(icon: Obx(() => Icon(currentTabIndex.value == 3 ? Icons.favorite : Icons.favorite_border, size: iconSize, color: iconColor))),
    Tab(icon: CircleAvatar(radius: iconSize / 2, backgroundImage: const NetworkImage(ImagePath.userImageUrl))),
  ];
  late final _tabBarWidget = TabBar(controller: _tabBarController, tabs: _tabBarList, indicatorColor: ColorStyle.none);
  final _homeTabWidget = const HomeTabPage();
  final _searchTabWidget = const SearchTabPage();
  final _addTabWidget = const AddTabPage();
  final _likesTabWidget = const LikesTabPage();
  final _profileTabWidget = const ProfileTabPage();

  int getTabIndexFromPath(String path) {
    switch (path) {
      case PagePath.home:
        return 0;
      case PagePath.search:
        return 1;
      case PagePath.add:
        return 2;
      case PagePath.likes:
        return 3;
      case PagePath.profile:
        return 4;
      default:
        return 0;
    }
  }

  void updateUrlFromTabIndex(int index) {
    switch (index) {
      case 0:
        return window.history.pushState(null, 'home', PagePath.home);
      case 1:
        return window.history.pushState(null, 'search', PagePath.search);
      case 2:
        return window.history.pushState(null, 'add', PagePath.add);
      case 3:
        return window.history.pushState(null, 'likes', PagePath.likes);
      case 4:
        return window.history.pushState(null, 'profile', PagePath.profile);
      default:
        return window.history.pushState(null, 'home', PagePath.home);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(length: _tabBarList.length, vsync: this, initialIndex: getTabIndexFromPath(widget.path))
      ..addListener(() {
        currentTabIndex.value = _tabBarController.index;
        updateUrlFromTabIndex(_tabBarController.index);
      });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateWidget(
      color: ColorStyle.mute,
      child: DefaultTabController(
        length: _tabBarList.length,
        child: Scaffold(
          bottomNavigationBar: Container(margin: const EdgeInsets.only(bottom: 34), height: 45, decoration: BoxDecoration(color: ColorStyle.mute, border: Border(top: BorderSide(color: ColorStyle.dark.withOpacity(0.2), width: 1))), child: _tabBarWidget),
          body: TabBarView(
            controller: _tabBarController,
            physics: const NeverScrollableScrollPhysics(), // Prevent the TabBarView from scrolling
            children: [
              _homeTabWidget,
              _searchTabWidget,
              _addTabWidget,
              _likesTabWidget,
              _profileTabWidget,
            ],
          ),
        ),
      ),
    );
  }
}
