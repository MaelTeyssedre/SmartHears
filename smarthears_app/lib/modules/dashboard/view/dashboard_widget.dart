import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:smarthears_app/modules/dashboard/bloc/dashboard_page_cubit.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Widget buildLoading(BuildContext context, {String? name, String? logoUrl}) => const Center(child: CircularProgressIndicator());

typedef GetDataCallback = void Function(BuildContext context);

class DashboardWidget<C extends Cubit<S>, S> extends StatefulWidget {
  const DashboardWidget({this.getData, this.name}) : super(key: const Key("dashboard"));

  final GetDataCallback? getData;
  final String? name;

  @override
  _DashboardWidget<C, S> createState() => _DashboardWidget<C, S>();
}

class _DashboardWidget<C extends Cubit<S>, S> extends State<DashboardWidget> {
  bool loaded = false;
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () => setState(() => loaded = true));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.all(5.0),
                height: loaded ? 249 : 0,
                width: MediaQuery.of(context).size.width)),
        BlocBuilder<C, S>(
            bloc: BlocProvider.of<C>(context),
            builder: (context, state) {
              if (state is DashboardPageLoadingState) {
                return buildLoading(context, name: widget.name ?? '');
              } else if (state is DashboardPageLoadedState) {
                return Flexible(flex: 2, child: SmartRefresher(controller: _refreshController));
              }
              return Center(child: buildLoading(context));
            })
      ]);
}
