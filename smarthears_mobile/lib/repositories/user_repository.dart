import 'dart:async';

import 'package:devicelocale/devicelocale.dart';
import 'package:smarthears_mobile/helpers/http_helpers.dart';
import 'package:smarthears_mobile/models/user.dart';
import 'package:smarthears_mobile/models/user_details.dart';

class UserRepository {
  User? _user;
  late String apiUrl;

  UserRepository(String url) {
    apiUrl = url;
  }

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return _user = User.fromJson(await HttpHelpers().get(path: 'tmp'));
  }

  Future<UserDetails> getUserDetails() async => UserDetails.fromJson(await HttpHelpers().get(path: 'tmp'));

  Future<void> refreshFcmToken(
          String deviceId, String token, String authToken, int userId, String phoneModel, String sdkVersion) async =>
      await HttpHelpers().put(path: 'tmp', body: {
        'deviceId': deviceId,
        'firebaseToken': token,
        'application': 'fanartzone',
        'phoneModel': phoneModel,
        'sdkVersion': sdkVersion,
        'language': (await Devicelocale.currentAsLocale)?.countryCode
      });

  Future<dynamic> askForAccountToken() async => await HttpHelpers().get(path: 'tmp');
}
