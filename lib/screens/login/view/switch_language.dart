import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/resources/cache_manager.dart';
import 'package:nippon_dost/screens/launch/controller/app_launch_controller.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_translation.dart';

class SwitchLanguageController extends GetxController with CacheManager {
  RxBool on = false.obs;
  RxString lang =
      AppTranslation.langs[AppTranslation.locales.indexOf(Get.locale!)].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateValue();
  }





  updateValue(){
    if(lang=='اردو')
      on.value = true;
    else
      on.value = false;
  }








  void changeLanguage(String value) {
    on.value = on.value ? false : true;
    AppTranslation().changeLocale(value);
    lang.value = value;
    saveLanguage(value);
  }
}

class SwitchLanguage extends StatelessWidget {
  const SwitchLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  SwitchLanguageController _slc  = Get.put(SwitchLanguageController(), tag: 'SwitchLanguageController');

    return Obx(
      () => Container(
        width: 0.50.sw,
        height: 0.06.sh,
        margin: EdgeInsets.only(top: 0.04.sh),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 0.04.sw),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(
            color: Color(0xFF707070),
            width: 0.2,
          ),
          boxShadow: [
            BoxShadow(
              color: shadow_color.withOpacity(0.16),
              blurRadius: 6,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Eng'),
            Switch(
              value: _slc.on.value,
              onChanged: (value) {
                if (_slc.on.value == true) {
                  _slc.changeLanguage(AppTranslation.langs[0]);
                } else {
                  _slc.changeLanguage(AppTranslation.langs[1]);
                }
              },
            ),
            Text('اردو'),
          ],
        ),
      ),
    );
  }
}
