import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_mobile/login_screen.dart';
import 'package:smarthears_mobile/modules/home_page.dart';
import 'package:smarthears_mobile/constants.dart';

GetIt getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
      providers: const [],
      child: MultiRepositoryProvider(providers: const [], child: AppView()));
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) => GetMaterialApp(
          title: 'SmartHears',
          theme: ColorSet.theme,
          home: const HomePage(),
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            HomePage.routeName: (context) => LoginScreen()
          });
}
