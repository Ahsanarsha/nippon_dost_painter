import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/components/navbar.dart';
import 'package:nippon_dost/resources/models/order_scan_single_history_model.dart';
import 'package:nippon_dost/screens/history/bloc/order_scan_single_history_bloc.dart';
import 'package:nippon_dost/screens/history/view/order_history.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class OrderScanSingleHistoryController extends GetxController {
  RxList<ScanQr> sqr = <ScanQr>[].obs;

  void init() async {
    OrderHistoryController _ohc = Get.put(OrderHistoryController());
    await orderScanSingleHistoryBloc
        .orderScanSingleHistoryRequest(_ohc.orderId.value);
    sqr.value =
        orderScanSingleHistoryBloc.orderScanSingleHistoryData.data.scanQr;
  }
}

class OrderScanSingleHistory extends GetView<OrderScanSingleHistoryController> {
  @override
  Widget build(BuildContext context) {
    OrderScanSingleHistoryController _osc =
        Get.put(OrderScanSingleHistoryController());
    _osc.init();

    return Scaffold(
      appBar: mainAppBar,
      bottomNavigationBar: NavBar(),
      body: Column(
        children: <Widget>[
          Container(
            width: 1.0.sw,
            height: 0.25.sh,
            padding: EdgeInsets.only(
              top: 0.02.sh,
            ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(() => Center(
                      child: Text(
                        _osc.sqr.length > 0 ? _osc.sqr.length.toString() : '0',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.sm,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 0.014.sh,
                    ),
                    child: Text(
                      'Number of scans',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sm,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 0.06.sh,
                  ),
                  padding: EdgeInsets.only(
                    left: 0.06.sw,
                  ),
                  child: Text(
                    'Order Scan History',
                    style: TextStyle(
                        fontSize: 22.sm,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
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
                        color: shadow_color.withOpacity(0.16),
                        blurRadius: 6,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Obx(
                    () => _osc.sqr.length > 0
                        ? Column(
                            children: <Widget>[
                              Container(
                                color: Color(0xFFE7EBF9),
                                padding: EdgeInsets.symmetric(
                                  vertical: 0.02.sh,
                                  horizontal: 0.02.sw,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: _txtTitle('Sr.'),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: _txtTitle('Product'),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: _txtTitle('Date'),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: _txtTitle('Time'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: _osc.sqr.length,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (ctx, i) {
                                    return _listTile(
                                      '${i + 1}',
                                      _osc.sqr[i].product.name,
                                      _osc.sqr[i].updatedAt,
                                    );
                                  },
                                  separatorBuilder: (ctx, i) {
                                    return _divider();
                                  },
                                ),
                              ),
                            ],
                          )
                        : Center(child: CircularProgressIndicator()),
                  )),
            ),
          ),
        ],
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

  Widget _listTile(
    String sr,
    String product,
    DateTime datetime,
  ) {
    return Container(
      // color: reward == true ? Color(0xFFAFD4FF) : null,
      padding: EdgeInsets.symmetric(
        vertical: 0.02.sh,
        horizontal: 0.02.sw,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _txt(sr),
          ),
          Expanded(
            flex: 3,
            child: _txt(product),
          ),
          Expanded(
            flex: 2,
            child: _txt(formattedDate(datetime.toString())),
          ),
          Expanded(
            flex: 2,
            child: _txt(formattedTime(datetime.toString())),
          ),
        ],
      ),
    );
  }

  Widget _txt(String txt) {
    return Container(
      width: 0.18.sw,
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

  String formattedTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formatDate = DateFormat('hh:mm a').format(dateTime);
    return formatDate;
  }
}
