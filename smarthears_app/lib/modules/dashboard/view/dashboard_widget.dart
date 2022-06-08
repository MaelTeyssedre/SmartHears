import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_app/modules/dashboard/bloc/dashboard_page_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Widget buildLoading(BuildContext context, {String? name, String? logoUrl}) => (name != null && logoUrl != null)
    ? Stack(children: [
        Container(
            width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, color: Colors.black),
        Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Hero(tag: 'sphere', child: CachedNetworkImage(height: 300, imageUrl: logoUrl))]))
      ])
    : const Center(child: CircularProgressIndicator());

typedef GetDataCallback = void Function(BuildContext context);

class DashboardWidget<C extends Cubit<S>, S> extends StatefulWidget {
  const DashboardWidget({this.getData, this.name}) : super(key: const Key("dashboard"));

  final GetDataCallback? getData;
  final String? name;

  @override
  _DashboardWidget<C, S> createState() => _DashboardWidget<C, S>();
}

class _DashboardWidget<C extends Cubit<S>, S> extends State<DashboardWidget> {
  final _refreshController = RefreshController(initialRefresh: false);

  bool loaded = false;

  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () => setState(() => loaded = true));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    super.dispose();
  }

  void _onRefresh(BuildContext context) async {
    await DefaultCacheManager().emptyCache();
    widget.getData!(context);
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) => Stack(children: [
        Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                padding: const EdgeInsets.all(5.0),
                height: loaded ? 249 : 0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: const [0.3, 1],
                        colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).backgroundColor])))),
        BlocBuilder<C, S>(
            bloc: BlocProvider.of<C>(context),
            builder: (context, state) {
              if (state is DashboardPageLoadingState) {
                return buildLoading(context, name: widget.name ?? '');
              } else if (state is DashboardPageLoadedState) {
                // List<Item?> expariences = [];
                // var currentExpariences = [];
                // var favorites = state.fanPage.favorites;
                // BlocProvider.of<DashboardFavoritesCubit>(context).initFavorites(favorites);
                // List<FanArtZone> artzones = (state).fanPage.fanartzones;
                // List<FanArtZone> fanartzones = artzones.where((e) => e.fan).toList();
                // List<FanArtZone> vipartzones = artzones.where((e) => e.vip).toList();
                return OrientationBuilder(
                    builder: (context, orientation) => Row(children: [
                          // MediaQuery.of(context).orientation == Orientation.landscape
                          //     ? Flexible(flex: 1, child: CarouselWithIndicator(data: state.fanPage.headers))
                          //     : Container(),
                          Container(),

                          Flexible(
                              flex: 2,
                              child: SmartRefresher(
                                  controller: _refreshController,
                                  onRefresh: () => _onRefresh(context),
                                  enablePullDown: true,
                                  enablePullUp: false,
                                  header: const WaterDropMaterialHeader(),
                                  child: SingleChildScrollView(
                                      child: Column(children: [
                                    // MediaQuery.of(context).orientation == Orientation.portrait
                                    //     ? CarouselWithIndicator(data: state.fanPage.headers)
                                    //     : Container(),
                                    Container(),

                                    const SizedBox(height: 15),
                                    // DashboardSection(state.categories, 'Categories', isEntity: false),
                                    // DashboardSection(expariences, "dashboard-section.expariences",
                                    //     isEntity: state is SpherePageLoaded),
                                    // DashboardSection(currentExpariences,
                                    //     FlutterI18n.translate(context, "dashboard-section.currentExpariences"),
                                    //     isFan: null, isEntity: state is SpherePageLoaded),
                                    // DashboardFavoriteSection(
                                    //     FlutterI18n.translate(context, "dashboard-section.favorites")),
                                    // fanartzones.isNotEmpty
                                    //     ? DashboardSection(fanartzones, "dashboard-section.fanartzones",
                                    //         isFan: true, isEntity: state is SpherePageLoaded)
                                    //     : Container(),
                                    // vipartzones.isNotEmpty
                                    //     ? DashboardSection(vipartzones, "dashboard-section.vipartzones",
                                    //         isFan: false, isEntity: state is SpherePageLoaded)
                                    //     : Container(),
                                    const SizedBox(height: 69)
                                  ]))))
                        ]));
              } else {
                return Center(child: buildLoading(context));
              }
            })
      ]);
}
