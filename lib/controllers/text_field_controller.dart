import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  TextEditingController tec = TextEditingController();
  RxString ctxt = ''.obs;
  RxString etxt = ''.obs;
  RxBool validate = true.obs;

  @override
  void onInit() {
    tec.addListener(() {
      ctxt.value = tec.text;
    });
    debounce(ctxt, (txt) {
      if (txt.toString().length > 1) {
        setError('');
        change(true);
      }
    },
        time: Duration(
          milliseconds: 10,
        ));

    super.onInit();
  }

  void change(bool val) {
    validate.value = val;
  }

  void setError(String err) {
    etxt.value = err;
  }
}
