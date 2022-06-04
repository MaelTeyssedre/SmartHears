import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelpers {
  static final SecureStorageHelpers _secureStorageHelper =
      SecureStorageHelpers._internal();

  factory SecureStorageHelpers() {
    return _secureStorageHelper;
  }

  SecureStorageHelpers._internal();

  final _storage = const FlutterSecureStorage();

  Future<void> reset() async => await _storage.deleteAll();

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'user');
    return;
  }

  Future<void> persistToken(String token) async {
    try {
      await _storage.write(key: 'token', value: token);
      // await _storage.write(key: 'user', value: JwtDecoder.decode(token)['login']);
    } catch (error) {
      print(error);
    }
  }

  Future<bool> hasToken() async {
    String? value = await _storage.read(key: 'token');
    if (value != null) {
      // var token = JwtDecoder.decode(value);
      // var exp = DateTime.fromMillisecondsSinceEpoch(token["exp"] * 1000);
      // if (DateTime.now().isAfter(exp)) {
      // await this.deleteToken();
      // return false;
      // }
      return true;
    }
    return false;
  }

  Future<String?> getToken() async {
    String? value = await _storage.read(key: 'token');
    return value;
  }

  Future<String?> getRevenueCatId() async {
    String? value = await _storage.read(key: 'token');
    // if (value != null) return JwtDecoder.decode(value)['rcId'];
    return null;
  }

  Future<String?> getUser() async {
    String? value = await _storage.read(key: 'user');
    if (value == null) {
      String? token = await _storage.read(key: 'token');
      if (token != null) {
        // value = JwtDecoder.decode(token)['login'];
        if (value != null) await _storage.write(key: 'user', value: value);
      }
    }
    return value;
  }

  Future<bool> isAdmin() async {
    String? token = await _storage.read(key: 'token');
    if (token != null) {
      // String value = JwtDecoder.decode(token)['role'];
      // return value == 'ADMIN';
    }
    return false;
  }

  Future<int> getId() async {
    String? token = await _storage.read(key: 'token');
    // if (token != null) return JwtDecoder.decode(token)['id'];
    return -1;
  }

  Future<bool?> hasAccess(List<int> users) async {
    bool isAdmin = await this.isAdmin();
    if (isAdmin) return true;
    String? token = await _storage.read(key: 'token');
    if (token != null) {
      // int value = JwtDecoder.decode(token)['id'] as int;
      // if (users.isNotEmpty) return users.indexOf(value) >= 0;
    }
    return false;
  }

  Future<String?> getUserEmail() async {
    String? token = await _storage.read(key: 'token');
    // if (token != null) return JwtDecoder.decode(token)['email'];
    return null;
  }
}
