import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nippon_dost/resources/models/order_scan_history_model.dart';
import 'package:nippon_dost/resources/repoitory.dart';

class OrderScanHistoryBloc {
  final _repository = Repository();
  var _orderScanHistoryReq;
  var isLoading = true.obs;
  var showFiltered = false.obs;
  List<OrderScanData>? _filteredOrderScanHistoryReq;

  dynamic get orderScanHistoryData => _orderScanHistoryReq;
  dynamic get filteredOrderScanHistoryData => _filteredOrderScanHistoryReq;

  filterData({required DateTime startDate, required DateTime endDate}){
    //Init from start
    _filteredOrderScanHistoryReq = [];
    showFiltered.value = false;
    isLoading.value = true;
    OrderScanHistoryModel orderScanHistoryModel = _orderScanHistoryReq;
    orderScanHistoryModel.data.forEach((element) {
      DateTime dateTime = DateTime.parse(element.updatedAt);
      if((dateTime.isAfter(startDate) || dateTime.day== startDate.day) && (dateTime.isBefore(endDate)  || dateTime.day== endDate.day )){
        _filteredOrderScanHistoryReq!.add(element);
      }
    });
    isLoading.value = false;
    showFiltered.value = true;

  }

  orderScanHistoryRequest() async {
    isLoading.value = true;
    dynamic orderScanHistoryModel = await _repository.sendOrderScanHistoryRequest();
    print('got new response from order History API');
    print(orderScanHistoryModel);
    _orderScanHistoryReq = orderScanHistoryModel;
    if(orderScanHistoryModel.success ==true){
      _orderScanHistoryReq = orderScanHistoryModel;
    }
    isLoading.value = false;
  }

  dispose() {
    _orderScanHistoryReq.close();
  }
}

final orderScanHistoryBloc = OrderScanHistoryBloc();
