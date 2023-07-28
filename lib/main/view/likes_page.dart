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

class LikesPage extends StatefulWidget {
  const LikesPage({super.key});

  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  //widget
  final _bottomNavBarWidget = const BottomNavBarWidget(isLikes: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenTemplateWidget(
          color: ColorStyle.mute,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(height: 44, decoration: BoxDecoration(color: ColorStyle.mute, border: Border(bottom: BorderSide(color: ColorStyle.dark.withOpacity(0.02), width: 1)))),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [],
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
