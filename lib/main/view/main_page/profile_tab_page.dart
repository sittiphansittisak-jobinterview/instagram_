import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/main/controller/main_controller/profile_tab_controller.dart';
import 'package:instagram/main/view/_share/add_ig_story_shortcut_widget.dart';
import 'package:instagram/main/view/_share/ig_story_shortcut_widget.dart';
import 'package:instagram/main/view/_share/image_story_widget.dart';
import 'package:instagram/main/view/_share/user_statistic_widget.dart';
import 'package:instagram/widget/icon_button_widget.dart';
import 'package:instagram/widget/image_network_widget.dart';
import 'package:instagram/widget/snack_bar_dialog_widget.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';
import 'package:instagram/widget_style/space_style.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({super.key});

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  //controller
  final _controller = ProfileController();
  final _igStoryShortcutScrollController = ScrollController();
  final _imageScrollController = ScrollController();
  final _imageTagScrollController = ScrollController();
  late final TabController _imageTabBarController;
  final _currentImageTabIndex = Rx(0);

  //widget helper
  final _tabFocusColor = ColorStyle.dark;
  final _tabUnFocusColor = ColorStyle.dark.withOpacity(0.4);
  final _tabIconSize = 23.0;
  final radius = 43.00;

  //widget
  late final _imageTabBarList = [
    Tab(child: Obx(() => Icon(Icons.grid_on, color: _currentImageTabIndex.value == 0 ? _tabFocusColor : _tabUnFocusColor, size: _tabIconSize))),
    Tab(child: Obx(() => Icon(Icons.account_box_outlined, color: _currentImageTabIndex.value == 1 ? _tabFocusColor : _tabUnFocusColor, size: _tabIconSize))),
  ];
  late final _imageTabBarWidget = TabBar(controller: _imageTabBarController, tabs: _imageTabBarList, indicatorColor: ColorStyle.dark);
  final _loadingWidget = const CircularProgressIndicator();
  final _errorWidget = const Text('เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
  final _someThingWrongWidget = const Text('มีบางอย่างไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง');
  late final _nameTopBarWidget = InkWell(
    splashColor: ColorStyle.none,
    onTap: _controller.onTapNameTopBar,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock, size: 12, color: ColorStyle.dark),
        const SizedBox(width: 6),
        Text(_controller.profileObjectRx.value.userObject?.displayName ?? '-', style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.large, fontWeight: FontWeight.bold)),
        const SizedBox(width: 10),
        const Icon(Icons.keyboard_arrow_down, size: 11, color: ColorStyle.dark),
      ],
    ),
  );
  late final _menuButtonWidget = IconButtonWidget(onPressed: () {}, icon: const Icon(Icons.menu, size: 21, color: ColorStyle.dark));
  late final _imageProfileStoryWidget = InkWell(splashColor: ColorStyle.none, onTap: () => _controller.onTapIgStoryShortcut(_controller.igStoryShortcutObjectRx.value.userObject?.id), child: Obx(() => ProfileImageStoryWidget(radius: radius, object: _controller.igStoryShortcutObjectRx.value)));
  late final _statisticsWidget = Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UserStatisticWidget(title: 'Posts', count: _controller.profileObjectRx.value.postCount ?? 0),
          InkWell(
            splashColor: ColorStyle.none,
            onTap: () {
              snackBarDialogWidget('open followers page');
            },
            child: UserStatisticWidget(title: 'Followers', count: _controller.profileObjectRx.value.followerCount ?? 0),
          ),
          InkWell(
            splashColor: ColorStyle.none,
            onTap: () {
              snackBarDialogWidget('open following page');
            },
            child: UserStatisticWidget(title: 'Following', count: _controller.profileObjectRx.value.followingCount ?? 0),
          ),
        ],
      ));
  late final _nameWidget = Obx(() => Text(_controller.profileObjectRx.value.userObject?.displayName ?? '-', style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.small, fontWeight: FontWeight.bold)));
  late final _bioWidget = Obx(() => Text(_controller.profileObjectRx.value.bio ?? '-', style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.small)));
  late final _editProfileButton = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: ColorStyle.light, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6), side: BorderSide(color: ColorStyle.dark.withOpacity(0.18), width: 1))),
    onPressed: () {
      snackBarDialogWidget('open edit profile page');
    },
    child: const Text('Edit Profile', style: TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.normal, fontWeight: FontWeight.bold)),
  );
  late final _igStoryBarWidget = FutureBuilder(
    future: _controller.getIgStoryShortcutList(),
    builder: (context, snapshot) {
      final addStoryWidget = Padding(padding: const EdgeInsets.symmetric(horizontal: 9), child: AddIgStoryShortcutWidget(onTap: _controller.onTapAddIgStory));
      const spaceHelper = SizedBox(width: 5);
      if (snapshot.connectionState == ConnectionState.waiting) return Row(children: [spaceHelper, addStoryWidget]);
      if (snapshot.hasError) {
        debugPrint('Error in _igStoryBarWidget: ${snapshot.error}');
        return Row(children: [spaceHelper, addStoryWidget, const SizedBox(width: 9), _errorWidget]);
      }
      if (snapshot.data != true) return _someThingWrongWidget;
      return Obx(() => ListView.builder(
            controller: _igStoryShortcutScrollController,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _controller.igStoryShortcutObjectListRx.value.length + 3,
            itemBuilder: (context, index) {
              if (index == 0) return spaceHelper;
              if (index == 1) return addStoryWidget;
              index = index - 2;
              return Padding(padding: const EdgeInsets.symmetric(horizontal: 9), child: index == _controller.igStoryShortcutObjectListRx.value.length ? Center(child: _loadingWidget) : IgStoryShortcutWidget(object: _controller.igStoryShortcutObjectListRx.value[index], onTapStory: _controller.onTapIgStoryShortcut, onTapUser: _controller.onTapIgStoryShortcut));
            },
          ));
    },
  );
  late final _imageListWidget = FutureBuilder(
    future: _controller.getImageList(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox();
      if (snapshot.hasError) {
        debugPrint('Error in _imageListWidget: ${snapshot.error}');
        return Center(child: _errorWidget);
      }
      if (snapshot.data != true) return Center(child: _someThingWrongWidget);
      _onImageScrollNotAvailable();
      return Obx(
        () => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside the GridView
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1.0, mainAxisSpacing: 1.0, childAspectRatio: 1.0),
          itemCount: _controller.imageListRx.value.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => _controller.onTapImage(index),
              child: ImageNetworkWidget(
                imageUrl: _controller.imageListRx.value[index],
                isCached: true,
              ),
            );
          },
        ),
      );
    },
  );

  late final _imageTagListWidget = FutureBuilder(
    future: _controller.getImageTagList(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox();
      if (snapshot.hasError) {
        debugPrint('Error in _imageListWidget: ${snapshot.error}');
        return Center(child: _errorWidget);
      }
      if (snapshot.data != true) return Center(child: _someThingWrongWidget);
      _onImageTagScrollNotAvailable();
      return Obx(
        () => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside the GridView
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1.0, mainAxisSpacing: 1.0, childAspectRatio: 1.0),
          itemCount: _controller.imageTagListRx.value.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () => _controller.onTapImage(index),
              child: ImageNetworkWidget(
                imageUrl: _controller.imageTagListRx.value[index],
                isCached: true,
              ),
            );
          },
        ),
      );
    },
  );

  //function
  void _onIgStoryShortcutScroll() {
    if (_igStoryShortcutScrollController.position.pixels == _igStoryShortcutScrollController.position.maxScrollExtent) _controller.getIgStoryShortcutList();
  }

  void _onImageScrollController() {
    if (_imageScrollController.position.pixels == _imageScrollController.position.maxScrollExtent) _controller.getImageList();
  }

  void _onImageTagScrollController() {
    if (_imageTagScrollController.position.pixels == _imageTagScrollController.position.maxScrollExtent) _controller.getImageTagList();
  }

  //Using for image not enough to fill screen
  Future _onImageScrollNotAvailable() async {
    await Future.delayed(Duration.zero);
    if (_imageScrollController.position.maxScrollExtent != 0) return;
    await _controller.getImageList();
    _onImageScrollNotAvailable();
  }

