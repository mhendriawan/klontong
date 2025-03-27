import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:klontong_app/app.dart';
import 'package:klontong_app/utils/utils.dart';

void main() async {
  await setupInjection();
  await Firebase.initializeApp();
  runApp(const App());
}
