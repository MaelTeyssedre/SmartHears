import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_app/models/theme.dart';
import 'package:smarthears_app/modules/home/home_page.dart';
import 'package:smarthears_app/modules/dashboard/bloc/dashboard_page_cubit.dart';
import 'package:smarthears_app/modules/home/bloc/home_page_cubit.dart';
import 'package:smarthears_app/modules/dashboard/view/dashboard_screen.dart';
import 'package:get/get.dart';
import 'package:smarthears_app/repositories/authentication_repository.dart';

GetIt getIt = GetIt.instance;

class SmartHears extends StatelessWidget {
  const SmartHears({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => HomePageCubit()),
            BlocProvider(create: (_) => DashboardPageCubit())
          ],
          child: MultiRepositoryProvider(providers: [
            RepositoryProvider.value(value: getIt<AuthenticationRepository>())
          ], child: const SmartHearsView()));
}

class SmartHearsView extends StatefulWidget {
  const SmartHearsView({Key? key}) : super(key: key);

  @override
  State<SmartHearsView> createState() => _SmartHearsViewState();
}

class _SmartHearsViewState extends State<SmartHearsView> {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
          title: 'SmartHears',
          theme: theme,
          home: const HomePage(),
          routes: {
            DashboardScreen.routeName: (context) => const DashboardScreen(),
            HomePage.route: (context) => const HomePage()
          });
}
