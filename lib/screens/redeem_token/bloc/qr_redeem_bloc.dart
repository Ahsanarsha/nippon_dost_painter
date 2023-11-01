import 'package:nippon_dost/resources/repoitory.dart';

class QrRedeemBloc {
  final _repository = Repository();
  var _qrRedeemReq;

  dynamic get qrRedeemResponse => _qrRedeemReq;

  qrRedeemRequest(List<int> qrIds) async {
    dynamic qrRedeemModel = await _repository.sendQrRedeemRequest(qrIds);
    _qrRedeemReq = qrRedeemModel;
  }

  dispose() {
    _qrRedeemReq.close();
  }
}

final qrRedeemBloc = QrRedeemBloc();
