import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/modules/dashboard/bloc/dashboard_page_cubit.dart';
import 'dashboard_widget.dart';

Widget buildLoading() {
  return const Center(child: CircularProgressIndicator());
}

class DashboardScreen extends StatelessWidget {
  static const String routeName = "/dashboard";

  static Route route() => MaterialPageRoute<void>(builder: (_) => DashboardScreen());

  void getDashboard(BuildContext context) => BlocProvider.of<DashboardPageCubit>(context);

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => BlocProvider.of<DashboardPageCubit>(context),
      child: const DashboardWidget<DashboardPageCubit, DashboardPageState>());
}
