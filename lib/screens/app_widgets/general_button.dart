import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton({
    this.color,
    required this.btnText,
    required this.onTap,
    this.btnStyle,
    Key? key,
  }) : super(key: key);

  final Color? color;
  final String btnText;
  final Function() onTap;
  final ButtonStyle? btnStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: btnStyle ??
          TextButton.styleFrom(
            backgroundColor: color ?? main_color,
            padding: EdgeInsets.symmetric(vertical: 0.015.sh),
            fixedSize: Size.fromWidth(0.60.sw),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sm),
            ),
          ),
      child: Text(
        btnText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15.sm,
        ),
      ),
      onPressed: onTap,
    );
  }
}
