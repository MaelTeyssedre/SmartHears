import 'package:smarthears_mobile/modules/dashboard/bloc/dashboard_page_cubit.dart';
import 'package:smarthears_mobile/modules/dashboard/view/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

class DashboardScreen extends StatelessWidget {
  static final routeName = "/dashboard";

  static Route route() => MaterialPageRoute<void>(builder: (_) => DashboardScreen());

  void getDashboard(BuildContext context) => BlocProvider.of<DashboardPageCubit>(context).getDashboardContentPage();

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => BlocProvider.of<DashboardPageCubit>(context),
      child: DashboardWidget<DashboardPageCubit, DashboardPageState>(getData: getDashboard, sphereId: ''));
}
