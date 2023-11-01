import 'package:nippon_dost/resources/repoitory.dart';

class OrderScanSingleHistoryBloc {
  final _repository = Repository();
  var _orderScanSingleHistoryReq;

  dynamic get orderScanSingleHistoryData => _orderScanSingleHistoryReq;

  orderScanSingleHistoryRequest(String orderId) async {
    dynamic orderScanSingleHistoryModel = await _repository.sendOrderScanSingleHistoryRequest(orderId);
    _orderScanSingleHistoryReq = orderScanSingleHistoryModel;
  }

  dispose() {
    _orderScanSingleHistoryReq.close();
  }
}

final orderScanSingleHistoryBloc = OrderScanSingleHistoryBloc();
