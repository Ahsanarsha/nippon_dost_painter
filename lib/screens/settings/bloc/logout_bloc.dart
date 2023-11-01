import 'package:nippon_dost/resources/cache_manager.dart';
import 'package:nippon_dost/resources/repoitory.dart';

class LogoutBloc with CacheManager {
  final _repository = Repository();
  var _logoutReq;


  dynamic get logoutModel {
    return _logoutReq;
  }

  logoutRequest() async {
    dynamic logoutModel = await _repository.sendLogoutRequest();
    _logoutReq = logoutModel;
    clearDB();
  }

  void clearDB() {
    removeId();
    removeNumber();
    removeToken();
  }

  dispose() {
    _logoutReq.close();
  }
}

final logoutBloc = LogoutBloc();
