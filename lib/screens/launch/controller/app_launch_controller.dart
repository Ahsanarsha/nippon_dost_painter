import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/resources/cache_manager.dart';
import 'package:nippon_dost/resources/models/pormotional_image_model.dart';
import 'package:nippon_dost/resources/repoitory.dart';
import 'package:nippon_dost/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:nippon_dost/screens/gift_slab/bloc/gift_bloc.dart';
import 'package:nippon_dost/screens/history/bloc/cash_history_bloc.dart';
import 'package:nippon_dost/screens/history/bloc/order_scan_history_bloc.dart';
import 'package:nippon_dost/screens/history/bloc/points_history_bloc.dart';
import 'package:nippon_dost/screens/profile/bloc/profile_bloc.dart';
import 'package:nippon_dost/utils/app_translation.dart';

import 'package:nippon_dost/utils/promotion_banner.dart';

class AppLaunchController extends GetxController with CacheManager {
  RxBool isBanner = LoadBanner.bannerX().obs;
  RxBool isLogged = false.obs;
  RxBool initApp = false.obs;

  //to check language
  RxString lang =
      AppTranslation.langs[AppTranslation.locales.indexOf(Get.locale!)].obs;
  final _repository = Repository();

  // var promotionalImage = 'assets/images/promotion.png';
  var promotionalImage = ''.obs;
  var networkImageAvailable = false.obs;
  var networkImageURL = ''.obs;

  void change() {
    isBanner.value = false;
  }

  getPromotionalImage() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var promotionalImageResponse =
            await _repository.sendPromotionalImageRequest();
        if (promotionalImageResponse.success) {
          if (promotionalImageResponse.data.bannerImg != null) {
            networkImageURL.value = promotionalImageResponse.data.bannerImg;
            closePopUp();
          } else {
            change();
          }
        } else {
          change();
        }
      } else {
        change();
      }
    } on SocketException catch (_) {
      change();
    }

    //language check
    checkLanguage();
  }

  // gotoSplash(){
  //   Get.to(()=>SplashScreen());
  // }

  checkLanguage() {
    String? response = getLanguage();
    if (response != null) {
      AppTranslation().changeLocale(response);
      print('language read :' + response);
      lang.value = response;
    }
  }

  void closePopUp() {
    Timer(Duration(seconds: 5), () {
      print('timer closed');
      //Close Banner after some seconds
      isBanner.value = false;
    });
  }

  void checkLoginStatus() async {
    final token = getToken();
    if (token != null) {
      await validateToken().then((value) => isLogged.value = value);
    }
    // checkLanguage();
  }

  Future<bool> validateToken() async {
    await dashboardBloc.dashboardRequest();
    bool res = dashboardBloc.dashboardData.success;
    return res;
  }

  Future<bool> initializeApp() async {
    appBarPage = '';
    if (!initApp.value) {
      await dashboardBloc.dashboardRequest();
      await giftSlabBloc.giftSlabRequest();
      await profileBloc.profileRequest();
      //for remaining history API's
      // await pointsHistoryBloc.pointsHistoryRequest();
      // await cashHistoryBloc.cashHistoryRequest();
      await checkLanguage();
      initApp.value = true;
    }
    return true;

    // await orderScanHistoryBloc.orderScanHistoryRequest();
    // await orderScanHistoryBloc.orderScanHistoryRequest();
  }
}
