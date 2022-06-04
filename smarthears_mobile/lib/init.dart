import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthears_mobile/device_info.dart';
import 'package:smarthears_mobile/repositories/auth_repository.dart';
import 'package:smarthears_mobile/repositories/content_page_repository.dart';
import 'package:smarthears_mobile/repositories/subscription_repository.dart';
import 'package:smarthears_mobile/repositories/user_repository.dart';
import 'package:smarthears_mobile/repositories/notification_repository.dart';
import 'package:smarthears_mobile/services/notifications/notification-manager.dart';

GetIt getIt = GetIt.instance;

class Initialization {
  static void init() {
    initSharedPreferences();
    registerDeviceInfo();
    getIt.registerSingleton<NotificationRepository>(
        NotificationRepository(GlobalConfiguration().get('apiUrl')));
    getIt.registerSingleton<AuthRepository>(
        AuthRepository(GlobalConfiguration().get('apiUrl')));
    getIt.registerSingleton<UserRepository>(
        UserRepository(GlobalConfiguration().get('apiUrl')));
    getIt.registerSingleton<ContentPageRepository>(
        ContentPageRepository(GlobalConfiguration().get('apiUrl')));
    getIt.registerSingleton<SubscriptionRepository>(
        SubscriptionRepository(GlobalConfiguration().get('apiUrl')));
    getIt.registerSingleton<NotificationManager>(NotificationManager(),
        signalsReady: true);
  }

  static void registerDeviceInfo() =>
      getIt.registerSingletonAsync<DeviceInfo>(() async {
        final DeviceInfo deviceInfo = DeviceInfo();
        await deviceInfo.init();
        return deviceInfo;
      });

  static Future<void> initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      await storage.deleteAll();
      prefs.setBool('first_run', false);
    }
  }

  static Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen(
        (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink.link;
      // Future.delayed(Duration(seconds: 1), () => launchDynamicLink(deepLink));
    }, onError: (e) async {
      print('onLinkError');
    });
    await FirebaseDynamicLinks.instance.getInitialLink();
    // if (linkData?.link != null)
    // Future.delayed(Duration(seconds: 1), () => launchDynamicLink(linkData!.link));
  }
}
