import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/resources/models/login_model.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class OtpVerified extends StatelessWidget {
  const OtpVerified({this.loginModel, Key? key}) : super(key: key);

  final LoginModel? loginModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Image.asset(
            top_bg,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 0.20.sh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(verify_title),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.20.sw, vertical: 0.02.sh),
                      child: Text(
                        'Success!',
                        style: TextStyle(color: main_color),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        'mobile_number_verified'.tr,
                        style: TextStyle(color: Color(0xFF6F6F6F)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 0.04.sh),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFAEAEAE),
                          padding: EdgeInsets.symmetric(vertical: 0.015.sh),
                          fixedSize: Size.fromWidth(0.40.sw),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sm),
                          ),
                        ),
                        child: Text(
                          'verified'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sm,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(nippon_paint_logo),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
