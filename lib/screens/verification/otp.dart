import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/verification/view/otp_verfication.dart';
import 'package:nippon_dost/screens/verification/view/otp_verified.dart';

import 'controller/otp_controller.dart';

class Otp extends StatelessWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OtpController _oc = Get.put(OtpController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Obx(
            () => Visibility(
              visible: _oc.isVerification.value,
              child: OtpVerification(),
            ),
          ),
          Obx(
            () => Visibility(
              visible: _oc.isVerified.value,
              child: OtpVerified(),
            ),
          ),
        ],
      ),
    );
  }
}
