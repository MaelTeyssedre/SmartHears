import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:smarthears_app/models/theme.dart';
import 'package:smarthears_app/modules/chat_page/chat_page.dart';
import 'package:smarthears_app/modules/dashboard/view/dashboard_screen.dart';
import 'package:smarthears_app/modules/splash/splash.dart';
import 'package:smarthears_app/modules/user/user_page.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  Widget getContent(int index) => index == 0
      ? const DashboardScreen()
      : index == 1
          ? const UserPage(id: 'fake id for testing')
          : index == 2
              ? const SplashPage()
              : index == 3
                  ? const ChatPage(id: 'fake id for testing')
                  : const DashboardScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
            height: 70,
            key: _bottomNavigationKey,
            backgroundColor: theme.colorScheme.background,
            color: theme.primaryColor,
            buttonBackgroundColor: theme.colorScheme.secondary,
            index: _page,
            items: [
              ShaderMask(shaderCallback: shaderCallback, child: const Icon(Icons.home, size: 30)),
              ShaderMask(shaderCallback: shaderCallback, child: const Icon(Icons.account_circle, size: 30)),
              ShaderMask(shaderCallback: shaderCallback, child: const Icon(Icons.search, size: 30)),
              ShaderMask(shaderCallback: shaderCallback, child: const Icon(Icons.chat_bubble, size: 30))
            ],
            animationDuration: const Duration(milliseconds: 300),
            onTap: (index) => setState(() => _page = index)),
        body: Padding(padding: const EdgeInsets.only(bottom: 0), child: getContent(_page)));
  }
}
