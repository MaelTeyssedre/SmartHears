import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:smarthears_mobile/repositories/user_repository.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:smarthears_mobile/models/content_page.dart';
import 'package:smarthears_mobile/modules/dashboard/view/geolocation_list.dart';
import 'package:smarthears_mobile/repositories/auth_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smarthears_mobile/repositories/subscription_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_html/flutter_html.dart';

final GetIt getIt = GetIt.instance;

class BackdropItem extends StatefulWidget {
  const BackdropItem({Key? key, required this.item, this.isEntity = false})
      : super(key: key);

  final dynamic item;
  final bool isEntity;

  @override
  State<BackdropItem> createState() => _BackDropItemState();
}

class _BackDropItemState extends State<BackdropItem> {
  bool isCodeOk = false;
  bool isLive = false;
  bool isSecured = false;
  dynamic item;
  bool expand = false;
  final _storage = const FlutterSecureStorage();
  bool isGeoLocked = true;
  Timer? geolocTimer;
  bool fanArtZoneIsLoaded = false;
  bool isSphereLocked = false;
  Future<bool>? getSubscription;
  Future<bool>? getSphereLock;
  Future<bool>? hasAccess;
  Future<geo.Position?>? determinePosition;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    // if (item is Exparience && !isLive) {
    //   StatisticsService.sendExparienceViewEvent(context, item.id, widget.dynamicLink);
    //   getSubscription = _getSubscription(item.id);
    //   if (item.entity != null) getSphereLock = _isSphereLocked(item.entity.id);
    //   hasAccess = getIt<AuthRepository>().hasAccess(item.users);
    //   determinePosition = _determinePosition();
    //   if (item is Exparience && item.securedByPosition)
    //     geolocTimer = Timer.periodic(Duration(seconds: 5), (timer) {
    //       if (isGeoLocked)
    //         _determinePosition(currentPosition: true);
    //       else
    //         geolocTimer?.cancel();
    //     });
    //   BlocProvider.of<StatisticsBloc>(context).add(StatisticsExparienceIsLikedEvent(item.id));
    // }
  }

  @override
  void dispose() {
    if (geolocTimer != null) geolocTimer?.cancel();
    super.dispose();
  }

  void checkCode(bool value) {
    if (value) {
      _storage.write(
          key: (item is SmartHears) ? item.uniqueKey : item.id,
          value: value.toString());
      setState(() => isCodeOk = value);
    }
  }

  void success(SoundPacks exp) => setState(() {
        isLive = false;
        isSecured = exp.secured ?? false;
        item = exp;
      });

  void toggleExpand() => setState(() => expand = !expand);

  _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.inAppWebView);
    }
  }

  String getCampaignText() {
    switch (item.state) {
      case "NOT_STARTED":
        return "backdrop-item.campaign-text.not-started";
      case "TERMINATED":
      case "ARCHIVED":
        return "backdrop-item.campaign-text.terminated";
      default:
        return "backdrop-item.campaign-text.participate";
    }
  }

  // Future<bool> _getSubscription(String id) async {
  //   var subscription = await getIt<SubscriptionRepository>().getMySubscription(
  //       await getIt<AuthRepository>().getId(), false);
  //   return subscription!.expariences.isNotEmpty &&
  //       subscription.expariences.any((element) => element == id);
  // }

  Future<bool> changeSubscription(bool isLiked) async {
    if (!isLiked) {
      await getIt<SubscriptionRepository>().subscribeToExparience(
          item.id, await getIt<AuthRepository>().getId());
      Future.delayed(
          const Duration(milliseconds: 400),
          () => showDialog(
              context: context,
              builder: (builder) => const AlertDialog(
                  title: Text('notification.exparience-sub-title'),
                  content: Text('notification.exparience-sub-info'))));
    } else {
      getIt<SubscriptionRepository>().unsubscribeToExparience(
          item.id, await getIt<AuthRepository>().getId());
      Future.delayed(
          const Duration(milliseconds: 400),
          () => showDialog(
              context: context,
              builder: (builder) => const AlertDialog(
                  title: Text('notification.exparience-unsub-title'),
                  content: Text('notification.exparience-unsub-info'))));
    }
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        height: expand
            ? (item is SoundPacks && item.securedByPosition ? 680 : 500)
            : 280,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                  onTap: () => toggleExpand(),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 5),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    height: 125,
                                    width: 125,
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: CachedNetworkImage(
                                            height: 100,
                                            imageUrl: item.logoUrl)))),
                            Expanded(
                                flex: 2,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(item.name,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6))),
                                            Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                    icon: const Icon(
                                                        Icons.close_rounded),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                    splashColor:
                                                        Colors.transparent,
                                                    splashRadius: 25))
                                          ]),
                                      const SizedBox(height: 10),
                                      Column(children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "backdrop-item.exparience-text.exparience-section-1",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1))),
                                        !expand
                                            ? Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                    height: 74,
                                                    child: item is SmartHears &&
                                                            !fanArtZoneIsLoaded
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator())
                                                        : SingleChildScrollView(
                                                            child: Html(
                                                                data: item
                                                                        is SoundPacks
                                                                    ? item.descriptionApp !=
                                                                                null &&
                                                                            item.descriptionApp.length >
                                                                                0
                                                                        ? item
                                                                            .descriptionApp
                                                                        : "backdrop-item.exparience-text.exparience-section-2"
                                                                    : getCampaignText()))))
                                            : Container()
                                      ])
                                    ]))
                          ]))),
              expand
                  ? Expanded(
                      child: SingleChildScrollView(
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                      GestureDetector(
                          onTap: () => toggleExpand(),
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Html(
                                      data: item is SoundPacks
                                          ? item.descriptionApp != null &&
                                                  item.descriptionApp.length > 0
                                              ? item.descriptionApp
                                              : "backdrop-item.exparience-text.exparience-section-2"
                                          : getCampaignText())))),
                      expand && item is SoundPacks && item.securedByPosition
                          ? const Divider()
                          : Container(),
                      expand && item is SoundPacks && item.securedByPosition
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, right: 15),
                                      child: Text(
                                          "backdrop-item.exparience-geoloc",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary))),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15.0, right: 15),
                                      child: Text(
                                          "backdrop-item.exparience-geoloc-desc",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary))),
                                  GeolocationList(item: item)
                                ])
                          : Container()
                    ])))
                  : Container(),
              const Divider(),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 15, bottom: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (item is SoundPacks)
                                SizedBox(
                                    height: 40,
                                    child: FutureBuilder<bool>(
                                        future: hasAccess,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<bool> snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            return FloatingActionButton(
                                                child:
                                                    const Icon(Icons.settings),
                                                onPressed: () async {
                                                  var remoteAccess =
                                                      await getIt<
                                                              UserRepository>()
                                                          .askForAccountToken();
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                              title: const Text(
                                                                  "backdrop-item.admin-dialog.title"),
                                                              content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    const Text(
                                                                        "backdrop-item.admin-dialog.content"),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () =>
                                                                                {
                                                                                  showDialog(context: context, builder: (BuildContext context) => const AlertDialog(content: Text("backdrop-item.admin-dialog.copy-validation"))),
                                                                                  Clipboard.setData(ClipboardData(text: "${GlobalConfiguration().get("webapp")}/mySoundPack/mobile/${remoteAccess['iv']}/${remoteAccess['content']}"))
                                                                                },
                                                                        child: Text(
                                                                            "${GlobalConfiguration().get("webapp")}/myExpariences",
                                                                            style:
                                                                                TextStyle(color: Theme.of(context).colorScheme.secondary)))
                                                                  ]),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Cancel'),
                                                                    child: Text(
                                                                        'Annuler',
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .caption)),
                                                                TextButton(
                                                                    onPressed:
                                                                        () => {
                                                                              _launchURL("${GlobalConfiguration().get("webapp")}/myExpariences/mobile/${remoteAccess['iv']}/${remoteAccess['content']}"),
                                                                              Navigator.pop(context, 'Continue')
                                                                            },
                                                                    child: Text(
                                                                        "Continuer",
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .button))
                                                              ]));
                                                });
                                          }
                                          return Container();
                                        })),
                              if (item.entity != null && !widget.isEntity)
                                FutureBuilder<bool>(
                                    future: getSphereLock,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<bool> snapshot) {
                                      if (snapshot.hasData) {
                                        return IconButton(
                                            iconSize: 40,
                                            icon: ClipRRect(
                                                child: Hero(
                                                    tag: 'sphere',
                                                    child: CachedNetworkImage(
                                                        height: 40,
                                                        imageUrl: item
                                                            .entity.logoUrl))),
                                            onPressed: () => {});
                                      }
                                      return Container();
                                    }),
                              if (item is SoundPacks)
                                FutureBuilder<bool>(
                                    future: getSubscription,
                                    builder: (BuildContext context,
                                        AsyncSnapshot<bool> snapshot) {
                                      return SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: FloatingActionButton(
                                              onPressed: () {},
                                              child: LikeButton(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3),
                                                  size: 30,
                                                  isLiked:
                                                      snapshot.data ?? false,
                                                  onTap: changeSubscription,
                                                  circleSize: 50,
                                                  circleColor: CircleColor(
                                                      start: Colors.redAccent,
                                                      end: Theme.of(context)
                                                          .colorScheme
                                                          .secondary),
                                                  bubblesColor: const BubblesColor(
                                                      dotPrimaryColor:
                                                          Colors.redAccent,
                                                      dotSecondaryColor: Colors
                                                          .amberAccent),
                                                  likeBuilder: (bool isLiked) => Icon(
                                                      isLiked
                                                          ? Icons.notifications
                                                          : Icons
                                                              .notifications_off,
                                                      color: Theme.of(context)
                                                          .splashColor,
                                                      size: 30))));
                                    }),
                              if (item is SoundPacks)
                                IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border))
                            ]),
                        Row(children: [
                          if (item is SoundPacks && item.securedByPosition)
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Stack(children: [
                                      FloatingActionButton(
                                        backgroundColor:
                                            Theme.of(context).splashColor,
                                        onPressed: toggleExpand,
                                        child: Image.asset(
                                            "assets/images/geoloc.png",
                                            width: 30,
                                            height: 30),
                                      ),
                                      FutureBuilder<geo.Position?>(
                                          future: determinePosition,
                                          builder: (BuildContext context,
                                              AsyncSnapshot<geo.Position?>
                                                  snapshot) {
                                            Widget child = const Icon(
                                              Icons.lock_rounded,
                                              size: 12
                                            );
                                            if (snapshot.hasData &&
                                                snapshot.data != null) {
                                              return isGeoLocked
                                                  ? const Icon(
                                                      Icons.lock_rounded,
                                                      size: 12)
                                                  : const Icon(
                                                      Icons.lock_open_rounded,
                                                      size: 12);
                                            } else {
                                              child = const Icon(
                                                  Icons.lock_rounded,
                                                  size: 12);
                                            }
                                            return Positioned(
                                                top: 0, right: 0, child: child);
                                          })
                                    ]))),
                          Container(
                              height: 60,
                              width: 60,
                              child: isSphereLocked
                                  ? FloatingActionButton(
                                      onPressed: (() {}),
                                      backgroundColor:
                                          Theme.of(context).splashColor,
                                      child: IconButton(
                                          iconSize: 40,
                                          icon: Icon(Icons.lock,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          onPressed: () => {}))
                                  : isGeoLocked &&
                                          item is SoundPacks &&
                                          item.securedByPosition
                                      ? FloatingActionButton(
                                          onPressed: () {},
                                          backgroundColor:
                                              Theme.of(context).splashColor,
                                          child: Icon(Icons.play_disabled,
                                              size: 50,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary))
                                      : FloatingActionButton(
                                          backgroundColor: item is SoundPacks ||
                                                  item.state == 'ON_GOING' &&
                                                      fanArtZoneIsLoaded
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                              : Theme.of(context).splashColor,
                                          onPressed: () =>
                                              item is SoundPacks ? () {} : null,
                                          child: Icon(
                                              item is SoundPacks ||
                                                      (item.state == 'ON_GOING' &&
                                                          fanArtZoneIsLoaded)
                                                  ? Icons.play_arrow
                                                  : Icons.play_disabled,
                                              size: 50,
                                              color: item is SoundPacks ||
                                                      (item.state ==
                                                              'ON_GOING' &&
                                                          fanArtZoneIsLoaded)
                                                  ? Colors.black
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .secondary)))
                        ])
                      ]))
            ]));
  }
}
