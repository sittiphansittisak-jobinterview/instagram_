import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram/path/image_path.dart';
import 'package:instagram/path/page_path.dart';
import 'package:instagram/main/view/_share/screen_template_widget.dart';
import 'package:instagram/widget/image_network_widget.dart';
import 'package:instagram/widget_style/color_style.dart';
import 'package:instagram/widget_style/font_size_style.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  bool _isShowSignInForm = false;

  Widget _elevatedButtonWithNoneHover({required Widget child, required void Function() onPressed}) => ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(minimumSize: Size.zero, padding: EdgeInsets.zero, backgroundColor: ColorStyle.none, shadowColor: ColorStyle.none, splashFactory: NoSplash.splashFactory),
        child: child,
      );
  Widget _textFieldWidgetBuilder({required String hintText, required void Function(String) onChanged}) => TextFormField(
        style: const TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.basic),
        decoration: InputDecoration(hintText: hintText, hintStyle: TextStyle(color: ColorStyle.dark.withOpacity(0.2), fontSize: FontSizeStyle.basic), constraints: const BoxConstraints(maxHeight: 44), filled: true, fillColor: ColorStyle.mute, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: BorderSide(color: ColorStyle.dark.withOpacity(0.1)))),
        onChanged: (value) {},
      );

  late final _backButtonWidget = _elevatedButtonWithNoneHover(
    child: const Icon(Icons.arrow_back_ios, color: ColorStyle.dark, size: 18),
    onPressed: () => setState(() => _isShowSignInForm = false),
  );
  final _logoWidget = Image.asset(ImagePath.logoTextTransparent, height: 49);
  final _userImageWidget = ClipOval(child: SizedBox.fromSize(size: const Size.fromRadius(42.5), child: const ImageNetworkWidget(imageUrl: ImagePath.userImageUrl)));
  final _userNameWidget = const Text('jacob_w', style: TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.basic, fontWeight: FontWeight.bold));
  late final _switchAccountsButtonWidget = _elevatedButtonWithNoneHover(
    onPressed: () => setState(() => _isShowSignInForm = true),
    child: const Text('Switch accounts', style: TextStyle(color: ColorStyle.link, fontSize: FontSizeStyle.basic, fontWeight: FontWeight.bold)),
  );
  late final _signUpTextWidget = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Don’t have an account?', style: TextStyle(color: ColorStyle.dark.withOpacity(0.4), fontSize: FontSizeStyle.small)),
      const SizedBox(width: 11),
      _elevatedButtonWithNoneHover(
        onPressed: () {},
        child: const Text('Sign up.', style: TextStyle(color: ColorStyle.dark, fontSize: FontSizeStyle.small, fontWeight: FontWeight.bold)),
      ),
    ],
  );
  late final _usernameFieldWidget = _textFieldWidgetBuilder(
    hintText: 'Username',
    onChanged: (value) {},
  );
  late final _passwordFieldWidget = _textFieldWidgetBuilder(
    hintText: 'Password',
    onChanged: (value) {},
  );
  late final _forgotPasswordButtonWidget = _elevatedButtonWithNoneHover(
    onPressed: () {},
    child: const Text('Forgot password?', style: TextStyle(color: ColorStyle.link, fontSize: FontSizeStyle.small)),
  );
  late final _logInButtonWidget = ElevatedButton(
    style: ElevatedButton.styleFrom(backgroundColor: ColorStyle.link, minimumSize: const Size(double.infinity, 44), fixedSize: const Size(double.infinity, 44), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, PagePath.main, (route) => false),
    child: const Text('Log in', style: TextStyle(color: ColorStyle.light, fontSize: FontSizeStyle.basic, fontWeight: FontWeight.bold)),
  );
  late final _logInWithFacebookButtonWidget = _elevatedButtonWithNoneHover(
    onPressed: () {},
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(FontAwesomeIcons.squareFacebook, color: ColorStyle.link, size: 17),
        SizedBox(width: 10),
        Text('Log in with Facebook', style: TextStyle(color: ColorStyle.link, fontSize: FontSizeStyle.basic, fontWeight: FontWeight.bold)),
      ],
    ),
  );
  final _orWidget = Row(
    children: [
      Expanded(child: Divider(height: 0, color: ColorStyle.dark.withOpacity(0.2))),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 32), child: Text('OR', style: TextStyle(color: ColorStyle.dark.withOpacity(0.4), fontSize: FontSizeStyle.small, fontWeight: FontWeight.bold))),
      Expanded(child: Divider(height: 0, color: ColorStyle.dark.withOpacity(0.2))),
    ],
  );
  late final _signUpTextForSignInFormWidget = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Don’t have an account? ', style: TextStyle(color: ColorStyle.dark.withOpacity(0.4), fontSize: FontSizeStyle.basic)),
      _elevatedButtonWithNoneHover(
        onPressed: () {},
        child: const Text('Sign up.', style: TextStyle(color: ColorStyle.link, fontSize: FontSizeStyle.basic)),
      ),
    ],
  );
  final _instagramFromFacebookWidget = Text('Instagram от Facebook', style: TextStyle(color: ColorStyle.dark.withOpacity(0.4), fontSize: FontSizeStyle.small));

  @override
  Widget build(BuildContext context) {
    if (!_isShowSignInForm) {
      return Scaffold(
        body: SafeArea(
          child: ScreenTemplateWidget(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _logoWidget,
                              const SizedBox(height: 52),
                              _userImageWidget,
                              const SizedBox(height: 15),
                              _userNameWidget,
                              const SizedBox(height: 11),
                              _logInButtonWidget,
                              const SizedBox(height: 30),
                              _switchAccountsButtonWidget,
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Divider(height: 0, color: ColorStyle.dark.withOpacity(0.4)),
                          const SizedBox(height: 18),
                          _signUpTextWidget,
                          const SizedBox(height: 50),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ScreenTemplateWidget(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(margin: const EdgeInsets.only(left: 16), height: 44, child: _backButtonWidget),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _logoWidget,
                                  const SizedBox(height: 52),
                                  _usernameFieldWidget,
                                  const SizedBox(height: 12),
                                  _passwordFieldWidget,
                                  const SizedBox(height: 19),
                                  Align(alignment: Alignment.centerRight, child: _forgotPasswordButtonWidget),
                                  const SizedBox(height: 28),
                                  _logInButtonWidget,
                                  const SizedBox(height: 37),
                                  _logInWithFacebookButtonWidget,
                                  const SizedBox(height: 40),
                                  _orWidget,
                                  const SizedBox(height: 40),
                                  _signUpTextForSignInFormWidget,
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Divider(height: 0, color: ColorStyle.dark.withOpacity(0.4)),
                              const SizedBox(height: 32),
                              _instagramFromFacebookWidget,
                              const SizedBox(height: 31),
                            ],
                          )
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
    );
  }
}
