import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/controllers/text_field_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    TextFieldController _tfc = Get.put(TextFieldController());

    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 0.03.sh),
        padding: EdgeInsets.symmetric(horizontal: 0.15.sw),
        height: 0.10.sh,
        child: TextField(
          style: TextStyle(fontSize: 18.sm),
          controller: _tfc.tec,
          autofocus: true,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          // textAlign: TextAlign.center,
          // maxLength: 11,
          //being set to 12 to accomodate standard phone input
          maxLength: 12,
          onChanged: (val){
            if(val.length ==12){
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          decoration: InputDecoration(
            hintText: 'enter_phone_number'.tr,
            errorText: _tfc.etxt.value,
            counterText: '',
            errorStyle: TextStyle(
              color: Colors.red,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
