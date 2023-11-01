import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/launch/controller/app_launch_controller.dart';
import 'package:nippon_dost/screens/launch/view/app_init.dart';
import 'package:nippon_dost/screens/launch/view/promotion.dart';
import 'package:nippon_dost/screens/login/login.dart';

import '../qr/qr_scan_history_screen.dart';

class App extends InheritedWidget {
  App({Key? key, required this.child, required this.isLogged})
      : super(key: key, child: child);

  final bool isLogged;
  final Widget child;

  static App? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<App>();
  }

  @override
  bool updateShouldNotify(App oldWidget) {
    return oldWidget.isLogged != isLogged;
  }
}

class AppLaunch extends StatelessWidget {
  const AppLaunch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLaunchController _alc = Get.put(AppLaunchController());
    _alc.checkLoginStatus();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => _alc.isBanner.value == true
            ? Promotion()
            : _alc.isLogged.value == true
                ? AppInit()
                : LoginPage(),

      ),
    );
  }
}
