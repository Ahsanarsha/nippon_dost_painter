import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/resources/api_provider.dart';
import 'package:nippon_dost/screens/gift_slab/bloc/gift_bloc.dart';
import 'package:nippon_dost/screens/history/bloc/order_scan_history_bloc.dart';
import 'package:nippon_dost/screens/profile/bloc/profile_bloc.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/dashboard_bloc.dart';
import 'view/cash_points_banner.dart';
import 'view/earning_banner.dart';
import 'view/my_qr.dart';
import 'view/new_order_scan.dart';
import 'view/welcome_banner.dart';

class Dashboard extends StatelessWidget {
  // const Dashboard({Key? key}) : super(key: key);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    print("on refresh");
    // monitor network fetch
    await updateData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    print("on loading");
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }

  Future updateData() async {
    print('refresh data call');
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await dashboardBloc.dashboardRequest();
      } else {
        Get.snackbar(
          'sorry'.tr,
          'something_went_wrong'.tr,
          backgroundColor: main_color,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'sorry'.tr,
        'something_went_wrong'.tr,
        backgroundColor: main_color,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
    dashboardBloc.refreshData.value = false;
  }

  @override
  Widget build(BuildContext context) {

    postFCMToken();

    // dashboardBloc.refreshData.listen((p0) async {
    //   // bool gotData = false;
    //   if (p0) {
    //     print("$p0");
    //     // if(!gotData){
    //     //   print('going to call API from build ');
    //     await updateData();
    //     //  //  gotData = true;
    //     // }
    //     dashboardBloc.refreshData.value = false;
    //   }
    // });
    // return SmartRefresher(
    //
    //   enablePullDown: true,
    //   physics: AlwaysScrollableScrollPhysics(),
    //   header: MaterialClassicHeader(),
    //   controller: _refreshController,
    //   onRefresh: _onRefresh,
    //   onLoading: _onLoading,
    //   child: Container(
    //     padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.03.sh),
    //     color: app_background_color,
    //     child: Flex(
    //       direction: Axis.vertical,
    //       children: <Widget>[
    //         Expanded(flex: 1, child: WelcomeBanner()),
    //         EarningBanner(),
    //         CashPointsBanner(),
    //         NewOrderScan(),
    //         MyQr(),
    //       ],
    //     ),
    //   )
    //   // child: ListView.builder(
    //   //   itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
    //   //   itemExtent: 100.0,
    //   //   itemCount: items.length,
    //   // ),
    // );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.03.sh),
      color: app_background_color,
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(flex: 1, child: WelcomeBanner()),
          EarningBanner(),
          Obx(() => dashboardBloc.isLoadingData.value
              ? CircularProgressIndicator()
              : CashPointsBanner()),
          NewOrderScan(),
          MyQr(),
        ],
      ),
    );
  }


  postFCMToken() async{
    var response = await ApiProvider().postFCMToken();
    if(response){
      debugPrint('FCM TOKEN POST SUCCESSFUL');

    }else{
      debugPrint('FCM TOKEN POST UNSUCCESSFUL');
    }
  }
}
