import 'package:flutter/material.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/components/navbar.dart';
import 'package:nippon_dost/components/on_will_pop.dart';
import 'package:nippon_dost/screens/home/widgets/pages.dart';
import 'package:flutter/services.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: secondary_color,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return WillPopScope(
      onWillPop: OnWillPop(
        context: context,
        title: 'are_you_sure'.tr,
        message: 'do_you_want_exit'.tr,
        yesText: 'yes'.tr,
        noText: 'no'.tr,
        noTap: () => Navigator.of(context).pop(false),
        yesTap: () => Navigator.of(context).pop(true),
      ).onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: mainAppBar,
        body: Pages(),
        bottomNavigationBar: NavBar(),
      ),
    );
  }
}
