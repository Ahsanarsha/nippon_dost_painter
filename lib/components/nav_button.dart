import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavButton extends StatelessWidget {
  const NavButton(this.icon, this.color, this.onTap, {Key? key})
      : super(key: key);

  final String icon;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
                  horizontal: 0.04.sw,
                  vertical: 0.01.sh),
        child: Image.asset(
          icon,
          color: color,
        ),
      ),
    );
  }
}
