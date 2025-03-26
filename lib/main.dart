import 'package:flutter/material.dart';
import 'package:klontong_app/app.dart';
import 'package:klontong_app/utils/utils.dart';

void main() async {
  await setupInjection();
  runApp(const App());
}
