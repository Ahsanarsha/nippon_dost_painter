import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/themes/dark_theme.dart';
import 'package:nippon_dost/themes/light_theme.dart';

class SwitchX extends GetxController {
  RxBool on = false.obs;

  void toggle() => on.value = on.value ? false : true;
}

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SwitchX _switchX = Get.put(SwitchX());

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Obx(
          () => Text(
              "${'theme_text'.tr}:  ${_switchX.on.value == false ? 'theme_light'.tr : 'theme_dark'.tr}"),
        ),
        Obx(
          () => Switch(
            value: _switchX.on.value,
            onChanged: (value) {
              _switchX.toggle();
              Get.changeTheme(Get.isDarkMode ? lightTheme : darkTheme);
            },
          ),
        ),
      ],
    );
  }
}
