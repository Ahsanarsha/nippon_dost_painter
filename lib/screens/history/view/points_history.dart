import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/models/points_history_model.dart';
import 'package:nippon_dost/resources/models/points_redeem_history_model.dart';
import 'package:nippon_dost/screens/history/bloc/points_history_bloc.dart';

class PointsHistoryController extends GetxController {
  // RxList<PointsHistoryModel> pointsList = [
  //   PointsHistoryModel(
  //       points: '50000', gifts: 'Kia Picanto', status: 'Pending'),
  //   PointsHistoryModel(points: '40000', gifts: 'Bike A', status: 'Received'),
  //   PointsHistoryModel(
  //       points: '35000', gifts: 'UNITED UD 70', status: 'Delivered'),
  //   PointsHistoryModel(points: '25000', gifts: 'AC', status: 'Pending'),
  // ].obs;
}

class PointsHistory extends GetResponsiveView<PointsHistoryController> {
  @override
  Widget builder() {
    // NavbarController _nbc = Get.put(NavbarController());
    // PointsHistoryController _phc = Get.put(PointsHistoryController());
    // PointsRedeemHistoryModel? _phm = pointsHistoryBloc.pointsHistoryData;

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
              padding: EdgeInsets.only(top: 0.02.sh, bottom: 0.02.sh, right: 0.04.sw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: _txtTitle('sr.'.tr),
                  ),
                  Expanded(
                    flex: 1,
                    child: _txtTitle('points_smaller'.tr),
                  ),
                  Expanded(
                    flex: 2,
                    child: _txtTitle('gifts'.tr),
                  ),
                  Expanded(
                    flex: 1,
                    child: _txtTitle('status'.tr),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(()=> pointsHistoryBloc.isLoading.value? Center(child: CircularProgressIndicator()) :
              pointsHistoryBloc.pointsHistoryData.data!=null?
              Obx(()=> pointsHistoryBloc.showFiltered.value?
                  ListView.separated(
                    itemCount: pointsHistoryBloc.filteredPointsHistory.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) {
                      return _listTile(
                        '${i + 1}',
                        pointsHistoryBloc.filteredPointsHistory[i].point.toString(),
                        pointsHistoryBloc.filteredPointsHistory[i].giftName.name??'',
                        pointsHistoryBloc.filteredPointsHistory[i].status.toString(),
                      );
                    },
                    separatorBuilder: (ctx, i) {
                      return _divider();
                    },
                  )

                    :

              ListView.separated(
                itemCount: pointsHistoryBloc.pointsHistoryData.data.pointHistory.length,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, i) {
                  // _gsc.pointsList.sort((a, b) => a.compareTo(b));
                  // int num = getNextLargerNumber(47000, _gsc.pointsList);
                  // print(num.toString());

                  return _listTile(
                    '${i + 1}',
                    pointsHistoryBloc.pointsHistoryData.data.pointHistory[i].point.toString(),
                    pointsHistoryBloc.pointsHistoryData.data.pointHistory[i].giftName.name??'',
                    pointsHistoryBloc.pointsHistoryData.data.pointHistory[i].status.toString(),
                  );
                },
                separatorBuilder: (ctx, i) {
                  return _divider();
                },
              )):Container(),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listTile(String sr, String points, String gifts, String status) {
    if(status==null ||status.isEmpty ||status=='null')
      status='';
    return Container(
      padding: EdgeInsets.only(top: 0.02.sh, bottom: 0.02.sh, right: 0.04.sw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _txt(sr, false),
          ),
          Expanded(
            flex: 1,
            child: _txt(points, false),
          ),
          Expanded(
            flex: 2,
            child: _txt(gifts, false),
          ),
          Expanded(
            flex: 1,
            child: _txt(status, true),
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
