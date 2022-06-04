import 'package:cached_network_image/cached_network_image.dart';
import 'package:smarthears_mobile/login_screen.dart';
import 'package:smarthears_mobile/models/content_page.dart';
import 'package:smarthears_mobile/modules/backdrop_item/backdrop_item.dart';
import 'package:smarthears_mobile/modules/dashboard/bloc/dashboard_favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_mobile/repositories/auth_repository.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

final GetIt getIt = GetIt.instance;

class DashboardSection extends StatelessWidget {
  const DashboardSection({Key? key, required this.items, required this.title})
      : super(key: key);

  final List<dynamic> items;
  final String title;

  @override
  Widget build(BuildContext context) => Column(children: [
        Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text(title, style: Theme.of(context).textTheme.headline5))),
        Row(children: [
          Expanded(child: DashboardSectionItems(items: [items], title: title))
        ])
      ]);
}

class DashboardFavoriteSection extends StatelessWidget {
  DashboardFavoriteSection(this.title) : super(key: UniqueKey());

  final String title;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DashboardFavoritesCubit, DashboardFavoritesState>(
          bloc: BlocProvider.of<DashboardFavoritesCubit>(context),
          builder: (context, state) {
            if (state.favorites.isNotEmpty) {
              return Column(children: [
                Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(title,
                            style: Theme.of(context).textTheme.headline5))),
                Row(children: [
                  Expanded(
                      child: DashboardSectionItems(
                          items: state.favorites.reversed.toList(),
                          title: title))
                ])
              ]);
            }
            return Container();
          });
}

// class DashboardFavoritesSectionItems extends StatelessWidget {
//   DashboardFavoritesSectionItems(this.items);

//   final List<dynamic> items;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: 125.0,
//         width: 130.0,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: items.length,
//           itemBuilder: (BuildContext context, int index) {
//             return DashboardSectionContent(items[index],
//                 secured: items[index] is Museum
//                     ? false
//                     : items[index] is Entity
//                         ? items[index].isSecured
//                         : items[index] is Exparience
//                             ? items[index].secured
//                             : items[index].vip,
//                 fanPageUrl:
//                     items[index] is FanArtZone ? items[index].landingUrl : null,
//                 isFan: null,
//                 isLive:
//                     items[index] is Exparience && items[index].name == 'LIVE',
//                 isEntity: false);
//           },
//         ));
//   }
// }

class DashboardSectionItems extends StatelessWidget {
  const DashboardSectionItems(
      {Key? key, required this.items, required this.title})
      : super(key: key);

  final List<dynamic> items;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150.0,
        width: 130.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return DashboardSectionContent(items[index],
                  secured: items[index] is Entity
                      ? items[index].isSecured
                      : items[index] is SoundPacks
                          ? items[index].secured
                          : items[index].vip,
                  fanPageUrl: items[index] is SmartHears
                      ? items[index].landingUrl
                      : null,
                  isLive:
                      items[index] is SoundPacks && items[index].name == 'LIVE',
                  title: title);
            }));
  }
}

const FlutterSecureStorage _storage = FlutterSecureStorage();

class DashboardSectionContent extends StatelessWidget {
  DashboardSectionContent(this.item,
      {this.secured = false,
      required this.fanPageUrl,
      this.isFan,
      required this.isLive,
      this.isEntity = false,
      required this.title})
      : super(key: Key("section-${item.id}"));

  final dynamic item;
  final bool secured;
  final String? fanPageUrl;
  final bool? isFan;
  final bool isLive;
  final bool isEntity;
  final String title;

  Future<String?> checkTokenOrItem() async {
    var key = item is SmartHears ? item.uniqueKey : item.id;
    final token = await getIt<AuthRepository>().getToken();
    if (token != null) {
      return await _storage.read(key: key) ?? "";
    } else {
      return "not-connected";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: checkTokenOrItem(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          return GestureDetector(
              onTap: () async {
                if (snapshot.hasData && snapshot.data == "not-connected") {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                } else {
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          BackdropItem(item: item, isEntity: isEntity),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0))));
                }
              },
              child: Stack(children: [
                // if (item is Exparience && item.packageId != null)
                //   BlocProvider<PaymentBloc>(
                //       create: (_) => PaymentBloc.getPaymentBloc(
                //           (item as Exparience).id ?? ''),
                //       child: Container(
                //           height: 150,
                //           width: 100,
                //           decoration: BoxDecoration(
                //               color:
                //                   Theme.of(context).splashColor.withAlpha(200),
                //               borderRadius: BorderRadius.circular(15),
                //               boxShadow: [
                //                 BoxShadow(
                //                     color: Theme.of(context)
                //                         .splashColor
                //                         .withAlpha(200),
                //                     offset: Offset(0.0, 0.0), //(x,y)
                //                     blurRadius: 1.0)
                //               ]),
                //           margin: EdgeInsets.only(
                //               right: 2, left: 2, top: 2, bottom: 2),
                //           child: PaymentWidget(
                //               exparienceId: (item as Exparience).id ?? '',
                //               key: Key(
                //                   "payment-${(item as Exparience).id}-${title.replaceAll(" ", "").toLowerCase()}")))),
                Container(
                    height: 120,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Theme.of(context).splashColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).splashColor.withAlpha(200),
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 1.0)
                        ]),
                    margin: const EdgeInsets.only(
                        right: 2, left: 2, top: 2, bottom: 2),
                    child: Stack(children: [
                      if (item is Entity)
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                padding: const EdgeInsets.all(5.0),
                                height: 30,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          Theme.of(context).splashColor
                                        ]),
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12))))),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 2),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: isLive
                                        ? Image.asset("assets/images/live.png",
                                            height: 95)
                                        : CachedNetworkImage(
                                            height: 95,
                                            imageUrl: item.logoUrl))),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 3, right: 3, bottom: 3),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(item.name,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2)))
                          ]),
                      if (item is Entity)
                        Positioned(
                            top: 2,
                            right: 0,
                            child: Icon(Icons.blur_circular_outlined,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                      if (item is Entity && item.isSecured)
                        Positioned(
                            top: 2,
                            left: 0,
                            child: Icon(
                                snapshot.hasData &&
                                        snapshot.data != null &&
                                        snapshot.data != "not-connected"
                                    ? Icons.lock_open
                                    : Icons.lock_rounded,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                      if (secured &&
                          (item is SoundPacks ||
                              (item is SmartHears && isFan == false)))
                        Positioned(
                            top: 2,
                            right: 0,
                            child: Icon(
                                snapshot.hasData &&
                                        snapshot.data != null &&
                                        snapshot.data != "not-connected"
                                    ? Icons.lock_open
                                    : Icons.lock_rounded,
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                      if (item is SoundPacks && item.securedByPosition)
                        Positioned(
                            bottom: 16,
                            right: 0,
                            child: Image.asset("assets/images/geoloc.png",
                                width: 24.0, height: 24.0)),
                      if (item is SmartHears && item.state != 'ON_GOING')
                        Container(
                            height: 120,
                            width: 100,
                            padding:
                                const EdgeInsets.only(left: 2.0, right: 2.0),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .splashColor
                                    .withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .splashColor
                                          .withAlpha(200),
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 1.0)
                                ]),
                            child: Center(
                                child: Text("dashboard-section.unavailability",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyText2)))
                    ]))
              ]));
        });
  }
}
