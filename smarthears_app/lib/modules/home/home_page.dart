import 'package:flutter/material.dart';
import 'package:smarthears_app/modules/home/bloc/home_page_cubit.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BackdropItemListener(FutureBuilder<bool>(
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) => snapshot.hasData
            ? Scaffold(
                extendBody: true,
                bottomNavigationBar: CurvedNavigationBar(
                    height: 70,
                    key: _bottomNavigationKey,
                    backgroundColor: const Color(0xFFD3AF5F),
                    color: theme.primaryColor,
                    buttonBackgroundColor: theme.splashColor,
                    index: _page,
                    items: <Widget>[
                      const Icon(Icons.home, size: 30, color: const Color(0xFFD3AF5F)),
                      const Icon(Icons.search, size: 30, color: const Color(0xFFD3AF5F)),
                      BlocBuilder<HomePageCubit, HomePageState>(
                          bloc: BlocProvider.of<HomePageCubit>(context),
                          builder: (context, state) {
                            return const Icon(Icons.notifications, size: 30, color: const Color(0xFFD3AF5F));
                          }),
                      const Icon(Icons.account_circle, size: 30, color: const Color(0xFFD3AF5F))
                    ],
                    animationDuration: const Duration(milliseconds: 300),
                    onTap: (index) {
                      setState(() => _page = index);
                      if (!snapshot.data! && index != 0) {
                        Navigator.pushNamed(context, LoginScreen.routeName)
                            .whenComplete(() => setState(() => _page = 0));
                      }
                    }),
                body: Padding(padding: const EdgeInsets.only(bottom: 0), child: getContent(_page, snapshot.data!)))
            : Scaffold(appBar: AppBar(), backgroundColor: Colors.purple, body: Container())));
  }
}
