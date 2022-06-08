import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitmuz_app/models/fan_page.dart';
import 'package:digitmuz_app/modules/dashboard/view/exparience_code_form.dart';
import 'package:digitmuz_app/modules/dashboard/view/geolocation_list.dart';
import 'package:digitmuz_app/modules/dashboard/view/like_button.dart';
import 'package:digitmuz_app/modules/dashboard/view/share_button.dart';
import 'package:digitmuz_app/modules/fanartzone/fanartzone_page.dart';
import 'package:digitmuz_app/modules/in_app_purchase/bloc/in_app_purchase_bloc.dart';
import 'package:digitmuz_app/modules/in_app_purchase/products_page.dart';
import 'package:digitmuz_app/modules/search/search_exparience_widget.dart';
import 'package:digitmuz_app/modules/sphere/sphere_view.dart';
import 'package:digitmuz_app/modules/unity-blinkl/unity-blinkl.dart';
import 'package:digitmuz_app/repositories/authentication_repository.dart';
import 'package:digitmuz_app/repositories/fan_page_repository.dart';
import 'package:digitmuz_app/repositories/subscription_repository.dart';
import 'package:digitmuz_app/repositories/user_repository.dart';
import 'package:digitmuz_app/services/dynamic_links/dynamic_links_manager.dart';
import 'package:digitmuz_app/statistics/bloc/statistics_bloc.dart';
import 'package:digitmuz_app/statistics/statistics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:get_it/get_it.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:like_button/like_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

final getIt = GetIt.instance;

typedef ArInAr = Function(String id);

class BackdropItem extends StatefulWidget {
  BackdropItem({
    required this.item,
    required this.isLive,
    required this.isSecured,
    this.isFan,
    this.isEntity = false,
    this.dynamicLink,
    this.arInAr,
    this.toPay = false,
  });

  final dynamic item;
  final bool isLive;
  final bool isSecured;
  final bool? isFan; // null = exparience, true = fan, false = vip
  final bool isEntity;
  final dynamicLink;
  final ArInAr? arInAr;
  final bool toPay;

  @override
  _BackDropItemState createState() => _BackDropItemState();
}

class _BackDropItemState extends State<BackdropItem> {
  bool isCodeOk = false;
  bool isLive = false;
  bool isSecured = false;
  dynamic item;
  bool expand = false;
  FanArtZone? fanArtZoneFull;
  final _storage = FlutterSecureStorage();
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
    isLive = widget.isLive;
    isSecured = widget.isSecured;
    if (item is FanArtZone) {
      getFanArtZoneFull();
      if (item.entity != null) getSphereLock = _isSphereLocked(item.entity.id);
    }
    if (item is Exparience && !isLive) {
      StatisticsService.sendExparienceViewEvent(context, item.id, widget.dynamicLink);
      getSubscription = _getSubscription(item.id);
      if (item.entity != null) getSphereLock = _isSphereLocked(item.entity.id);
      hasAccess = getIt<AuthenticationRepository>().hasAccess(item.users);
      determinePosition = _determinePosition();
      if (item is Exparience && item.securedByPosition)
        geolocTimer = Timer.periodic(Duration(seconds: 5), (timer) {
          if (isGeoLocked)
            _determinePosition(currentPosition: true);
          else
            geolocTimer?.cancel();
        });
      BlocProvider.of<StatisticsBloc>(context).add(StatisticsExparienceIsLikedEvent(item.id));
    }
  }

  @override
  void dispose() {
    if (geolocTimer != null) geolocTimer?.cancel();
    super.dispose();
  }

