import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:smarthears_app/modules/dashboard/view/dashboard_screen.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _page = 0;
  int _currentPage = 0;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  Widget getContent(int index) {
    final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    final Animation<Offset> _animationSlideLeft = Tween<Offset>(
      begin: const Offset(-1, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller..forward(),
      curve: Curves.ease,
    ));

    final Animation<Offset> _animationSlideRigth = Tween<Offset>(
      begin: const Offset(1, 0.0),
      end: const Offset(0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller..forward(),
      curve: Curves.ease,
    ));

    switch (index) {
      case 0:
        return SlideTransition(
            position: _currentPage > _page
                ? _animationSlideRigth
                : _animationSlideLeft,
            child: Container(color: Colors.blue));
      case 1:
        return SlideTransition(
            position: _currentPage > _page
                ? _animationSlideRigth
                : _animationSlideLeft,
            child: Container(color: Colors.yellow));
      case 2:
        return SlideTransition(
            position: _currentPage > _page
                ? _animationSlideRigth
                : _animationSlideLeft,
            child: Container(color: Colors.green));
      case 3:
        return SlideTransition(
            position: _currentPage > _page
                ? _animationSlideRigth
                : _animationSlideLeft,
            child: Container(color: Colors.purple));
      default:
        return SlideTransition(
            position: _currentPage > _page
                ? _animationSlideRigth
                : _animationSlideLeft,
            child: Container(color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
              Icon(Icons.account_circle, size: 30, color: Color(0xFFD3AF5F)),
              Icon(Icons.search, size: 30, color: Color(0xFFD3AF5F)),
              Icon(Icons.settings, size: 30, color: Color(0xFFD3AF5F))
            ],
            animationDuration: const Duration(milliseconds: 300),
            onTap: (index) => setState(() {
                  _currentPage = _page;
                  _page = index;
                })),
        body: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: getContent(_page)));
  }
}
