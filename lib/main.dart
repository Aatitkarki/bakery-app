import 'package:bakery/modules/features/splash/view/splash_page.dart';
import 'package:bakery/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

import 'core/dependency_injection/injection.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await GetStorage.init();

  debugPaintSizeEnabled = false;
  configureInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'La Table Pastry',
        theme: kLightTheme,
        home: SplashPage(),
        customTransition: RouteFadeTransition(),
      ),
    );
  }
}

class RouteFadeTransition extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve curve,
      Alignment alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
