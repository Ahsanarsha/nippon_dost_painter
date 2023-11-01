import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NewOrderScan extends StatelessWidget {
  const NewOrderScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavbarController _nbc = Get.put(NavbarController());

    return Padding(
      padding: EdgeInsets.only(top: 0.02.sh),
      child: Container(
        width: 0.9.sw,
        height: 0.10.sh,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
           color: order_scan_button_bg,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: shadow_color.withOpacity(0.18),
              blurRadius: 10,
              offset: Offset(0.42, 7.99), // Shadow position
            ),
          ],
        ),
        // color: Color( 0xffeeeebf ),
        child: Padding(
          padding: EdgeInsets.only(left: 0.03.sw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 0.60.sw,
                height: 0.055.sh,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: shadow_color.withOpacity(0.18),
                      blurRadius: 10,
                      offset: Offset(0.42, 7.99), // Shadow position
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: main_color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _nbc.changeBar(true);
                    _nbc.goBack(true);
                    Get.toNamed(Routes.RedeemToken);
                  },
                  child: Text(
                    'new_order_scan'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sm,
                    ),
                  ),
                ),
              ),
              Container(
                width: 0.20.sw,
                child: Transform.translate(
                  offset: Offset(5, 5),
                  child: Container(
                    child: Image.asset(order_scan),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
