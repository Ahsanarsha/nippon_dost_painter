import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/screens/app_widgets/screen_banner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/login/view/switch_language.dart';
import 'package:nippon_dost/utils/app_translation.dart';



class SelectTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar,
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          ScreenBanner(bannerText: 'select_theme'.tr),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 0.04.sw,
              vertical: 0.02.sh,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF3F6FD),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF000000).withOpacity(0.16),
                  blurRadius: 6,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                _listTile('system_default'.tr, () {
                  Get.changeThemeMode(ThemeMode.system);
                  Get.back();
                }),
                _divider(),
                _listTile('light'.tr, () {
                  Fluttertoast.showToast(
                      msg: "Coming Soon",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1
                  );
                  // Get.changeTheme(ThemeData.light());
                  // Get.back();
                }),
                _divider(),
                _listTile('dark'.tr, () {
                  Fluttertoast.showToast(
                      msg: "Coming Soon",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1
                  );
                  // Get.changeTheme(ThemeData.dark());
                  // Get.back();
                }),
              ],
            ),
          ),


          // ThemeSwitch(),
          // LanguageChooser(),
        ],
      ),
    );
  }

  Widget _listTile(String txt, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.01.sh),
        child: ListTile(
          title: Text(
            txt,
            style: TextStyle(
              color: Color(0xFF00295A),
              fontSize: 14.sm,
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
      child: Divider(
        thickness: 1,
        height: 2,
        color: Color(0xFFCFDBFF),
      ),
    );
  }
}