//Using for image not enough to fill screen
  Future _onImageTagScrollNotAvailable() async {
    await Future.delayed(Duration.zero);
    if (_imageTagScrollController.position.maxScrollExtent != 0) return;
    await _controller.getImageTagList();
    _onImageTagScrollNotAvailable();
  }

  @override
  void initState() {
    super.initState();
    _igStoryShortcutScrollController.addListener(_onIgStoryShortcutScroll);
    _imageScrollController.addListener(_onImageScrollController);
    _imageTagScrollController.addListener(_onImageTagScrollController);
    _imageTabBarController = TabController(length: _imageTabBarList.length, vsync: this)
      ..addListener(() {
        _currentImageTabIndex.value = _imageTabBarController.index;
      });
    _controller.getUserProfile();
  }

  @override
  void dispose() {
    _igStoryShortcutScrollController.dispose();
    _imageScrollController.dispose();
    _imageTagScrollController.dispose();
    _imageTabBarController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: ColorStyle.mute,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            height: 44,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Center(child: _nameTopBarWidget),
                Padding(padding: const EdgeInsets.only(right: 18), child: _menuButtonWidget),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 11), child: _imageProfileStoryWidget),
                      Expanded(child: _statisticsWidget),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _nameWidget,
                        _bioWidget,
                        const SizedBox(height: 7.5),
                        SizedBox(width: double.infinity, child: _editProfileButton),
                      ],
                    ),
                  ),
                  Container(alignment: Alignment.centerLeft, width: double.infinity, height: 115, decoration: BoxDecoration(color: ColorStyle.mute, border: Border(bottom: BorderSide(color: ColorStyle.dark.withOpacity(0.2), width: 1))), child: _igStoryBarWidget),
                  // _imageListWidget,
                  DefaultTabController(
                    length: _imageTabBarList.length,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _imageTabBarWidget,
                        SizedBox(
                          height: 812 > MediaQuery.of(context).size.height ? MediaQuery.of(context).size.height : 812, //waiting for upgrade
                          child: TabBarView(
                            controller: _imageTabBarController,
                            children: [
                              SingleChildScrollView(
                                  controller: _imageScrollController,
                                  child: Column(children: [
                                    _imageListWidget,
                                    Container(alignment: Alignment.center, margin: SpaceStyle.allBasic, child: _loadingWidget),
                                  ])),
                              SingleChildScrollView(
                                  controller: _imageTagScrollController,
                                  child: Column(children: [
                                    _imageTagListWidget,
                                    Container(alignment: Alignment.center, margin: SpaceStyle.allBasic, child: _loadingWidget),
                                  ])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
