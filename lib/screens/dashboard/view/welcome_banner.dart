import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/resources/models/profile_model.dart';
import 'package:nippon_dost/screens/profile/bloc/profile_bloc.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileModel pm = profileBloc.profileData;

    return Container(
      width: 1.0.sw,
      height: 0.24.sh,
      padding: EdgeInsets.only(
        top: 0.02.sh,
      ),
      margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: AssetImage(home_banner),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.all(Radius.circular(0.04.sh)),
        boxShadow: [
          BoxShadow(
            color: shadow_color.withOpacity(0.11),
            blurRadius: 6,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'welcome'.tr,
              style: TextStyle(
                color: Colors.red.shade500,
                fontSize: 20.sm,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              pm.data[0].name,
              style: TextStyle(
                color: Colors.indigo.shade700,
                fontSize: 24.sm,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
