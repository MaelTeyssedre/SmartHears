import 'package:smarthears_mobile/models/auth_status.dart';
import 'package:smarthears_mobile/helpers/http_helpers.dart';
import 'package:smarthears_mobile/constants/api_path.dart';
import 'package:smarthears_mobile/models/user.dart';
import 'package:smarthears_mobile/models/user_details.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:async';

class AuthRepository {
  String apiUrl;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthRepository(this.apiUrl);

  Future<void> logIn() async {}

  Future<void> register() async {}

  Future<String?> getToken() async => (await _storage.read(key: 'token'));

  Future<int> getId() async {
    var token = await _storage.read(key: 'token');
    if (token != null) return JwtDecoder.decode(token)['id'];
    return -1;
  }

  Future<void> persistToken(String token) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'user', value: JwtDecoder.decode(token)['login']);
  }

  Future<bool> hasToken() async => (await _storage.read(key: 'token')) != null;

  Future<void> recoverPassword({required String login}) async {}
  Future<void> socialLoginOrRegister() async {}
}
