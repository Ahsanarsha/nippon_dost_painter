import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nippon_dost/resources/models/dashboard_model.dart';
import 'package:nippon_dost/resources/repoitory.dart';

class DashboardBloc {
  final _repository = Repository();
  var _dashboardReq;
  var refreshData = false.obs;
  var isLoadingData = false.obs;


  void refreshDataWithBack(){
    Get.back();
    dashboardRequest();
  }


  dynamic get dashboardData => _dashboardReq;

  dashboardRequest() async {
    isLoadingData.value = true;
    dynamic dashboardModel = await _repository.sendDashboardRequest();
    print('in db request');
    print(dashboardModel);
      if(dashboardModel.success){
        _dashboardReq = dashboardModel;
      }

    isLoadingData.value = false;
    print('after receiving data from repository');

  }

  dispose() {
    _dashboardReq.close();
    refreshData.close();
  }
}

final dashboardBloc = DashboardBloc();
