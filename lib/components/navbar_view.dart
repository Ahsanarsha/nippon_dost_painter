import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/components/nav_button.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/utils/app_images.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavbarController _nc = Get.put(NavbarController());

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.02.sw,
            vertical: 0.01.sw,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              NavButton(home, Colors.black, () {
                _nc.changeIndex(0);
                Get.offNamedUntil(Routes.Home, (route) => false);
              }),
              NavButton(slab, Colors.black, () {
                _nc.changeIndex(1);
                Get.offNamedUntil(Routes.Home, (route) => false);
              }),
              NavButton(profile, Colors.black, () {
                _nc.changeIndex(2);
                Get.offNamedUntil(Routes.Home, (route) => false);
              }),
              NavButton(history, Colors.black, () {
                _nc.changeIndex(3);
                Get.offNamedUntil(Routes.Home, (route) => false);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
