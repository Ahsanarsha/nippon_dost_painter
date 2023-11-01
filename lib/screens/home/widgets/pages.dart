import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/screens/dashboard/dashboard.dart';
import 'package:nippon_dost/screens/gift_slab/gift_slab.dart';
import 'package:nippon_dost/screens/history/history.dart';
import 'package:nippon_dost/screens/profile/profile.dart';

class Pages extends StatelessWidget {
  const Pages({ Key? key }) : super(key: key);

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static List<Widget> _widgetsOption = <Widget>[
    Dashboard(),
    GiftSlab(),
    Profile(),
    History(),
  ];

  @override
  Widget build(BuildContext context) {
    NavbarController _hc = Get.put(NavbarController());

    return Center(
          child: Obx(() =>  _widgetsOption.elementAt(_hc.index.value)),
        );
  }
}