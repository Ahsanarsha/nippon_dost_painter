import 'package:nippon_dost/resources/repoitory.dart';

class LoginBloc {
  final _repository = Repository();
  var _loginReq;
  var _phoneNumber;


  dynamic get loginModel => _loginReq;
  dynamic get phoneNumber => _phoneNumber;

  setPhoneNumber(String primaryNumber){
    _phoneNumber = primaryNumber;
  }

  loginRequest(String primaryNumber) async {
    dynamic loginModel = await _repository.sendLoginRequest(primaryNumber);
    _loginReq = loginModel;
  }



  dispose() {
    _loginReq.close();
    _phoneNumber.close();
  }
}

final loginBloc = LoginBloc();
