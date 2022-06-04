import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smarthears_mobile/models/auth_status.dart';
import 'dart:async';

class AuthRepository {
  String apiUrl;
  final StreamController<AuthStatus> _controller =
      StreamController<AuthStatus>();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthRepository(this.apiUrl);

  Future<void> logIn() async {} // TODO
  Future<void> register() async {} // TODO
  Future<void> recoverPassword({required String login}) async {}
  Future<void> socialLoginOrRegister() async {}
}
