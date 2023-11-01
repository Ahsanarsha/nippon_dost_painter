import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/resources/models/dashboard_model.dart';
import 'package:nippon_dost/resources/models/gift_model.dart';
import 'package:nippon_dost/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:nippon_dost/screens/gift_slab/bloc/gift_bloc.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SlabBanner extends StatelessWidget {
  String itemName;
  SlabBanner(this.itemName);

  @override
  Widget build(BuildContext context) {
    DashboardModel _dm = dashboardBloc.dashboardData;
    GiftModel _gm = giftSlabBloc.giftData;

    return Container(
      width: 1.0.sw,
      height: 0.30.sh,
      decoration: BoxDecoration(
        color: top_banner_color,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            top_banner_gradient_begin, //Begin
            top_banner_gradient_end, //End
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.only(
                top: 0.03.sh,
              ),
              width: 0.60.sw,
              height: 0.20.sh,
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Image.asset(banner_background),
                    alignment: Alignment.topCenter,
                  ),
                  Positioned(
                    // left: 0.21.sw,
                    left: 0.15.sw,
                    top: 0.05.sh,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Text(
                        //   _dm.data.points.toString(),
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 30.sm,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.014.sh,
                          ),
                          child: Text(
                            itemName,
                            style: TextStyle(
                              fontSize: 25.sm,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 0.065.sw,
                  //commented to adjust urdu language
                  bottom: 0.005.sh,
                ),
                child: Text(
                  'slab'.tr,
                  style: TextStyle(
                    fontSize: 15.sm,
                    color: Color(0xFFA3BEDF),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 0.06.sw,
                ),
                child: Text(
                  'gift_redemption_slab'.tr,
                  style: TextStyle(
                    fontSize: 25.sm,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
