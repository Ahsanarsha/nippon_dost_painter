import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/components/navbar.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/screens/app_widgets/screen_banner.dart';
import 'package:nippon_dost/screens/redeem_token/view/cp_listing.dart';
import 'package:nippon_dost/screens/redeem_token/view/qr_view.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
class RedeemToken extends StatefulWidget {
  const RedeemToken({Key? key}) : super(key: key);

  @override
  _RedeemTokenState createState() => _RedeemTokenState();
}

class _RedeemTokenState extends State<RedeemToken> {
  NavbarController _nc = Get.put(NavbarController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: mainAppBar,
        body: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            ScreenBanner(bannerText: 'qr_scan'.tr),
            Expanded(
              flex: 1,
              child: QrView(),
            ),
            Expanded(
              flex: 1,
              child: CPListing(),
            ),
          ],
        ),
        bottomNavigationBar: NavBar(),
      ),
    );
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('are_you_sure'.tr),
            content: Text('do_you_want_to_go_back'.tr),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('no'.tr),
              ),
              TextButton(
                onPressed: () => {
                Navigator.of(context).pop(true),
                Get.offAndToNamed(Routes.Home),
                _nc.goBack(false),
                _nc.changeBar(false),
                _nc.changeIndex(0),
                  // Navigator.of(context).pop(true),
                },
                child: Text('yes'.tr),
              ),
            ],
          ),
        ));
        // ??
        // false;
  }
}
