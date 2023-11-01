import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/models/cash_history_model.dart';
import 'package:nippon_dost/resources/models/cash_redeem_history_model.dart';
import 'package:nippon_dost/screens/history/bloc/cash_history_bloc.dart';

class CashHistoryController extends GetxController {
  // RxList<CashHistoryModel> cashList = [
  //   CashHistoryModel(cash: '25', dealer: 'Dealer Name', date: '01-01-2021'),
  //   CashHistoryModel(cash: '25', dealer: 'Dealer Name', date: '01-01-2021'),
  //   CashHistoryModel(cash: '25', dealer: 'Dealer Name', date: '01-01-2021'),
  //   CashHistoryModel(cash: '25', dealer: 'Dealer Name', date: '01-01-2021'),
  //   CashHistoryModel(cash: '25', dealer: 'Dealer Name', date: '01-01-2021'),
  //   CashHistoryModel(cash: '25', dealer: 'Dealer Name', date: '01-01-2021'),
  // ].obs;
}

class CashHistory extends GetResponsiveView<CashHistoryController> {
  @override
  Widget builder() {
    // NavbarController _nbc = Get.put(NavbarController());
    // CashHistoryController _chc = Get.put(CashHistoryController());
    // CashRedeemHistoryModel _chm = cashHistoryBloc.cashHistoryData;

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
              padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _txtTitle('sr.'.tr),
                  ),
                  Expanded(
                    flex: 2,
                    child: _txtTitle('cash'.tr),
                  ),
                  Expanded(
                    flex: 2,
                    child: _txtTitle('dealer'.tr),
                  ),
                  Expanded(
                    flex: 2,
                    child: _txtTitle('date'.tr),
                  ),
                  Expanded(
                    flex: 2,
                    child: _txtTitle('time'.tr),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(()=> cashHistoryBloc.isLoading.value? Center(child: CircularProgressIndicator()) :
              Obx(()=> cashHistoryBloc.showFiltered.value?
              ListView.separated(
                itemCount:  cashHistoryBloc.filterCashHistoryData!.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  CashRedeemHistory cashHistory = cashHistoryBloc.filterCashHistoryData[i];
                  DateTime datetime = DateTime.parse(cashHistory.dealer.updatedAt.toString());
                  return _listTile(
                    '${i + 1}',
                    cashHistory.cash.toString(),
                    cashHistory.dealer.dealerName,
                    '${datetime.day}-'+'${datetime.month}-'+'${ datetime.year}'.toString(),
                    '${datetime.hour}:'+'${datetime.minute}'.toString(),
                  );
                },
                separatorBuilder: (ctx, i) {
                  return _divider();
                },
              )
              :
              ListView.separated(
                itemCount:  cashHistoryBloc.cashHistoryData!.data.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  CashRedeemHistoryModel cashRedeemHistoryModel = cashHistoryBloc.cashHistoryData;
                  DateTime datetime = DateTime.parse(cashRedeemHistoryModel.data[i].dealer.updatedAt.toString());
                  // print('data in item builder '+cashHistoryBloc.cashHistoryData.data[i].dealer.name);
                  // _gsc.pointsList.sort((a, b) => a.compareTo(b));
                  // int num = getNextLargerNumber(47000, _gsc.pointsList);
                  // print(num.toString());
                  return _listTile(
                    '${i + 1}',
                    cashHistoryBloc.cashHistoryData.data[i].cash.toString(),
                    cashHistoryBloc.cashHistoryData.data[i].dealer.dealerName,
                    '${datetime.day}-'+'${datetime.month}-'+'${ datetime.year}'.toString(),
                    '${datetime.hour}:'+'${datetime.minute}'.toString(),
                  );
                },
                separatorBuilder: (ctx, i) {
                  return _divider();
                },
              ),),)
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile(String sr, String points, String gifts, String status, String time ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.02.sw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _txt(sr, false),
          ),
          Expanded(
            flex: 2,
            child: _txt(points, false),
          ),
          Expanded(
            flex: 2,
            child: _txt(gifts, false),
          ),
          Expanded(
            flex: 2,
            child: _txt(status, true),
          ),
          Expanded(
            flex: 2,
            child: _txt(time, true),
          ),
        ],
      ),
    );
  }

  Widget _txtTitle(String txt) {
    return Container(
      // width: 0.22.sw,
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

  Widget _txt(String txt, bool isStatus) {
    Color _color = Color(0xFF03428D);
    switch (isStatus) {
      case true:
        if (txt == 'Pending') {
          _color = Color(0xFFD5B200);
        } else if (txt == 'Received') {
          _color = Color(0xFF03428D);
        }
        if (txt == 'Delivered') {
          _color = Color(0xFF28AF00);
        }
        break;
      default:
        _color = Color(0xFF03428D);
    }
    return Container(
      // width: 0.22.sw,
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _color,
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
}
