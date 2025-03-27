import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:klontong_app/app.dart';
import 'package:klontong_app/constants/constants.dart';
import 'package:klontong_app/firebase_options.dart';
import 'package:klontong_app/utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RemoteConfig.init();
  UrlConstant urlConstant = await UrlConstant.create();
  sl.registerSingleton<UrlConstant>(urlConstant);
  await setupInjection();
  runApp(const App());
}
