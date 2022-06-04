import 'dart:convert';
import 'dart:io';

import 'package:smarthears_mobile/helpers/secure_storage_helpers.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

class HttpHelpers {
  static final HttpHelpers _httpHelper = HttpHelpers._internal();

  factory HttpHelpers() => _httpHelper;

  HttpHelpers._internal();

  final backendUri = GlobalConfiguration().get('apiUrl');

  Future<dynamic> get({required String path, bool? toDecode}) async {
    var response = await http.get(Uri.parse('$backendUri/$path'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${await SecureStorageHelpers().getToken()}'});
    return getResult(response, toDecode: toDecode);
  }

  Future<String> uploadFile({required String uri, required File file}) async {
    final postUri = Uri.parse('$backendUri/$uri');
    final request = http.MultipartRequest("POST", postUri);
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${await SecureStorageHelpers().getToken()}';
    request.headers[HttpHeaders.contentTypeHeader] = ContentType.binary.mimeType;
    request.files.add(await http.MultipartFile.fromPath('avatar', file.path));
    final end = await request.send();
    return await end.stream.bytesToString();
  }

  Future<dynamic> post({required String path, dynamic body}) async {
    try {
      var response = await http.post(Uri.parse('$backendUri/$path'),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${await SecureStorageHelpers().getToken()}',
            HttpHeaders.contentTypeHeader: ContentType.json.mimeType
          },
          body: body != null ? jsonEncode(body) : null);
      return getResult(response);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> put({required String path, dynamic body}) async {
    var response = await http.put(Uri.parse('$backendUri/$path'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${await SecureStorageHelpers().getToken()}',
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType
        },
        body: body != null ? jsonEncode(body) : null);
    if (response.statusCode < 300) return getResult(response);
  }

  Future<dynamic> delete({required String path}) async {
    var response = await http.delete(Uri.parse('$backendUri/$path'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${await SecureStorageHelpers().getToken()}',
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType
    });
    return getResult(response);
  }

  dynamic getResult(http.Response response, {bool? toDecode}) {
    try {
      if (response.statusCode < 300) {
        if (response.body.isNotEmpty && response.body.contains("{") && (toDecode == null || toDecode))
          return json.decode(response.body);
        return response.body;
      }
      switch (response.statusCode) {
        case 500:
          throw Exception(response.body);
        case 401:
          throw Exception('unauthorized');
        default:
          throw Exception(response.body);
      }
    } catch (error) {
      print(error);
    }
  }
}
