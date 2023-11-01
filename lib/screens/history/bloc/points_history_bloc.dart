import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:nippon_dost/models/points_history_model.dart';
import 'package:nippon_dost/resources/models/points_redeem_history_model.dart';
import 'package:nippon_dost/resources/repoitory.dart';

class PointsHistoryBloc {
  final _repository = Repository();
  var _pointsHistoryReq;
  var isLoading = true.obs;
  var showFiltered = false.obs;
  List<PointHistory>? _filteredPointsHistory = [];

  dynamic get pointsHistoryData => _pointsHistoryReq;
  dynamic get filteredPointsHistory => _filteredPointsHistory;

  pointsHistoryRequest() async {
    isLoading.value = true;
    dynamic pointsHistoryModel =
        await _repository.sendPointsScanHistoryRequest();
    if (pointsHistoryModel.success) {
      _pointsHistoryReq = pointsHistoryModel;
    }
    isLoading.value = false;
  }

  filterData({required DateTime startDate, required DateTime endDate}) {
    //Init from start
    _filteredPointsHistory = [];
    showFiltered.value = false;
    isLoading.value = true;
    PointsRedeemHistoryModel pointsRedeemHistoryModel = _pointsHistoryReq;
    pointsRedeemHistoryModel.data.pointHistory.forEach((element) {
      DateTime dateTime = DateTime.parse(element.updatedAt.toString());
      if ((dateTime.isAfter(startDate) || dateTime.day == startDate.day) &&
          (dateTime.isBefore(endDate) || dateTime.day == endDate.day)) {
        _filteredPointsHistory!.add(element);
      }
    });
    if (_filteredPointsHistory != null) {
      if (_filteredPointsHistory!.isNotEmpty) {
        showFiltered.value = true;
      } else {
        print('not record found');
      }
    } else {
    }

    isLoading.value = false;
    showFiltered.value = true;
  }

  dispose() {
    _pointsHistoryReq.close();
    _filteredPointsHistory!.clear();
  }
}

final pointsHistoryBloc = PointsHistoryBloc();
