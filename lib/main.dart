import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:instagram/main/view/authorization_page.dart';
import 'package:instagram/main/view/initial_page.dart';
import 'package:instagram/main/view/likes_page.dart';
import 'package:instagram/main/view/main_page.dart';
import 'package:instagram/main/view/profile_page.dart';
import 'package:instagram/main/view/search_page.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/path/page_path.dart';
import 'package:instagram/setting/scroll_setting.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_family_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Rx<bool> _isInitialSuccess = Rx(false);

  GetPage<dynamic> _pageBuilder(String page) => GetPage(
      name: page,
      page: () => Obx(() {
            if (!_isInitialSuccess.value) return const InitialPage();
            switch (page) {
              case PagePath.authorization:
                return const AuthorizationPage();
              case PagePath.main:
                return const MainPage();
              case PagePath.search:
                return const SearchPage();
              case PagePath.likes:
                return const LikesPage();
              case PagePath.profile:
                return const ProfilePage();
              default:
                return const AuthorizationPage();
            }
          }));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      ImagePath.prepareImageAsset(context);
      _isInitialSuccess.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollSetting(),
      title: 'Instagram',
      theme: ThemeData(
        fontFamily: FontFamilyStyle.sarabun,
        scaffoldBackgroundColor: ColorStyle.light,
        snackBarTheme: SnackBarThemeData(backgroundColor: ColorStyle.primary, contentTextStyle: TextStyle(fontFamily: FontFamilyStyle.sarabun, color: ColorStyle.light, fontSize: FontSizeStyle.basic)),
        appBarTheme: AppBarTheme(backgroundColor: ColorStyle.primary, iconTheme: const IconThemeData(color: ColorStyle.secondary, size: FontSizeStyle.big), titleTextStyle: TextStyle(color: ColorStyle.light, fontSize: FontSizeStyle.big, fontFamily: FontFamilyStyle.sarabun)),
      ),
      supportedLocales: const [Locale('en', 'US'), Locale('th', 'TH')],
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
      defaultTransition: Transition.noTransition,
      initialRoute: PagePath.index,
      unknownRoute: _pageBuilder(PagePath.index),
      getPages: [
        _pageBuilder(PagePath.index),
        _pageBuilder(PagePath.authorization),
        _pageBuilder(PagePath.main),
        _pageBuilder(PagePath.search),
        _pageBuilder(PagePath.likes),
        _pageBuilder(PagePath.profile),
      ],
    );
  }
}
