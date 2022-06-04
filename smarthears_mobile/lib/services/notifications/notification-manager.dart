import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smarthears_mobile/device_info.dart';
import 'package:smarthears_mobile/repositories/auth_repository.dart';
import 'package:smarthears_mobile/repositories/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

final GetIt getIt = GetIt.instance;

class NotificationManager {
  String? _token;
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  NotificationManager();

  Future<NotificationManager> init() async {
    await Firebase.initializeApp();

    await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    _token = await _firebaseMessaging.getToken();
    var userToken = await getIt<AuthRepository>().getToken();

    var userId = await getIt<AuthRepository>().getId();
    await getIt<UserRepository>().refreshFcmToken(getIt<DeviceInfo>().getDeviceData().id, _token!, userToken ?? "",
        userId, getIt<DeviceInfo>().getDeviceData().phoneModel, getIt<DeviceInfo>().getDeviceData().sdkVersion);

    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      _token = newToken;
      var userToken = await getIt<AuthRepository>().getToken();
      var userId = await getIt<AuthRepository>().getId();
      await getIt<UserRepository>().refreshFcmToken(getIt<DeviceInfo>().getDeviceData().id, _token!, userToken ?? "",
          userId, getIt<DeviceInfo>().getDeviceData().phoneModel, getIt<DeviceInfo>().getDeviceData().sdkVersion);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    return this;
  }
}
