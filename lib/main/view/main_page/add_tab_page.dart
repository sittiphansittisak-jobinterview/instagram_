import 'package:flutter/material.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';

class AddTabPage extends StatefulWidget {
  const AddTabPage({super.key});

  @override
  State<AddTabPage> createState() => _AddTabPageState();
}

class _AddTabPageState extends State<AddTabPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      alignment: Alignment.center,
      color: ColorStyle.warning,
      child: const Center(child: Text('''I don't know what is this page o_O?''', style: TextStyle(color: ColorStyle.danger, fontSize: FontSizeStyle.large, fontWeight: FontWeight.bold))),
    );
  }
}
