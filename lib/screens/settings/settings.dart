import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/resources/cache_manager.dart';
import 'package:nippon_dost/resources/models/logout_model.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/screens/app_widgets/loading_widget.dart';
import 'package:nippon_dost/screens/app_widgets/screen_banner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/history/bloc/order_scan_history_bloc.dart';
import 'package:nippon_dost/screens/login/view/switch_language.dart';
import 'package:nippon_dost/screens/settings/bloc/logout_bloc.dart';
import 'package:nippon_dost/screens/settings/widgets/select_language.dart';
import 'package:nippon_dost/screens/settings/widgets/select_theme.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_translation.dart';
import 'package:nippon_dost/web_view/web_view_widget.dart';

class SettingsController extends GetxController with CacheManager {
  RxList<String> settingsMenu = [
    'themes',
    'languages',
    // 'app_info',
    'about_app',
    'privacy_policy',
    'logout',
  ].obs;

  RxBool loggedOut = false.obs;
  RxBool isLoggingOut = false.obs;


  Future<bool> logout() async {
    await logoutBloc.logoutRequest();
    if(logoutBloc.logoutModel.success){
      LogoutModel lm = logoutBloc.logoutModel;
      print(lm.success.toString());
      loggedOut.value = lm.success;
      return true;
    }else{
      Get.back();
      Get.snackbar(
        'sorry'.tr,
        'something_went_wrong'.tr,
        backgroundColor: main_color,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      loggedOut.value = false;
      return false;
    }

  }
}

class Settings extends GetResponsiveView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    bool languageControllerStatus = Get.isRegistered<SwitchLanguageController>(
        tag: 'SwitchLanguageController');
    SettingsController _sc = Get.put(SettingsController());
    SwitchLanguageController _slc = languageControllerStatus
        ? Get.find(tag: 'SwitchLanguageController')
        : Get.put(SwitchLanguageController(), tag: 'SwitchLanguageController');

    return WillPopScope(
        child: Scaffold(
          appBar: mainAppBar,
          body: ListView(
            shrinkWrap: true,
            // direction: Axis.vertical,
            children: <Widget>[
              ScreenBanner(bannerText: 'settings'.tr),
              Obx(()=>(
                  _sc.isLoggingOut.value? Container(
                    padding: EdgeInsets.only(bottom: 0.5.sw),
                    height: Get.height,
                     // width: Get.width * 60,
                     child: Center(child: CircularProgressIndicator(),)
                  ) : Container(
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
                  child:  Column(
                      children: <Widget>[
                        _listTile(_sc.settingsMenu[0].tr, () {
                          Get.to(() => SelectTheme());
                        }),
                        _divider(),
                        _listTile(_sc.settingsMenu[1].tr, () {
                          Get.to(() => SelectLanguage());
                        }),
                        // _divider(),
                        // _listTile(_sc.settingsMenu[2].tr, () async {
                        //   try {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => WebViewApp(
                        //               _sc.settingsMenu[2].tr,
                        //               "https://catsofttech.com/nippon/app-information"
                        //               // "https://www.google.com"
                        //           ),
                        //         ));
                        //   } catch (e) {
                        //     print("webView error:: $e");
                        //   }
                        // }),
                        _divider(),
                        _listTile(_sc.settingsMenu[2].tr, () async{
                          try {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewApp(
                                      _sc.settingsMenu[2].tr,
                                      // "https://www.google.com"
                                      "https://catsofttech.com/nippon/about"
                                  ),
                                ));
                          } catch (e) {
                            print("webView error:: $e");
                          }
                        }),
                        _divider(),
                        _listTile(_sc.settingsMenu[3].tr, ()async {
                          try {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViewApp(
                                      _sc.settingsMenu[3].tr,
                                      "https://catsofttech.com/nippon/privacy-policy"
                                      // "https://www.google.com"
                                  ),
                                ));
                          } catch (e) {
                            print("webView error:: $e");
                          }
                        }),
                        _divider(),
                        Obx(
                          () => _listTile(
                            _sc.settingsMenu[4].tr,
                            () async {
                              _sc.isLoggingOut.value = true;
                             await _sc.logout();
                              Get.offAllNamed(Routes.Login);
                              // _sc.isLoggingOut.value = false;
                            },
                          ),
                        ),
                      ],
                    )
                  )
                ),)


              // ThemeSwitch(),
              // LanguageChooser(),
            ],
          ),
        ),
        onWillPop: () async {
          appBarPage = '';
          return true;
        });
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
