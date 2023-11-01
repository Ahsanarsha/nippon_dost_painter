import 'package:flutter/material.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/screens/app_widgets/screen_banner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/login/view/switch_language.dart';
import 'package:nippon_dost/utils/app_translation.dart';



class SelectLanguage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool languageControllerStatus = Get.isRegistered<SwitchLanguageController>(tag: 'SwitchLanguageController');
    SwitchLanguageController _slc = languageControllerStatus? Get.find(tag: 'SwitchLanguageController'): Get.put(SwitchLanguageController(), tag: 'SwitchLanguageController');


    return Scaffold(
      appBar: mainAppBar,
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          ScreenBanner(bannerText: 'select_language'.tr),
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
                  _listTile('English', () {
                    _slc.changeLanguage(AppTranslation.langs[0]);
                    Get.back();
                  }),
                  _divider(),
                  _listTile('اردو', () {
                    _slc.changeLanguage(AppTranslation.langs[1]);
                    Get.back();
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
