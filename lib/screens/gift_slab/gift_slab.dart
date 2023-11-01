import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/resources/models/dashboard_model.dart';
import 'package:nippon_dost/resources/models/gift_model.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:nippon_dost/screens/gift_slab/bloc/gift_bloc.dart';
import 'package:nippon_dost/screens/gift_slab/view/gift_detail.dart';
import 'package:nippon_dost/screens/gift_slab/view/slab_banner.dart';

import 'dart:math';

import 'controller/gift_controller.dart';

class GiftSlabController extends GetxController {
  RxInt reward = 0.obs;

  RxList<int> pointsList = <int>[].obs;
  // RxList<int> diffList = RxList<int>();

  RxList<GiftData> giftsList = <GiftData>[].obs;

  void addGiftData(List<GiftData> data) {
    pointsList.clear();
    giftsList.clear();
    data.forEach((item) {
      pointsList.add(int.parse(item.giftPoint.toString()));
      giftsList.add(item);
    });
  }

  bool checkForIdenticalNumber(int compareNumber) {
    if (pointsList.contains(compareNumber)) {
      print('The number $compareNumber is identical to the compareNumber');
      reward.value = pointsList.indexWhere((e) => e == compareNumber);
      return true;
    }
    return false;
  }

  // void checkDifference(int number, int compare) {
  //   if (number > compare) {
  //     int difference = number - compare;
  //     diffList.add(difference);
  //   } else {
  //     int difference = compare - number;
  //     diffList.add(difference);
  //   }
  // }

  // void findNearestNumber(int compare) {
  //   pointsList.forEach((number) => checkDifference(number, compare));
  // }

  // int checkForSolution() {
  //   int index = diffList.indexWhere((e) => e == diffList.reduce(min));
  //   print("The closest number is: ${pointsList[index]}");
  //   return index;
  // }

  // int findNearest(int compareNumber) {
  //   bool isIdentical = checkForIdenticalNumber(compareNumber);
  //   if (!isIdentical) {
  //     findNearestNumber(compareNumber);
  //     // print(numbersList);
  //     // print(differenceList);
  //     int i = checkForSolution();
  //     return i;
  //   } else {
  //     int i = pointsList.indexWhere((e) => e == compareNumber);
  //     return i;
  //   }
  // }

  findIndex(int compareNumber) {
    List<int> sortList = pointsList.toList();
    sortList.sort();
    for (int i = 0; i < sortList.length; i++) {
      // print(pointsList[i]);
      if (compareNumber > sortList[i]) {
        reward.value = pointsList.indexOf(sortList[i]);
        // // print('I--- $index');
        // print('Reward Select ${}');
      }
    }
  }

  findNearestSlab(int compareNumber) {
    print(compareNumber);
    bool isIdentical = checkForIdenticalNumber(compareNumber);
    if (!isIdentical) {
      findIndex(compareNumber);
    }
    // else {
    //   reward.value = pointsList.indexWhere((e) => e == compareNumber);
    // }
  }
}

class GiftSlab extends GetResponsiveView<GiftSlabController> {
  @override
  Widget builder() {
    NavbarController _nbc = Get.put(NavbarController());
    GiftSlabController _gsc = Get.put(GiftSlabController());
    GiftController _gc = Get.put(GiftController());
    DashboardModel _dm = dashboardBloc.dashboardData;
    GiftModel _gm = giftSlabBloc.giftData;
    _gsc.addGiftData(_gm.data);
    _gsc.findNearestSlab(_dm.data.points.toInt());
    String bannerText = '';
    if(_gsc.giftsList.isNotEmpty && _gsc.reward.value!=null)
     bannerText = _gsc.giftsList[_gsc.reward.value].name;
    return Column(
      children: <Widget>[
        SlabBanner(bannerText),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 0.04.sw,
              vertical: 0.02.sh,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF3F6FD),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF707070),
                    blurRadius: 6,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Color(0xFFE7EBF9),
                    child: ListTile(
                      leading: Text(
                        'gifts'.tr,
                        style: TextStyle(
                          color: Color(0xFF03428D),
                          fontSize: 14.sm,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        'points_smaller'.tr,
                        style: TextStyle(
                          color: Color(0xFF03428D),
                          fontSize: 16.sm,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _gsc.giftsList.isNotEmpty? ListView.separated(
                      itemCount: _gsc.giftsList.length,
                      // physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        // _gsc.pointsList.sort((a, b) => a.compareTo(b));
                        // int num = getNextLargerNumber(47000, _gsc.pointsList);
                        // print(num.toString());

                        return _listTile(
                            _gsc.giftsList[i].name,
                            _gsc.giftsList[i].giftPoint.toString(),
                            _gsc.reward.value == i,
                            _gc,
                            _nbc,
                          _gsc.giftsList[i].id
                        );
                      },
                      separatorBuilder: (ctx, i) {
                        return _divider();
                      },
                    ):Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listTile(String gift, String points, bool reward, GiftController gc,
      NavbarController nbc, int giftId) {
    return InkWell(
      onTap: () {
        gc.setIndex(giftId);
        nbc.changeBar(true);
        Get.toNamed(Routes.GiftDetail);
      },
      child: Container(
        color: reward == true ? Color(0xFFAFD4FF) : null,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    gift,
                    style: TextStyle(color: Color(0xFF03428D), fontSize: 16.sm),
                  ),
                ),
                Text(
                  points,
                  style: TextStyle(color: Color(0xFF03428D), fontSize: 16.sm),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.10.sw),
      child: Divider(
        thickness: 1,
        height: 2,
        color: Color(0xFFCFDBFF),
      ),
    );
  }

  getNextLargerNumber(int number, List<int> arr) {
    for (var i = 0; i < arr.length; i++) {
      if (number > arr[i]) {
        return arr[i];
      }
    }
    return -1;
  }
}
