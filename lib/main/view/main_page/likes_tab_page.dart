import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';

class LikesTabPage extends StatefulWidget {
  const LikesTabPage({super.key});

  @override
  State<LikesTabPage> createState() => _LikesTabPageState();
}

class _LikesTabPageState extends State<LikesTabPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  //controller
  late final TabController _tabBarController;
  final _currentTabIndex = Rx(0);

  //widget helper
  final _tabFocusColor = ColorStyle.dark;
  final _tabUnFocusColor = ColorStyle.dark.withOpacity(0.4);

  //widget
  late final _tabBarList = [
    Tab(child: Obx(() => Text('Following', style: TextStyle(color: _currentTabIndex.value == 0 ? _tabFocusColor : _tabUnFocusColor, fontSize: FontSizeStyle.large, fontWeight: FontWeight.bold)))),
    Tab(child: Obx(() => Text('You', style: TextStyle(color: _currentTabIndex.value == 1 ? _tabFocusColor : _tabUnFocusColor, fontSize: FontSizeStyle.large, fontWeight: FontWeight.bold)))),
  ];
  late final _tabBarWidget = TabBar(controller: _tabBarController, tabs: _tabBarList, indicatorColor: ColorStyle.dark);

  @override
  void initState() {
    super.initState();
    _tabBarController = TabController(length: _tabBarList.length, vsync: this)
      ..addListener(() {
        _currentTabIndex.value = _tabBarController.index;
      });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultTabController(
      length: _tabBarList.length,
      child: Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(44), child: _tabBarWidget), //appBar without appBar
        body: TabBarView(
          controller: _tabBarController,
          children: [
            Container(color: Colors.red),
            Container(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
