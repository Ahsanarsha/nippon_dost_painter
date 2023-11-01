import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/gift_slab/view/gift_detail.dart';
import 'package:nippon_dost/screens/history/view/order_scan_single_history.dart';
import 'package:nippon_dost/screens/home/home.dart';
import 'package:nippon_dost/screens/launch/app_launch.dart';
import 'package:nippon_dost/screens/launch/view/app_init.dart';
import 'package:nippon_dost/screens/login/login.dart';
import 'package:nippon_dost/screens/notification/notications.dart';
import 'package:nippon_dost/screens/redeem_token/redeem_token.dart';
import 'package:nippon_dost/screens/splash/view/splash_screen.dart';
import 'package:nippon_dost/screens/support/support_chat.dart';
import 'package:nippon_dost/screens/support/support_history.dart';
import 'package:nippon_dost/screens/verification/otp.dart';
import 'package:nippon_dost/screens/launch/view/promotion.dart';
import 'package:nippon_dost/screens/notification/display_notification.dart';
import 'package:nippon_dost/screens/qr/qr_screen.dart';
import 'package:nippon_dost/screens/settings/settings.dart';

part 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.AppLaunch:
        return GetPageRoute(
          page: () => AppLaunch(),
          transition: Transition.fade,
          transitionDuration: Duration(milliseconds: 500),
        );
      case Routes.AppInit:
        return GetPageRoute(
          page: () => AppInit(),
          transition: Transition.fade,
        );
      case Routes.Promotion:
        return GetPageRoute(
          page: () => Promotion(),
          transition: Transition.fade,
        );
      case Routes.Login:
        return GetPageRoute(
          page: () => LoginPage(),
          transition: Transition.fade,
        );
      case Routes.Otp:
        return GetPageRoute(
          page: () => Otp(),
          transition: Transition.fade,
        );
      case Routes.Home:
        return GetPageRoute(
          page: () => Home(),
          transition: Transition.fade,
        );
      case Routes.RedeemToken:
        return GetPageRoute(
          page: () => RedeemToken(),
          transition: Transition.fade,
        );
      case Routes.GiftDetail:
        return GetPageRoute(
          page: () => GiftDetail(),
          transition: Transition.fade,
        );
      case Routes.Settings:
        return GetPageRoute(
          page: () => Settings(),
          transition: Transition.fade,
        );
      case Routes.Notifications:
        return GetPageRoute(
          page: () => Notifications(),
          transition: Transition.fade,
        );
      case Routes.OrderScanSingleHistory:
        return GetPageRoute(
          page: () => OrderScanSingleHistory(),
          transition: Transition.fade,
        );
      case Routes.SupportChat:
        return GetPageRoute(
          page: () => SupportChat(),
          transition: Transition.fade,
        );
      case Routes.SupportHistory:
        return GetPageRoute(
          page: () => SupportHistory(),
          transition: Transition.fade,
        );
      case Routes.QrScreen:
        return GetPageRoute(
          page: () => QrScreen(),
          transition: Transition.fade,
        );
      case Routes.DISPLAYNOTIFICATION:
        return GetPageRoute(
          page: () => DisplayNotification(),
          transition: Transition.fade,
        );

      default:
        return GetPageRoute(
          page: () => Scaffold(
            body: Center(
              child: Text('No path for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
