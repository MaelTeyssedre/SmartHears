import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:smarthears_app/modules/dashboard/bloc/dashboard_page_cubit.dart';
import 'package:smarthears_app/modules/dashboard/view/dashboard_section.dart';

typedef GetDataCallback = void Function(BuildContext context);

class DashboardWidget<C extends Cubit<S>, S> extends StatefulWidget {
  const DashboardWidget({required this.getData, this.name}) : super(key: const Key("dashboard"));

  final GetDataCallback getData;
  final String? name;

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState<C, S>();
}

class _DashboardWidgetState<C extends Cubit<S>, S> extends State<DashboardWidget> {
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

  // Future<void> _onRefresh(BuildContext context) async {
  //   await DefaultCacheManager().emptyCache();
  //   widget.getData(context);
  //   _refreshController.refreshCompleted();
  // }

  Center _buildLoading(BuildContext context, {String? name}) => const Center(child: CircularProgressIndicator());

  Widget _buildLoaded(BuildContext context, DashboardPageLoadedState state) => Flex(direction: Axis.horizontal, children: [
        Flexible(
            flex: 2,
            child: SmartRefresher(
                controller: _refreshController,
                // onRefresh: () => _onRefresh,
                enablePullDown: true,
                enablePullUp: false,
                header: const WaterDropMaterialHeader(),
                child: SingleChildScrollView(
                    child: Column(children: [
                  const SizedBox(height: 200),
                  if (state.voicePacks.isNotEmpty) DashboardSection(items: state.voicePacks, title: 'Voice Packs'),
                  const SizedBox(height: 15),
                  if (state.soundPacks.isNotEmpty) DashboardSection(items: state.soundPacks, title: 'Sound Packs'),
                  const SizedBox(height: 15),
                  if (state.voices.isNotEmpty) DashboardSection(items: state.voices, title: 'Voice'),
                  const SizedBox(height: 15),
                  if (state.sounds.isNotEmpty) DashboardSection(items: state.sounds, title: 'Sound')
                ]))))
      ]);

  @override
  Widget build(BuildContext context) => Stack(children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.all(5),
                height: loaded ? 249 : 0,
                width: MediaQuery.of(context).size.width)),
        BlocBuilder<C, S>(
            bloc: BlocProvider.of<C>(context),
            builder: (context, state) {
              if (state is DashboardPageLoadingState) {
                return _buildLoading(context, name: widget.name ?? '');
              } else if (state is DashboardPageLoadedState) {
                return _buildLoaded(context, state);
              }
              return Center(child: _buildLoading(context));
            })
      ]);
}
