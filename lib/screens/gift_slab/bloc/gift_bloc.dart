import 'package:nippon_dost/resources/repoitory.dart';

class GiftSlabBloc {
  final _repository = Repository();
  var _giftReq;

  dynamic get giftData => _giftReq;

  giftSlabRequest() async {
    dynamic giftModel = await _repository.sendGiftRequest();
    _giftReq = giftModel;
  }

  dispose() {
    _giftReq.close();
  }
}

final giftSlabBloc = GiftSlabBloc();
