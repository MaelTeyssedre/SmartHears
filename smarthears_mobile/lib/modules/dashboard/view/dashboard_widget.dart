import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:smarthears_mobile/models/content_page.dart';
import 'package:smarthears_mobile/modules/dashboard/bloc/dashboard_favorites_cubit.dart';
import 'package:smarthears_mobile/modules/dashboard/bloc/dashboard_page_cubit.dart';
import 'package:smarthears_mobile/modules/dashboard/view/carousel_indicator.dart';
import 'package:smarthears_mobile/modules/dashboard/view/dashboard_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final getIt = GetIt.instance;

Widget buildLoading(BuildContext context, {String? name, String? logoUrl}) =>
    (name != null && logoUrl != null)
        ? Stack(children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black),
            Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Hero(
                      tag: 'sphere',
                      child: CachedNetworkImage(height: 300, imageUrl: logoUrl))
                ]))
          ])
        : const Center(child: CircularProgressIndicator());

typedef GetDataCallback = void Function(BuildContext context);

class DashboardWidget<C extends Cubit<S>, S> extends StatefulWidget {
  const DashboardWidget({this.getData, this.sphereId, this.name})
      : super(key: const Key("dashboard"));

  final GetDataCallback? getData;
  final String? sphereId;
  final String? name;

  @override
  createState() => _DashboardWidget<C, S>();
}

class _DashboardWidget<C extends Cubit<S>, S> extends State<DashboardWidget> {
  final _refreshController = RefreshController(initialRefresh: false);

  bool loaded = false;
  final _storage = const FlutterSecureStorage();
  @override
  initState() {
    super.initState();
    Future.delayed(
        const Duration(milliseconds: 500), () => setState(() => loaded = true));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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

  void checkCode(EntityFull item, bool value) =>
      (value) ? _storage.write(key: item.id, value: value.toString()) : value;

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
                        stops: const [
                      0.3,
                      1
                    ],
                        colors: [
                      widget.sphereId?.isNotEmpty ?? false
                          ? const Color.fromRGBO(95, 131, 211, 1)
                          : Theme.of(context).colorScheme.secondary,
                      Theme.of(context).backgroundColor
                    ])))),
        BlocBuilder<C, S>(
            bloc: BlocProvider.of<C>(context),
            builder: (context, state) {
              if (state is DashboardPageLoading) {
                return buildLoading(context, name: widget.name ?? '');
              } else if (state is DashboardPageLoaded) {
                List<Item?> soundPacks = state.contentPage.soundPacks;
                var currentSoundPacks = state.contentPage.currentSoundPacks;
                var favorites = state.contentPage.favorites;
                BlocProvider.of<DashboardFavoritesCubit>(context)
                    .initFavorites(favorites);

                // var myExpariences =
                //     state is DashboardPageLoaded ? state.contentPage. : [];
                List<SmartHears> smartHearsList =
                    state.contentPage.smarthearsList;

                return OrientationBuilder(
                    builder: (context, orientation) => Row(children: [
                          MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? Flexible(
                                  flex: 1,
                                  child: CarouselWithIndicator(
                                      data: state.contentPage.headers))
                              : Container(),
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
                                    MediaQuery.of(context).orientation ==
                                            Orientation.portrait
                                        ? CarouselWithIndicator(
                                            data: state.contentPage.headers)
                                        : Container(),
                                    const SizedBox(height: 15),
                                    if (soundPacks.isNotEmpty)
                                      DashboardSection(
                                          items: soundPacks,
                                          title:
                                              "dashboard-section.expariences"),
                                    if (currentSoundPacks.isNotEmpty)
                                      DashboardSection(
                                          items: currentSoundPacks,
                                          title:
                                              "dashboard-section.currentExpariences"),
                                    DashboardFavoriteSection(
                                        "dashboard-section.favorites"),
                                    smartHearsList.isNotEmpty
                                        ? DashboardSection(
                                            items: smartHearsList,
                                            title:
                                                "dashboard-section.fanartzones")
                                        : Container(),
                                    const SizedBox(height: 69)
                                  ]))))
                        ]));
              } else {
                return Center(child: buildLoading(context));
              }
            })
      ]);
}
