import 'package:nippon_dost/resources/models/profile_model.dart';
import 'package:nippon_dost/resources/repoitory.dart';

class ProfileBloc {
  final _repository = Repository();
  var _profileReq;

  dynamic get profileData => _profileReq;

  profileRequest() async {
    dynamic profileModel = await _repository.sendProfileRequest();
    _profileReq = profileModel;

  }

  updateProfileImage(String imagePath){
    //Update value of single variable
    ProfileModel profileModel = _profileReq;
    profileModel.data[0].painterImg = imagePath;
    _profileReq = profileModel;
  }

  dispose() {
    _profileReq.close();
  }
}

final profileBloc = ProfileBloc();
