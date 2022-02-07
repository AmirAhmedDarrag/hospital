import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hospital/helper/firebase_helper.dart';
import 'app.dart';
import 'db/app_pref.dart';
import 'package:get/get.dart';
import 'theme/app_themes.dart';


/// Global Vars ******************************
var pref = Get.put(AppPreferences());

/// Start Main ********************************
main() {
  initApp();
}


/// init app for both flavors
initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseHelper.init();
  await pref.init(); // init GetStorage.
  initFonts();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  /// run app
  runApp(const App());
}
