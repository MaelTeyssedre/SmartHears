import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/modules/backdrop_item/backdrop_item_listener.dart';
import 'package:smarthears_app/modules/home/bloc/home_page_cubit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:smarthears_app/modules/dashboard/view/dashboard_screen.dart';
import 'package:smarthears_app/modules/splash/splash.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  Widget getContent(int index) {
    switch (index) {
      case 0:
        return DashboardScreen();
      // case 1:
      //   return SearchPage(goToHome);
      // case 2:
      //   return SettingsPage();
      // case 3:
      //   return AccountPage();
      default:
        return DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BackdropItemListener(
        child: Scaffold(
            extendBody: true,
            bottomNavigationBar: CurvedNavigationBar(
                height: 70,
                key: _bottomNavigationKey,
                backgroundColor: const Color(0xFFD3AF5F),
                color: theme.primaryColor,
                buttonBackgroundColor: theme.splashColor,
                index: _page,
                items: const <Icon>[
                  Icon(Icons.home, size: 30, color: Color(0xFFD3AF5F)),
                  Icon(Icons.search, size: 30, color: Color(0xFFD3AF5F)),
                  Icon(Icons.notifications, size: 30, color: Color(0xFFD3AF5F)),
                  Icon(Icons.account_circle, size: 30, color: Color(0xFFD3AF5F))
                ],
                animationDuration: const Duration(milliseconds: 300),
                onTap: (index) => setState(() => _page = index)),
            body: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: getContent(_page))));
  }
}
