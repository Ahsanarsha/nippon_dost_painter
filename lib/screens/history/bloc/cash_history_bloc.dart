import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nippon_dost/resources/models/cash_redeem_history_model.dart';
import 'package:nippon_dost/resources/repoitory.dart';
import 'package:nippon_dost/screens/history/view/cash_history.dart';

class CashHistoryBloc {
  final _repository = Repository();
  var isLoading = true.obs;
  var _cashHistoryReq;
  var showFiltered = false.obs;
  List<CashRedeemHistory>? _filteredCashHistory = [];

  dynamic get cashHistoryData => _cashHistoryReq;
  dynamic get filterCashHistoryData => _filteredCashHistory;

  cashHistoryRequest() async {
    isLoading.value = true;
    dynamic cashHistoryModel = await _repository.sendCashScanHistoryRequest();
    if(cashHistoryModel.success ==true){
      _cashHistoryReq = cashHistoryModel;
    } isLoading.value = false;
  }

  filterData({required DateTime startDate, required DateTime endDate}) {
    //Init from start
    _filteredCashHistory = [];
    showFiltered.value = false;
    isLoading.value = true;
    CashRedeemHistoryModel cashRedeemHistoryModel = _cashHistoryReq;
    cashRedeemHistoryModel.data..forEach((element) {
      DateTime dateTime = DateTime.parse(element.dealer.updatedAt.toString());
      if ((dateTime.isAfter(startDate) || dateTime.day == startDate.day) &&
          (dateTime.isBefore(endDate) || dateTime.day == endDate.day)) {
        _filteredCashHistory!.add(element);
      }
    });
    // if (_filteredCashHistory != null) {
    //   if (_filteredCashHistory!.isNotEmpty) {
    //     showFiltered.value = true;
    //   } else {
    //     print('not record found');
    //   }
    // } else {
    // }

    isLoading.value = false;
    showFiltered.value = true;
  }

  dispose() {
    _cashHistoryReq.close();
    _filteredCashHistory!.clear();
  }
}

final cashHistoryBloc = CashHistoryBloc();
