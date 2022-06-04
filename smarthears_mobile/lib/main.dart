import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smarthears_mobile/app.dart';
import 'package:get_it/get_it.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:smarthears_mobile/init.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset('dev');
  await Firebase.initializeApp();
  Initialization.init();
  runApp(const MyApp());
}
