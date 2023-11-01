
import 'package:nippon_dost/resources/repoitory.dart';

class OtpBloc {
  final _repository = Repository();
  var _otpReq;

  dynamic get otpModel {
    return _otpReq;
  }

  otpVerifyRequest(String primaryNumber, String otp) async {
    dynamic _otpModel = await _repository.sendOtpRequest(primaryNumber, otp);
    _otpReq = _otpModel;
  }

  dispose() {
    _otpReq.close();
  }
}

final bloc = OtpBloc();
