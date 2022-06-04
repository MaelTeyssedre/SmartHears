import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthears_mobile/device_info.dart';

GetIt getIt = GetIt.instance;

class Initialization {
  static void init() {
    initSharedPreferences();
    registerDeviceInfo();
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
}
