import 'package:flutter/material.dart';
import 'package:instagram/path/image_path.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: Image.asset(ImagePath.logoTextTransparent, width: MediaQuery.of(context).size.width * 0.5))));
  }
}
