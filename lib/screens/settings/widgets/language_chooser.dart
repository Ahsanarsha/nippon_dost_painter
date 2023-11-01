import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/utils/app_translation.dart';

class DropdownX extends GetxController {
  RxString lang =
      AppTranslation.langs[AppTranslation.locales.indexOf(Get.locale!)].obs;

  void setSelected(String value) {
    AppTranslation().changeLocale(value);
    lang.value = value;
  }
}

class LanguageChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DropdownX _dropdownX = Get.put(DropdownX());

    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        // ElevatedButton(
        //   onPressed: () {
        //     buildLanguageDialog(context);
        //   },
        //   child: Text('change_language'.tr),
        // ),
        Obx(
          () => DropdownButton(
            value: _dropdownX.lang.value,
            items: AppTranslation.langs.map((String lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(lang),
              );
            }).toList(),
            onChanged: (newVal) {
              _dropdownX.setSelected(newVal.toString());
            },
          ),
        ),
      ],
    );
  }
}
