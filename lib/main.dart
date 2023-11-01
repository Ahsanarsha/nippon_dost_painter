import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nippon_dost/models/my_notification_model.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/screens/launch/controller/app_launch_controller.dart';
import 'package:nippon_dost/screens/notification/notification_service.dart';
import 'package:nippon_dost/services/notification_sp_services.dart';
import 'package:nippon_dost/themes/light_theme.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_translation.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print("ON BACKGROUND MESSAGE LISTENER <<<<<<<<<<<<<<<<");

  // await NotificationService().showNotification(message.notification!.title!,
  //     message.notification!.body!);
  NotificationSpServices().saveANotificationsToSp(MyNotificationModel(
    body: message.notification!.body!,
    title: message.notification!.title!,
    time: DateTime.now(),
  ));
}

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService notificationService = NotificationService();

  await notificationService.initNotification();

  notificationService.setFcmToken();
  FirebaseMessaging.onMessage.listen((RemoteMessage message)=> notificationService.backgroundMessageHandler(message));
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: secondary_color,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await GetStorage.init();
  runApp(MyApp());
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    // App received notification when it was killed
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      builder: (context,widget) => GetMaterialApp(
        translations: AppTranslation(),
        locale: AppTranslation.locale,
        fallbackLocale: AppTranslation.fallbackLocale,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        title: 'app_name'.tr,
        initialRoute: Routes.AppLaunch,
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: false,
          breakpoints: [
            ResponsiveBreakpoint.autoScale(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
      ),
    );
  }
}


// PHONE 923214667692