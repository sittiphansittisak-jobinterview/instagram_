import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:instagram/main/controller/main_controller/search_tab_controller.dart';
import 'package:instagram/widget/icon_button_widget.dart';
import 'package:instagram/widget/image_network_widget.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';
import 'package:instagram/widget_style/space_style.dart';

class SearchTabPage extends StatefulWidget {
  const SearchTabPage({super.key});

  @override
  State<SearchTabPage> createState() => _SearchTabPageState();
}

class _SearchTabPageState extends State<SearchTabPage> with AutomaticKeepAliveClientMixin {
  //controller
  final _controller = SearchTabController();
  final _bodyScrollController = ScrollController();

  //widget helper
  final _searchHintColor = ColorStyle.searchHint.withOpacity(0.6);
  final _tabsBarTextList = ['IGTV', 'Shop', 'Style', 'Sport', 'Auto', 'Music'];
  final _tabsBarIconList = [Icons.tv, Icons.shopping_bag_rounded, null, null, null, null];
  late final _tabsBarFunctionList = [_controller.onTapIgtv, _controller.onTapShop, _controller.onTapStyle, _controller.onTapSport, _controller.onTapAuto, _controller.onTapMusic];

  //widget
  final _loadingWidget = const CircularProgressIndicator();
  final _errorWidget = const Text('เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
  final _someThingWrongWidget = const Text('มีบางอย่างไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง');
  late final _searchWidget = Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(left: 8),
    height: 36,
    decoration: BoxDecoration(color: ColorStyle.searchField.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 11),
        Icon(Icons.search, size: 14, color: _searchHintColor),
        const SizedBox(width: 9),
        Expanded(
          child: TextFormField(
            style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.large),
            decoration: InputDecoration(isDense: true, contentPadding: EdgeInsets.zero, border: InputBorder.none, constraints: const BoxConstraints(maxHeight: 36), hintText: 'Search', hintStyle: TextStyle(color: _searchHintColor, fontSize: FontSizeStyle.large)),
            onChanged: (value) {},
          ),
        ),
      ],
    ),
  );
  late final _liveWidget = Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: IconButtonWidget(icon: const Icon(FontAwesomeIcons.squarePlus, size: 20, color: ColorStyle.dark), onPressed: _controller.onTapLive));
  late final _menuBar = SizedBox(
    height: 32,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: _tabsBarTextList.length + 2,
      itemBuilder: (context, index) {
        if (index == 0 || index == _tabsBarTextList.length + 1) return const SizedBox(width: 5.5);
        index -= 1;
        final text = _tabsBarTextList[index];
        final icon = _tabsBarIconList[index];
        final function = _tabsBarFunctionList[index];
        return InkWell(
          onTap: function,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.5),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: ColorStyle.light, borderRadius: BorderRadius.circular(6), border: Border.all(color: ColorStyle.searchHint.withOpacity(0.18), width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon, size: 15, color: ColorStyle.dark),
                const SizedBox(width: 7),
                Text(text, style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.basic, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        );
      },
    ),
  );
  late final _imageListWidget = FutureBuilder(
    future: _controller.getImageList(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) return SliverList(delegate: SliverChildBuilderDelegate(childCount: 1, (BuildContext context, int index) => const SizedBox()));
      if (snapshot.hasError) {
        debugPrint('Error in _imageListWidget: ${snapshot.error}');
        return SliverList(delegate: SliverChildBuilderDelegate(childCount: 1, (BuildContext context, int index) => Center(child: _errorWidget)));
      }
      if (snapshot.data != true) return SliverList(delegate: SliverChildBuilderDelegate(childCount: 1, (BuildContext context, int index) => Center(child: _someThingWrongWidget)));
      _onBodyScrollNotAvailable();
      return Obx(
        () => SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 124, mainAxisSpacing: 1.0, crossAxisSpacing: 1.0, childAspectRatio: 1.0),
          delegate: SliverChildBuilderDelegate(
            childCount: _controller.imageListRx.value.length,
            (BuildContext context, int index) {
              return InkWell(onTap: () => _controller.onTapImage(index), child: ImageNetworkWidget(imageUrl: _controller.imageListRx.value[index], isCached: true));
            },
          ),
        ),
      );
    },
  );

  //function
  void _onBodyScrollController() {
    if (_bodyScrollController.position.pixels == _bodyScrollController.position.maxScrollExtent) _controller.getImageList();
  }

  //Using for image not enough to fill screen
  Future _onBodyScrollNotAvailable() async {
    await Future.delayed(Duration.zero);
    if (_bodyScrollController.position.maxScrollExtent != 0) return;
    await _controller.getImageList();
    _onBodyScrollNotAvailable();
  }

  @override
  void initState() {
    super.initState();
    _bodyScrollController.addListener(_onBodyScrollController);
  }

  @override
  void dispose() {
    _bodyScrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: 4),
        Container(
          height: 88,
          decoration: const BoxDecoration(color: ColorStyle.light),
          child: Column(
            children: [
              Row(children: [Expanded(child: _searchWidget), _liveWidget]),
              const SizedBox(height: 4),
              _menuBar,
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            controller: _bodyScrollController,
            slivers: [
              _imageListWidget,
              SliverList(delegate: SliverChildBuilderDelegate(childCount: 1, (BuildContext context, int index) => Container(alignment: Alignment.center, margin: SpaceStyle.allBasic, child: _loadingWidget))),
            ],
          ),
        ),
      ],
    );
  }
}
