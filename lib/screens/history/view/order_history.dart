import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/models/points_history_model.dart';
import 'package:nippon_dost/resources/models/order_scan_history_model.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/screens/history/bloc/order_scan_history_bloc.dart';
import 'package:nippon_dost/screens/history/bloc/points_history_bloc.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class OrderHistoryController extends GetxController {
  RxString orderId = ''.obs;
}

class OrderHistory extends GetResponsiveView<OrderHistoryController> {
  @override
  Widget builder() {
    NavbarController _nbc = Get.put(NavbarController());
    OrderHistoryController _ohc = Get.put(OrderHistoryController());
    // OrderScanHistoryModel _oshm = orderScanHistoryBloc.orderScanHistoryData;


    return Container(
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
              color: shadow_color.withOpacity(0.16),
              blurRadius: 6,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0xFFE7EBF9),
              padding: EdgeInsets.symmetric(vertical: 0.02.sh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(flex: 1, child: _txtTitle('sr.'.tr)),
                  Expanded(flex: 2, child: _txtTitle('points_smaller'.tr)),
                  Expanded(flex: 2, child: _txtTitle('cash'.tr)),
                  Expanded(flex: 2, child: _txtTitle('date'.tr)),
                ],
              ),
            ),
            Expanded(
              child: Obx(()=> orderScanHistoryBloc.isLoading.value? Center(child: CircularProgressIndicator()) :

             Obx(()=> orderScanHistoryBloc.showFiltered.value?
              //filtered List
             ListView.separated(
               itemCount: orderScanHistoryBloc.filteredOrderScanHistoryData.length,
               physics: ClampingScrollPhysics(),
               shrinkWrap: true,
               itemBuilder: (ctx, i) {
                 return _listTile(
                   '${i + 1}',
                   orderScanHistoryBloc.filteredOrderScanHistoryData[i].points.toString(),
                   orderScanHistoryBloc.filteredOrderScanHistoryData[i].cash.toString(),
                   orderScanHistoryBloc.filteredOrderScanHistoryData[i].updatedAt,
                   orderScanHistoryBloc.filteredOrderScanHistoryData[i].orderId,
                   _ohc,
                   _nbc,
                 );
               },
               separatorBuilder: (ctx, i) {
                 return _divider();
               },
             ) :  ListView.separated(
                itemCount: orderScanHistoryBloc.orderScanHistoryData.data.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  return _listTile(
                    '${i + 1}',
                    orderScanHistoryBloc.orderScanHistoryData.data[i].points.toString(),
                    orderScanHistoryBloc.orderScanHistoryData.data[i].cash.toString(),
                    orderScanHistoryBloc.orderScanHistoryData.data[i].updatedAt,
                    orderScanHistoryBloc.orderScanHistoryData.data[i].orderId,
                    _ohc,
                    _nbc,
                  );
                },
                separatorBuilder: (ctx, i) {
                  return _divider();
                },
              ),),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile(
    String sr,
    String points,
    String cash,
    String date,
    String orderId,
    OrderHistoryController ohc,
    NavbarController nbc
  ) {
    return InkWell(
      onTap: () {
        ohc.orderId.value = orderId.toString();
        nbc.changeBar(true);
        Get.toNamed(Routes.OrderScanSingleHistory);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.02.sh),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: _txt(sr)),
            Expanded(flex: 2, child: _txt(points)),
            Expanded(flex: 2, child: _txt(cash)),
            Expanded(flex: 2, child: _txt(formattedDate(date))),
          ],
        ),
      ),
    );
  }

  Widget _txtTitle(String txt) {
    return Container(
      width: 0.18.sw,
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF03428D),
          fontSize: 14.sm,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _txt(String txt) {
    return Container(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(0xFF03428D),
          fontSize: 14.sm,
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
      child: Divider(
        thickness: 1,
        height: 2,
        color: Color(0xFFCFDBFF),
      ),
    );
  }

  String formattedDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formatDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formatDate;
  }
}
