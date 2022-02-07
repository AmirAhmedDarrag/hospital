import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navigation/app_pages.dart';
import 'theme/app_themes.dart';

int kNumOfNav = 0;

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Hospital',
        theme: AppThemes.light,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        //initialBinding: InitialBindings(),
        routingCallback: (Routing? route) => route == null ||
                route.isBlank! ||
                route.isBottomSheet! ||
                route.isDialog!
            ? kNumOfNav
            : route.isBack!
                ? kNumOfNav--
                : kNumOfNav++);
  }
}
