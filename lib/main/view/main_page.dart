import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/main/controller/main_controller.dart';
import 'package:instagram/main/view/_share/bottom_nav_bar_widget.dart';
import 'package:instagram/main/view/_share/ig_story_shortcut_widget.dart';
import 'package:instagram/main/view/_share/post_widget.dart';
import 'package:instagram/main/view/_share/screen_template_widget.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/widget/icon_button_widget.dart';
import 'package:instagram/widget_style/color_style.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //controller
  final _controller = MainController();
  final _igStoryShortcutScrollController = ScrollController();
  final _postScrollController = ScrollController();

  //widget
  final _bottomNavBarWidget = const BottomNavBarWidget(isHome: true);
  late final _cameraButtonWidget = IconButtonWidget(onPressed: _controller.onTapCamera, icon: const Icon(Icons.camera_alt_outlined, size: 24, color: ColorStyle.dark));
  late final _liveTvButtonWidget = IconButtonWidget(onPressed: _controller.onTapLiveTv, icon: const Icon(Icons.live_tv_outlined, size: 24, color: ColorStyle.dark));
  late final _messageButtonWidget = IconButtonWidget(onPressed: _controller.onTapMessage, icon: const Icon(Icons.send_outlined, size: 23, color: ColorStyle.dark));
  final _logoWidget = Image.asset(ImagePath.logoTextTransparent, height: 28);
  final _loadingWidget = const CircularProgressIndicator();
  final _errorWidget = const Text('เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
  final _someThingWrongWidget = const Text('มีบางอย่างไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง');
  //widget group
  late final _topBarWidget = Stack(
    alignment: Alignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [const SizedBox(width: 12), _cameraButtonWidget]),
          Row(children: [_liveTvButtonWidget, const SizedBox(width: 18), _messageButtonWidget, const SizedBox(width: 16)])
        ],
      ),
      _logoWidget,
    ],
  );
  late final _igStoryBarWidget = FutureBuilder(
    future: _controller.getIgStoryShortcutList(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return _loadingWidget;
      if (snapshot.hasError) {
        debugPrint('Error in _igStoryBarWidget: ${snapshot.error}');
        return _errorWidget;
      }
      if (snapshot.data != true) return _someThingWrongWidget;
      return Obx(() => ListView.builder(
            controller: _igStoryShortcutScrollController,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _controller.igStoryShortcutObjectListRx.value.length + 1,
            itemBuilder: (context, index) => Padding(padding: const EdgeInsets.symmetric(horizontal: 9), child: index == _controller.igStoryShortcutObjectListRx.value.length ? Center(child: _loadingWidget) : IgStoryShortcutWidget(object: _controller.igStoryShortcutObjectListRx.value[index], onTapStory: _controller.onTapIgStoryShortcut, onTapUser: _controller.onTapUser)),
          ));
    },
  );
  late final _postWidget = FutureBuilder(
    future: _controller.getPostList(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return _loadingWidget;
      if (snapshot.hasError) {
        debugPrint('Error in _postWidget: ${snapshot.error}');
        return _errorWidget;
      }
      if (snapshot.data != true) return _someThingWrongWidget;
      return Obx(() => Column(
            children: [
              ..._controller.postObjectListRx.value.map((e) => PostWidget(object: e, onTapUser: _controller.onTapUser, onTapComment: _controller.onTapComment, onTapLikeDetail: _controller.onTapLikeDetail, onTapLocation: _controller.onTapLocation, onTapMore: _controller.onTapMore, onTapShare: _controller.onTapShare, onLike: _controller.likePost, onSave: _controller.savePost)).toList(),
              ...[_loadingWidget],
            ],
          ));
    },
  );

  //function
  void _onIgStoryShortcutScroll() {
    if (_igStoryShortcutScrollController.position.pixels == _igStoryShortcutScrollController.position.maxScrollExtent) _controller.getIgStoryShortcutList();
  }

  void _onPostScroll() {
    if (_postScrollController.position.pixels == _postScrollController.position.maxScrollExtent) _controller.getPostList();
  }

  @override
  void initState() {
    super.initState();
    _igStoryShortcutScrollController.addListener(_onIgStoryShortcutScroll);
    _postScrollController.addListener(_onPostScroll);
  }

  @override
  void dispose() {
    _igStoryShortcutScrollController.dispose();
    _postScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenTemplateWidget(
          color: ColorStyle.mute,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 44, decoration: BoxDecoration(color: ColorStyle.mute, border: Border(bottom: BorderSide(color: ColorStyle.dark.withOpacity(0.02), width: 1))), child: _topBarWidget),
              Expanded(
                child: CustomScrollView(
                  controller: _postScrollController,
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          Container(alignment: Alignment.center, height: 98, decoration: BoxDecoration(color: ColorStyle.mute, border: Border(bottom: BorderSide(color: ColorStyle.dark.withOpacity(0.2), width: 1))), child: _igStoryBarWidget),
                          Expanded(child: Container(alignment: Alignment.center, color: ColorStyle.light, child: _postWidget)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(margin: const EdgeInsets.only(bottom: 34), height: 45, decoration: BoxDecoration(color: ColorStyle.mute, border: Border(top: BorderSide(color: ColorStyle.dark.withOpacity(0.2), width: 1))), child: _bottomNavBarWidget)
            ],
          ),
        ),
      ),
    );
  }
}