// NOTE: le widget est build malgré que la fonction getFanArtZoneFull() soit appelé dans le
// initState.
  void getFanArtZoneFull() async {
    var value = await getIt<FanPageRepository>().getFanArtZone(
        path: item.uniqueKey,
        lang: "${Locale.fromSubtags(languageCode: Platform.localeName.substring(0, 2))}",
        vip: !widget.isFan!);
    setState(() => {fanArtZoneFull = value, fanArtZoneIsLoaded = true});
  }

  Future<geo.Position?> _determinePosition({bool? currentPosition}) async {
    bool serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;
    var permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.deniedForever) return null;
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.deniedForever) return null;
      if (permission == geo.LocationPermission.denied) return null;
    }

    geo.Position? startPosition = await StatisticsService.getPosition(currentPosition: currentPosition ?? false);
    if (item.positions != null &&
        (item.positions as List<Position>).any((pos) =>
            geo.Geolocator.distanceBetween(
                startPosition!.latitude, startPosition.longitude, pos.coordinates[0], pos.coordinates[1]) <=
            pos.radius.toDouble())) setState(() => isGeoLocked = false);
    return startPosition;
  }

  void checkCode(bool value) {
    if (value) _storage.write(key: (item is FanArtZone) ? item.uniqueKey : item.id, value: value.toString());
    setState(() => isCodeOk = value);
  }

  void success(Exparience exp) => setState(() {
        isLive = false;
        isSecured = exp.secured ?? false;
        item = exp;
      });

  void launchMuseum(String museum) async {
    Navigator.pop(context);
    PermissionStatus camera = await Permission.camera.request();
    if (camera.isGranted)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlinklPage(museum: Museum(museumTechnicalName: museum.substring(1)))));
  }

  void toggleExpand() => setState(() => expand = !expand);

  void playExparience() async {
    StatisticsService.sendExparienceLaunchEvent(context, item.id);
    if (widget.arInAr != null) {
      widget.arInAr!(item.id);
      Navigator.pop(context);
    } else {
      var exparience = await getIt<FanPageRepository>().getExparience(item.id);
      PermissionStatus camera = await Permission.camera.status;
      print("Access to camera is $camera");
      switch (camera) {
        case PermissionStatus.denied:
          print("Request access");
          var newStatus = await Permission.camera.request();
          print("After request access");
          if (newStatus.isGranted) {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlinklPage(liveExparience: exparience, originalItem: widget.item)));
          }
          break;
        case PermissionStatus.permanentlyDenied:
          showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Permissions'),
                    content: SingleChildScrollView(
                        child: ListBody(children: <Widget>[Text(FlutterI18n.translate(context, "permission.camera"))])),
                    actions: <Widget>[
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).backgroundColor)),
                          child: Text(FlutterI18n.translate(context, "permission.cancel"),
                              style: Theme.of(context).textTheme.bodyText2),
                          onPressed: () => Navigator.of(context).pop()),
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary)),
                          child: Text(FlutterI18n.translate(context, "permission.open"),
                              style: Theme.of(context).textTheme.bodyText2),
                          onPressed: () => {Navigator.of(context).pop(), openAppSettings()})
                    ]);
              });
          break;
        default:
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlinklPage(liveExparience: exparience, originalItem: widget.item)));
          break;
      }
    }
  }

  void playCampaign() {
    Navigator.pop(context);
    NestedScrollModal.launchScreen(context, fanArtZoneFull, widget.isFan);
  }

  _launchURL(String url) async {
    if (await canLaunchUrlString(url))
      await launchUrlString(url, mode: LaunchMode.inAppWebView);
    else
      throw 'Could not launch $url';
  }

  String getCampaignText() {
    switch (item.state) {
      case "NOT_STARTED":
        return FlutterI18n.translate(context, "backdrop-item.campaign-text.not-started",
            translationParams: {"isFan": widget.isFan != null && widget.isFan! ? "FANartZONE" : "VIPartZONE"});
      case "TERMINATED":
      case "ARCHIVED":
        return FlutterI18n.translate(context, "backdrop-item.campaign-text.terminated",
            translationParams: {"isFan": widget.isFan != null && widget.isFan! ? "FANartZONE" : "VIPartZONE"});
      default:
        return fanArtZoneFull != null && fanArtZoneFull!.descriptionApp != null
            ? fanArtZoneFull!.descriptionApp!
            : FlutterI18n.translate(context, "backdrop-item.campaign-text.participate",
                translationParams: {"isFan": widget.isFan != null && widget.isFan! ? "FANartZONE" : "VIPartZONE"});
    }
  }

  Future<bool> _getSubscription(String id) async {
    var subscription =
        await getIt<SubscriptionRepository>().getMySubscription(await getIt<AuthenticationRepository>().getId(), false);
    return subscription!.expariences.length > 0 && subscription.expariences.any((element) => element == id);
  }

  Future<bool> changeSubscription(bool isLiked) async {
    if (!isLiked) {
      await getIt<SubscriptionRepository>()
          .subscribeToExparience(item.id, await getIt<AuthenticationRepository>().getId());
      Future.delayed(
          Duration(milliseconds: 400),
          () => showDialog(
              context: context,
              builder: (builder) => AlertDialog(
                  title: Text(FlutterI18n.translate(context, 'notification.exparience-sub-title')),
                  content: Text(FlutterI18n.translate(context, 'notification.exparience-sub-info',
                      translationParams: {'name': item.name})))));
    } else {
      getIt<SubscriptionRepository>().unsubscribeToExparience(item.id, await getIt<AuthenticationRepository>().getId());
      Future.delayed(
          Duration(milliseconds: 400),
          () => showDialog(
              context: context,
              builder: (builder) => AlertDialog(
                  title: Text(FlutterI18n.translate(context, 'notification.exparience-unsub-title',
                      translationParams: {'name': item.name})),
                  content: Text(FlutterI18n.translate(context, 'notification.exparience-unsub-info',
                      translationParams: {'name': item.name})))));
    }
    return !isLiked;
  }

  Future<bool> _isSphereLocked(String id) async {
    if (widget.isEntity) return false;
    var entityIsSecured = false;
    if (widget.item is Exparience) entityIsSecured = widget.item.entity?.isSecured ?? false;
    var isLocked = entityIsSecured && !(await _storage.containsKey(key: id));
    setState(() => isSphereLocked = isLocked);
    return isLocked;
  }

  @override
  Widget build(BuildContext context) {
    return isLive
        ? SearchExparienceWidget(success: success, launchMuseum: launchMuseum)
        : isSecured && !isCodeOk && (widget.isFan == null || (widget.isFan != null && !widget.isFan!))
            ? PasswordForm(
                id: item is Exparience ? item.id : item.uniqueKey,
                callback: checkCode,
                isExparience: (item is Exparience),
                isEntity: (item is Entity))
            : AnimatedContainer(
                duration: Duration(milliseconds: 280),
                height: expand ? (item is Exparience && item.securedByPosition ? 680 : 500) : 280,
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
                                        padding: const EdgeInsets.only(right: 10, top: 5),
                                        child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                            height: 125,
                                            width: 125,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12.0),
                                                child: CachedNetworkImage(height: 100, imageUrl: item.logoUrl)))),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                        child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(item.name,
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: Theme.of(context).textTheme.headline6))),
                                                    Align(
                                                        alignment: Alignment.centerRight,
                                                        child: IconButton(
                                                            icon: Icon(Icons.close_rounded),
                                                            onPressed: () => Navigator.pop(context),
                                                            splashColor: Colors.transparent,
                                                            splashRadius: 25))
                                                  ]),
                                              SizedBox(height: 10),
                                              Column(children: [
                                                Padding(
                                                    padding: const EdgeInsets.only(bottom: 5.0),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(
                                                            item is Exparience
                                                                ? FlutterI18n.translate(context,
                                                                    "backdrop-item.exparience-text.exparience-section-1",
                                                                    translationParams: {"name": item.name})
                                                                : FlutterI18n.translate(context,
                                                                    "backdrop-item.campaign-text.fanartzone-section-1",
                                                                    translationParams: {"name": item.name}),
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: Theme.of(context).textTheme.bodyText1))),
                                                !expand
                                                    ? Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Container(
                                                            height: 74,
                                                            child: item is FanArtZone && !fanArtZoneIsLoaded
                                                                ? Center(child: CircularProgressIndicator())
                                                                : SingleChildScrollView(
                                                                    child: Html(
                                                                        data: item is Exparience
                                                                            ? item.descriptionApp != null &&
                                                                                    item.descriptionApp.length > 0
                                                                                ? item.descriptionApp
                                                                                : FlutterI18n.translate(context,
                                                                                    "backdrop-item.exparience-text.exparience-section-2")
                                                                            : getCampaignText()))))
                                                    : Container()
                                              ])
                                            ]))
                                  ]))),
                      expand
                          ? Expanded(
                              child: SingleChildScrollView(
                                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                              GestureDetector(
                                  onTap: () => toggleExpand(),
                                  child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Html(
                                              data: item is Exparience
                                                  ? item.descriptionApp != null && item.descriptionApp.length > 0
                                                      ? item.descriptionApp
                                                      : FlutterI18n.translate(
                                                          context, "backdrop-item.exparience-text.exparience-section-2")
                                                  : getCampaignText())))),
                              expand && item is Exparience && item.securedByPosition ? Divider() : Container(),
                              expand && item is Exparience && item.securedByPosition
                                  ? Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Padding(
                                          padding: const EdgeInsets.only(top: 15.0, right: 15),
                                          child: Text(FlutterI18n.translate(context, "backdrop-item.exparience-geoloc"),
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).colorScheme.secondary))),
                                      Padding(
                                          padding: const EdgeInsets.only(bottom: 15.0, right: 15),
                                          child: Text(
                                              FlutterI18n.translate(context, "backdrop-item.exparience-geoloc-desc"),
                                              textAlign: TextAlign.end,
                                              style: TextStyle(color: Theme.of(context).colorScheme.secondary))),
                                      GeolocationList(item: item)
                                    ])
                                  // ? GeolocationList(item: item)
                                  : Container()
                            ])))
                          : Container(),
                      Divider(),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15, bottom: 15),
                          child: widget.toPay
                              ? ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    final inApp = InAppPurchaseBloc();
                                    inApp.add(InAppPurchaseLoadOfferingsEvent());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                                create: (_) => inApp,
                                                child: ProductsPage(exparience: item as Exparience))));
                                  },
                                  icon: Icon(Icons.lock),
                                  label: Text(FlutterI18n.translate(context, 'payment.access')),
                                  style: ElevatedButton.styleFrom(primary: Colors.red))
                              : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                    if (item is Exparience)
                                      SizedBox(
                                          height: 40,
                                          child: FutureBuilder<bool>(
                                              future: hasAccess,
                                              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                                if (snapshot.hasData && snapshot.data != null) {
                                                  return FloatingActionButton(
                                                      child: Icon(Icons.settings),
                                                      onPressed: () async {
                                                        var remoteAccess =
                                                            await getIt<UserRepository>().askForAccountToken();
                                                        showDialog(
                                                            context: context,
                                                            builder: (BuildContext context) => AlertDialog(
                                                                    title: Text(FlutterI18n.translate(
                                                                        context, "backdrop-item.admin-dialog.title")),
                                                                    content: Column(
                                                                        mainAxisSize: MainAxisSize.min,
                                                                        children: [
                                                                          Text(FlutterI18n.translate(context,
                                                                              "backdrop-item.admin-dialog.content")),
                                                                          TextButton(
                                                                              onPressed: () => {
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        builder: (BuildContext
                                                                                                context) =>
                                                                                            AlertDialog(
                                                                                                content: Text(FlutterI18n
                                                                                                    .translate(context,
                                                                                                        "backdrop-item.admin-dialog.copy-validation")))),
                                                                                    Clipboard.setData(ClipboardData(
                                                                                        text:
                                                                                            "${GlobalConfiguration().get("webapp")}/myExpariences/mobile/${remoteAccess['iv']}/${remoteAccess['content']}"))
                                                                                  },
                                                                              child: Text(
                                                                                  "${GlobalConfiguration().get("webapp")}/myExpariences",
                                                                                  style: TextStyle(
                                                                                      color: Theme.of(context)
                                                                                          .colorScheme
                                                                                          .secondary)))
                                                                        ]),
                                                                    actions: <Widget>[
                                                                      TextButton(
                                                                          onPressed: () =>
                                                                              Navigator.pop(context, 'Cancel'),
                                                                          child: Text('Annuler',
                                                                              style:
                                                                                  Theme.of(context).textTheme.caption)),
                                                                      TextButton(
                                                                          onPressed: () => {
                                                                                _launchURL(
                                                                                    "${GlobalConfiguration().get("webapp")}/myExpariences/mobile/${remoteAccess['iv']}/${remoteAccess['content']}"),
                                                                                Navigator.pop(context, 'Continue')
                                                                              },
                                                                          child: Text("Continuer",
                                                                              style:
                                                                                  Theme.of(context).textTheme.button))
                                                                    ]));
                                                      });
                                                }
                                                return Container();
                                              })),
                                    if (item.entity != null && !widget.isEntity)
                                      FutureBuilder<bool>(
                                          future: getSphereLock,
                                          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                            if (snapshot.hasData)
                                              return IconButton(
                                                  iconSize: 40,
                                                  icon: ClipRRect(
                                                      child: Hero(
                                                          tag: 'sphere',
                                                          child: CachedNetworkImage(
                                                              height: 40, imageUrl: item.entity.logoUrl))),
                                                  onPressed: () => {
                                                        Navigator.pop(context),
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    SphereView(sphereId: item.entity.id)))
                                                      });
                                            return Container();
                                          }),
                                    if (item is Exparience)
                                      FutureBuilder<bool>(
                                          future: getSubscription,
                                          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                            return SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: FloatingActionButton(
                                                    onPressed: () {},
                                                    child: LikeButton(
                                                        padding: EdgeInsets.only(left: 3),
                                                        size: 30,
                                                        isLiked: snapshot.data ?? false,
                                                        onTap: changeSubscription,
                                                        circleSize: 50,
                                                        circleColor: CircleColor(
                                                            start: Colors.redAccent,
                                                            end: Theme.of(context).colorScheme.secondary),
                                                        bubblesColor: BubblesColor(
                                                            dotPrimaryColor: Colors.redAccent,
                                                            dotSecondaryColor: Colors.amberAccent),
                                                        likeBuilder: (bool isLiked) => Icon(
                                                            isLiked ? Icons.notifications : Icons.notifications_off,
                                                            color: Theme.of(context).splashColor,
                                                            size: 30))));
                                          }),
                                    ShareButton(
                                        imageUrl: '',
                                        zoneType: item is Exparience
                                            ? ZoneType.exparience
                                            : widget.isFan != null && widget.isFan!
                                                ? ZoneType.artzone
                                                : ZoneType.vipartzone,
                                        name: item is Exparience ? item.id : item.uniqueKey,
                                        txt: item.name),
                                    if (item is Exparience) WidgetLikeButton(item: item)
                                  ]),
                                  Row(children: [
                                    if (item is Exparience && item.securedByPosition)
                                      Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Stack(children: [
                                                FloatingActionButton(
                                                    backgroundColor: Theme.of(context).splashColor,
                                                    child:
                                                        Image.asset("assets/images/geoloc.png", width: 30, height: 30),
                                                    onPressed: toggleExpand),
                                                FutureBuilder<geo.Position?>(
                                                    future: determinePosition,
                                                    builder:
                                                        (BuildContext context, AsyncSnapshot<geo.Position?> snapshot) {
                                                      Widget child = Icon(
                                                        Icons.lock_rounded,
                                                        size: 12,
                                                      );
                                                      if (snapshot.hasData && snapshot.data != null)
                                                        return isGeoLocked
                                                            ? Icon(Icons.lock_rounded, size: 12)
                                                            : Icon(Icons.lock_open_rounded, size: 12);
                                                      else
                                                        child = Icon(Icons.lock_rounded, size: 12);
                                                      return Positioned(top: 0, right: 0, child: child);
                                                    })
                                              ]))),
                                    Container(
                                        height: 60,
                                        width: 60,
                                        child: isSphereLocked
                                            ? FloatingActionButton(
                                                onPressed: (() {}),
                                                backgroundColor: Theme.of(context).splashColor,
                                                child: IconButton(
                                                    iconSize: 40,
                                                    icon: Icon(Icons.lock,
                                                        color: Theme.of(context).colorScheme.secondary),
                                                    onPressed: () => {
                                                          Navigator.pop(context),
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      SphereView(sphereId: item.entity.id)))
                                                        }))
                                            : isGeoLocked && item is Exparience && item.securedByPosition
                                                ? FloatingActionButton(
                                                    onPressed: () {},
                                                    backgroundColor: Theme.of(context).splashColor,
                                                    child: Icon(Icons.play_disabled,
                                                        size: 50, color: Theme.of(context).colorScheme.secondary))
                                                : FloatingActionButton(
                                                    backgroundColor: item is Exparience ||
                                                            item.state == 'ON_GOING' && fanArtZoneIsLoaded
                                                        ? Theme.of(context).colorScheme.secondary
                                                        : Theme.of(context).splashColor,
                                                    onPressed: () => item is Exparience
                                                        ? playExparience()
                                                        : item.state == 'ON_GOING' && fanArtZoneIsLoaded
                                                            ? playCampaign()
                                                            : null,
                                                    child: Icon(
                                                        item is Exparience ||
                                                                (item.state == 'ON_GOING' && fanArtZoneIsLoaded)
                                                            ? Icons.play_arrow
                                                            : Icons.play_disabled,
                                                        size: 50,
                                                        color: item is Exparience ||
                                                                (item.state == 'ON_GOING' && fanArtZoneIsLoaded)
                                                            ? Colors.black
                                                            : Theme.of(context).colorScheme.secondary)))
                                  ])
                                ]))
                    ]));
  }
}
