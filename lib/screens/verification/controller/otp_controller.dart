import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/resources/models/FCM%20Response%20Model.dart';
import 'package:nippon_dost/resources/repoitory.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class OtpController extends GetxController {
  RxBool isVerification = true.obs;
  RxBool isVerified = false.obs;

  final _repository = Repository();


  void toggle(bool vf, bool vd) {
    // isVerification.value = vf;
    // isVerified.value = vd;
    // Get.offAllNamed(Routes.AppInit);
    Get.offAllNamed(Routes.Home);
  }

  void showSnackBar(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: main_color,
      colorText: Colors.white,
    );
  }

  //To Send Firebase Token to API
  void sendFirebaseToken()async{
    print('going to send firebase Token');
    String? token = await getFirebaseToken();
    await _repository.sendFirebaseTokenRequest(token!);
  }

  //To get firebase Token
  Future<String?> getFirebaseToken()async{
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  }




