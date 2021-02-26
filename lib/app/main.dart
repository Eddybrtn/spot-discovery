import 'package:flutter/material.dart';
import 'package:spot_discovery/app/app.dart';
import 'package:spot_discovery/app/locator.dart';
import 'package:spot_discovery/core/manager/database_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await DatabaseManager().init();
  runApp(App());
}
