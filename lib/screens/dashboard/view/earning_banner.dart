import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class EarningBanner extends StatelessWidget {
  const EarningBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 0.01.sh,
        left: 0.05.sw,
        right: 0.05.sw,
      ),
      child: Container(
        width: 1.0.sw,
        height: 0.07.sh,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: main_color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(image: AssetImage(earn_bg)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0.42, 7.99), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: Text(
            'you_earned'.tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
