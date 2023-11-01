import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CpListItem extends StatelessWidget {
  const CpListItem(
      {required this.sr,
        required this.name,
      required this.points,
      required this.cash,
      required this.time,
      Key? key})
      : super(key: key);

  final int sr;
  final String name;
  final String points;
  final String cash;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.width * 0.05,),
      height: 0.09.sh,
      width: Get.width,
      color: Color(0xFFF3F6FD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: Get.width * 0.05, bottom: Get.width * 0.03),
                width: Get.width * 0.8,
                child: Text(
                  name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Color(0xFF03428D),
                    fontSize: 12.sp,
                  ),
                ),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 0.16.sw,
                // padding: EdgeInsets.only(left: Get.width * 0.05, bottom: Get.width * 0.02),
                child: Text(
                  'Sr. $sr',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF03428D),
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Container(
                width: 0.20.sw,
                child: Text(
                  'Points  $points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF03428D),
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Container(
                width: 0.20.sw,
                child: Text(
                  'Cash $cash',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF03428D),
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Container(
                width: 0.30.sw,
                child: Text(
                  'Time $time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF03428D),
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
