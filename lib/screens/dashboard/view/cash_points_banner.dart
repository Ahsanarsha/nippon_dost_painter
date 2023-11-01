import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/resources/models/dashboard_model.dart';
import 'package:nippon_dost/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CashPointsBanner extends StatefulWidget {
  const CashPointsBanner({ Key? key }) : super(key: key);

  @override
  _CashPointsBannerState createState() => _CashPointsBannerState();
}

class _CashPointsBannerState extends State<CashPointsBanner> {

  @override
  Widget build(BuildContext context) {
    DashboardModel dm = dashboardBloc.dashboardData;
    print('update data cash');
    print(dm.data.points);
    print(dm.data.cash);

    return Container(
      padding: EdgeInsets.only(top: 0.04.sh),
      width: 0.9.sw,
      height: 0.18.sh,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: 0.40.sw,
                height: 0.18.sh,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                  boxShadow: [
                    BoxShadow(
                      color: shadow_color.withOpacity(0.11),
                      blurRadius: 6,
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      points_banner_gradient_begin, //Begin
                      points_banner_gradient_end, //End
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Transform.translate(
                          offset: Offset(0, -15),
                          child: Container(
                            child: Image.asset(points),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            dm.data.points.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 0.02.sh),
                      child: Text(
                        'points'.tr,
                        style: TextStyle(
                          color: banner_text,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
                width: 0.40.sw,
                height: 0.18.sh,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(11)),
                  boxShadow: [
                    BoxShadow(
                      color: shadow_color.withOpacity(0.11),
                      blurRadius: 6,
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      cash_banner_gradient_begin, //Begin
                      cash_banner_gradient_end, //End
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Transform.translate(
                        offset: Offset(0, -15),
                        child: Container(
                          child: Image.asset(cash),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Text(
                            dm.data.cash.round().toString(),
                            style: TextStyle(
                              color: Colors.indigo.shade800,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0.02.sh),
                          child: Text(
                            'cash'.tr,
                            style: TextStyle(
                              color: banner_text,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
