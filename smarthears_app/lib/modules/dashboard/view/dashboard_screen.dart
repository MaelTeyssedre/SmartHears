import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/modules/dashboard/bloc/dashboard_page_cubit.dart';
import 'dashboard_widget.dart';

Widget buildLoading() => const Center(child: CircularProgressIndicator());

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = "/dashboard";

  static Route route() => MaterialPageRoute<void>(builder: (_) => const DashboardScreen());

  void getDashboard(BuildContext context) => BlocProvider.of<DashboardPageCubit>(context).getDashboard();

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => BlocProvider.of<DashboardPageCubit>(context),
      child: DashboardWidget<DashboardPageCubit, DashboardPageState>(getData: getDashboard));
}
