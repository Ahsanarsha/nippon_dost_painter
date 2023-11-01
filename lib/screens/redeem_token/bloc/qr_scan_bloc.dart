import 'package:nippon_dost/resources/repoitory.dart';

class QrScanBloc {
  final _repository = Repository();
  var _qrScanReq;

  dynamic get qrScanModel => _qrScanReq;

  qrScanRequest(String qrCode) async {
    dynamic qrScanModel = await _repository.sendQrScanRequest(qrCode);
    _qrScanReq = qrScanModel;
  }

  dispose() {
    _qrScanReq.close();
  }
}

final qrScanBloc = QrScanBloc();
