import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/resources/models/qr_redeem_model.dart';
import 'package:nippon_dost/resources/models/qr_scan_model.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/screens/app_widgets/loading_widget.dart';
import 'package:nippon_dost/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:nippon_dost/screens/history/bloc/cash_history_bloc.dart';
import 'package:nippon_dost/screens/history/bloc/order_scan_history_bloc.dart';
import 'package:nippon_dost/screens/history/bloc/points_history_bloc.dart';
import 'package:nippon_dost/screens/history/history.dart';
import 'package:nippon_dost/screens/redeem_token/bloc/qr_redeem_bloc.dart';
import 'package:nippon_dost/screens/redeem_token/controller/qr_view_controller.dart';
import 'package:nippon_dost/screens/redeem_token/view/cp_list_item.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class CPListing extends StatelessWidget {
  const CPListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QrViewContoller _qvc = Get.put(QrViewContoller());
    NavbarController _nc = Get.put(NavbarController());
    List<String> scanningTimes = [];


    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0.01.sh,
        horizontal: 0.01.sh,
      ),
      width: 1.0.sw,
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                // Container(
                //   height: 0.05.sh,
                //   color: Color(0xffE7EBF9),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: <Widget>[
                //       Container(
                //         width: 0.20.sw,
                //         child: Text(
                //           'sr.'.tr,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: Color(0xFF03428D),
                //             fontSize: 15.sm,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       Container(
                //         width: 0.20.sw,
                //         child: Text(
                //           'points_smaller'.tr,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: Color(0xFF03428D),
                //             fontSize: 15.sm,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       Container(
                //         width: 0.20.sw,
                //         child: Text(
                //           'cash'.tr,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: Color(0xFF03428D),
                //             fontSize: 15.sm,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       Container(
                //         width: 0.20.sw,
                //         child: Text(
                //           'time'.tr,
                //           textAlign: TextAlign.center,
                //           style: TextStyle(
                //             color: Color(0xFF03428D),
                //             fontSize: 15.sm,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Obx(
                  () => Flexible(
                    child: ListView.separated(
                      itemCount: _qvc.scannedQr.length,
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (ctx, i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.01.sw),
                          child: Divider(
                            thickness: 1,
                            height: 2,
                            color: Color(0xFFCFDBFF),
                          ),
                        );
                      },
                      itemBuilder: (ctx, i) {
                        scanningTimes.add(formattedDate());
                        return CpListItem(
                          sr: i + 1,
                          name: _qvc.scannedQr[i].data.productName,
                          points: _qvc.scannedQr[i].data.point.toString(),
                          cash: _qvc.scannedQr[i].data.cash
                              .toString(),
                          time: scanningTimes[i],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 0.20.sw,
                vertical: 0.02.sh,
              ),
              width: 1.0.sw,
              child: ElevatedButton(
                onPressed: () async {
                  if(_qvc.scannedQrIds.isNotEmpty){
                    loadingWidget(context);
                    await qrRedeemBloc.qrRedeemRequest(_qvc.scannedQrIds);
                    _qvc.scannedQrIds.value = [];
                    // QrRedeemModel qrRedeemModel = qrRedeemBloc.qrRedeemResponse;
                    dynamic qrRedeemModel = qrRedeemBloc.qrRedeemResponse;
                    if (qrRedeemModel.success) {
                      // await dashboardBloc.dashboardRequest();
                      Get.snackbar(
                        'success'.tr,
                        'all_qr_code_redeemed'.tr,
                        backgroundColor: main_color,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 3),
                      );
                      // ignore: deprecated_member_use
                      _qvc.scannedQr.value = [];
                      _qvc.scannedValidationIds.value = [];
                      await dashboardBloc.dashboardRequest();
                      await orderScanHistoryBloc.orderScanHistoryRequest();
                      await cashHistoryBloc.cashHistoryRequest();
                      await pointsHistoryBloc.pointsHistoryRequest();
                      Get.back();
                      Navigator.of(context).pop(true);
                      Get.offAndToNamed(Routes.Home);
                      _nc.goBack(false);
                      _nc.changeBar(false);
                      _nc.changeIndex(0);
                    }else{
                      await dashboardBloc.dashboardRequest();
                      Navigator.of(context).pop(true);
                      Get.snackbar(
                        'sorry'.tr,
                        'something_went_wrong'.tr,
                        backgroundColor: main_color,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 3),
                      );
                    }
                  }else{
                    Get.snackbar(
                      'Validation Error',
                      'Scan at least 1 QR',
                      backgroundColor: main_color,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: Duration(seconds: 3),
                    );
                  }

                },
                child: Text('done'.tr),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.indigo.shade600),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  String formattedDate() {
    DateTime dateTime = DateTime.now();
    String formatDate = DateFormat('hh:mm a').format(dateTime);
    return formatDate;
  }
}
