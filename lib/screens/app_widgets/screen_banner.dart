import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class ScreenBanner extends StatelessWidget {
  const ScreenBanner({required this.bannerText, Key? key}) : super(key: key);

  final String bannerText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.0.sw,
      height: 0.10.sh,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            top_banner_gradient_begin, //Begin
            top_banner_gradient_end, //End
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 0.04.sh,
          left: 0.05.sw,
        ),
        width: 0.50.sw,
        height: 0.10.sh,
        child: Text(
          bannerText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
