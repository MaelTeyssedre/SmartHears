import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:smarthears_app/app.dart';
import 'package:smarthears_app/repositories/authentication_repository.dart';

GetIt getIt = GetIt.instance;

void main() async {
  getIt.registerSingleton<AuthenticationRepository>(AuthenticationRepository('URL'), signalsReady: true);
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
