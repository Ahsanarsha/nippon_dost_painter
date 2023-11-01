import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/home/home.dart';
import 'package:nippon_dost/screens/launch/controller/app_launch_controller.dart';
import 'package:nippon_dost/screens/splash/splash.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class AppInit extends StatelessWidget {
  const AppInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: secondary_color,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    AppLaunchController _alc = Get.put(AppLaunchController());
    _alc.initializeApp();

    return Obx(
      () => _alc.initApp.value == true ? Home() : SplashPage(),
    );
  }
}
