import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled3/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:untitled3/screens/acceuil-screen.dart';
import 'package:untitled3/screens/home_screen.dart';
import 'package:untitled3/screens/login_kid.dart';
import 'package:untitled3/screens/login_screen.dart';
import 'package:untitled3/screens/menukids.dart';
import 'package:untitled3/screens/signup_screen.dart';
import 'package:untitled3/utils/colors.dart';

import 'firebase_options.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:untitled3/alert_dialog_service/overlay_widget.dart';
import 'package:untitled3/database/database_service.dart';
import 'package:untitled3/main_app_ui/home.dart';
import 'package:untitled3/main_app_ui/permissions_screen.dart';
import 'package:untitled3/monitoring_service/utils/flutter_background_service_utils.dart';
import 'package:usage_stats/usage_stats.dart';

import 'main_app_ui/splachScreen.dart';

void main() async {
  // Start the monitoring service
  await onStart();
  DatabaseService dbService = await DatabaseService.instance();
  bool permissionsAvailable = (await UsageStats.checkUsagePermission())! &&
      await FlutterOverlayWindow.isPermissionGranted();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp(
      permissionsAvailable ? Home(dbService) : PermissionsScreen(dbService),
      dbService));
}


onStart() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await startMonitoringService();
}

// This is the isolate entry for the Alert Window Service
// It needs to be added in the main.dart file with the name "overlayMain"...(jugaadu code max by plugin dev)
@pragma("vm:entry-point")
void overlayMain() async {
  debugPrint("Starting Alerting Window Isolate!");
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: OverlayWidget()));
}

class MyApp extends StatelessWidget {
  Widget screenToDisplay;

  DatabaseService dbService;

  MyApp(this.screenToDisplay, this.dbService);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Controle',
      theme: ThemeData(
        primarySwatch: materialPrimary,
        splashColor: materialPrimary,
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: screenToDisplay,

  
    );
  }
}
