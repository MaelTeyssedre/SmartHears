import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthears_mobile/login_screen.dart';
import 'package:smarthears_mobile/modules/onboarding/onboarding_widget.dart';
import 'package:smarthears_mobile/repositories/content_page_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smarthears_mobile/modules/backdrop_item/backdrop_item.dart';
import 'package:smarthears_mobile/device_info.dart';
import 'package:smarthears_mobile/services/notifications/notification-manager.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:smarthears_mobile/repositories/auth_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarthears_mobile/repositories/notification_repository.dart';
import 'package:smarthears_mobile/helpers/secure_storage_helpers.dart';
import 'package:smarthears_mobile/modules/backdrop_item/backdrop_item_listener.dart';
import 'package:smarthears_mobile/modules/splash/view/splash_page.dart';
import 'package:smarthears_mobile/modules/dashboard/view/dashboard_screen.dart';
import 'package:smarthears_mobile/modules/search/search_page.dart';
import 'package:smarthears_mobile/modules/Account/account.dart';
import 'package:smarthears_mobile/modules/home/bloc/home_page_cubit.dart';
import 'package:smarthears_mobile/modules/notifications/notifications.dart';
import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

GetIt getIt = GetIt.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  late String deviceId;
  final GlobalKey _bottomNavigationKey = GlobalKey();
  bool onBoarding = false;
  late Future<bool> loadHome;

  @override
  void initState() {
    initValues();
    loadHome = _loadHome();
    initPermissions();
    super.initState();
  }

  void initValues() async => deviceId = getIt<DeviceInfo>().getDeviceData().id;

  Future<bool> _loadHome() async => await getIt<AuthRepository>().hasToken();

  void initPermissions() async {
    SecureStorageHelpers().hasToken().then((value) async {
      if (value) {
        var locationStatus = await Permission.location.status;
        var locationAlwaysStatus = await Permission.locationAlways.status;
        var locationWhenInUseStatus = await Permission.locationWhenInUse.status;
        var result;
        if (locationStatus.isDenied &&
            locationWhenInUseStatus.isDenied &&
            locationAlwaysStatus.isDenied) {
          result = await _showDialogYesNo(
              "permission.location-title", "permission.location-description");
          if (result) await _determinePosition();
        } else if (locationStatus.isGranted) {
          await _determinePosition();
        }
        var notificationStatus = await Permission.notification.status;
        if (notificationStatus.isDenied) {
          result = await _showDialogYesNo("permission.notifications-title",
              "permission.notifications-description");
          if (result) {
            await getIt<NotificationManager>().init();
            initFirebase();
          }
        } else {
          await getIt<NotificationManager>().init();
          initFirebase();
        }
      } else {
        await getIt<NotificationManager>().init();
        initFirebase();
      }
      var result;
      PermissionStatus locationStatus = await Permission.location.status;
      var locationAlwaysStatus = await Permission.locationAlways.status;
      var locationWhenInUseStatus = await Permission.locationWhenInUse.status;
      if (locationStatus.isDenied &&
          locationWhenInUseStatus.isDenied &&
          locationAlwaysStatus.isDenied) {
        result = await _showDialogYesNo(
            "permission.location-title", "permission.location-description");
        if (result) await _determinePosition();
      } else if (locationStatus.isGranted) {
        await _determinePosition();
      }
    });
  }

  Future<geo.Position> _determinePosition() async {
    bool serviceEnabled;
    geo.LocationPermission permission;
    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error("location.disabled");
    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.deniedForever) {
      return Future.error('location.permission-perma-denied');
    }
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.deniedForever) {
        return Future.error('location.permission-perma-denied');
      }
      if (permission == geo.LocationPermission.denied) {
        return Future.error('location.permission-denied');
      }
    }
    return await geo.Geolocator.getCurrentPosition();
  }

  Future<void> showBottomSheet(String id) async {
    var item = await getIt<ContentPageRepository>().findSoundPack(id);
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => BackdropItem(item: item, isEntity: false),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))));
  }

  void markNotifAsRead(bool show, String exparienceId, String notifId) async {
    Navigator.of(context).pop();
    if (show) showBottomSheet(exparienceId);
    getIt<NotificationRepository>().markNotifAsRead(notifId);
  }

  Future<bool?> _showDialogYesNo(String title, String description) async =>
      await showDialog<bool>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                  title: Text(title),
                  content: Text(description),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text("permission.ko",
                            style: Theme.of(context).textTheme.bodyText2)),
                    TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text("permission.ok",
                            style: Theme.of(context).textTheme.bodyText1))
                  ]));

  Future<void> initFirebase() async {
    await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (await getIt<AuthRepository>().hasToken()) {
        if (message.notification != null &&
            message.notification?.title != null) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                      backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
                      title: Text(message.notification!.title!,
                          style: const TextStyle(color: Colors.white)),
                      content: SingleChildScrollView(
                          child: ListBody(children: <Widget>[
                        Column(children: [
                          Text(message.notification!.body!,
                              style: const TextStyle(color: Colors.white)),
                          Image.network(
                              Platform.isAndroid
                                  ? message.notification!.android!.imageUrl!
                                  : message.notification!.apple!.imageUrl!,
                              height: 250, loadingBuilder:
                                  (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            {
                              return Container(
                                  height: 250,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                      Color>(
                                                  Color.fromRGBO(
                                                      197, 172, 104, 0.3)),
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null)));
                            }
                          })
                        ])
                      ])),
                      actions: <Widget>[
                        TextButton(
                            child: const Text("Voir",
                                style: TextStyle(color: Colors.red)),
                            onPressed: () => markNotifAsRead(
                                true,
                                message.data['exparienceId'],
                                message.data['id'])),
                        TextButton(
                            child: const Text("Fermer",
                                style: TextStyle(
                                    color: Color.fromRGBO(197, 172, 104, 0.8))),
                            onPressed: () => markNotifAsRead(
                                false,
                                message.data['exparienceId'],
                                message.data['id']))
                      ]));
        }
      } else {
        Navigator.pushNamed(context, LoginScreen.routeName);
      }
    });
  }

  Widget getContent(int index, bool hasToken) {
    if (!hasToken && index != 0) return Container();
    switch (index) {
      case 0:
        return DashboardScreen();
      case 1:
        return SearchPage();
      case 2:
        return NotificationsPage();
      case 3:
        return AccountPage();
      default:
        return DashboardScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return onBoarding
        ? const OnboardingPage()
        : BackdropItemListener(FutureBuilder<bool>(
            future: loadHome,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
                snapshot.hasData
                    ? Scaffold(
                        extendBody: true,
                        bottomNavigationBar: CurvedNavigationBar(
                            height: 70,
                            key: _bottomNavigationKey,
                            backgroundColor: const Color(0xFFD3AF5F),
                            color: theme.primaryColor,
                            buttonBackgroundColor: theme.splashColor,
                            index: _page,
                            items: <Widget>[
                              const Icon(Icons.home,
                                  size: 30, color: Color(0xFFD3AF5F)),
                              const Icon(Icons.search,
                                  size: 30, color: Color(0xFFD3AF5F)),
                              BlocBuilder<HomePageCubit, HomePageState>(
                                  bloc: BlocProvider.of<HomePageCubit>(context),
                                  builder: (context, state) {
                                    if (state is HomePageLoaded &&
                                        state.badge > 0) {
                                      return Badge(
                                          badgeColor: Colors.red,
                                          shape: BadgeShape.circle,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          badgeContent:
                                              Text(state.badge.toString()),
                                          child: const Icon(Icons.notifications,
                                              size: 30,
                                              color: Color(0xFFD3AF5F)));
                                    } else {
                                      return const Icon(Icons.notifications,
                                          size: 30, color: Color(0xFFD3AF5F));
                                    }
                                  }),
                              const Icon(Icons.account_circle,
                                  size: 30, color: Color(0xFFD3AF5F))
                            ],
                            animationDuration:
                                const Duration(milliseconds: 300),
                            onTap: (index) {
                              setState(() => _page = index);
                              if (!snapshot.data! && index != 0) {
                                Navigator.pushNamed(
                                        context, LoginScreen.routeName)
                                    .whenComplete(
                                        () => setState(() => _page = 0));
                              }
                            }),
                        body: Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: getContent(_page, snapshot.data!)))
                    : SplashPage()));
  }
}
