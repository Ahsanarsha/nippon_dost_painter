import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nippon_dost/controllers/text_field_controller.dart';
import 'package:nippon_dost/packages/simple_countdown/countdown.dart';
import 'package:nippon_dost/packages/otp_text_field/otp_text_field.dart';
import 'package:nippon_dost/resources/api_provider.dart';
import 'package:nippon_dost/resources/cache_manager.dart';
import 'package:nippon_dost/resources/models/login_model.dart';
import 'package:nippon_dost/resources/models/otp_model.dart';
import 'package:nippon_dost/screens/app_widgets/loading_widget.dart';
import 'package:nippon_dost/screens/launch/controller/app_launch_controller.dart';
import 'package:nippon_dost/screens/login/bloc/login_bloc.dart';
import 'package:nippon_dost/screens/verification/bloc/otp_bloc.dart';
import 'package:nippon_dost/screens/verification/controller/otp_controller.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';

class OtpVerification extends StatelessWidget with CacheManager {
   OtpVerification({this.loginModel, Key? key}) : super(key: key);

  final LoginModel? loginModel;
  String otp = '';


   @override
  Widget build(BuildContext context) {
    // String myOTP = '';
    var showTimer = true.obs;

    CountdownController _cdc = CountdownController(autoStart: true);
    OtpController _oc = Get.put(OtpController());
    AppLaunchController _alc = Get.put(AppLaunchController());
    TextFieldController _tfc = Get.put(TextFieldController());
    LoginModel loginModel = loginBloc.loginModel;

    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   Get.snackbar(
    //   'otp'.tr,
    //   '${loginModel.data}',
    //   backgroundColor: main_color,
    //   colorText: Colors.white,
    //   snackPosition: SnackPosition.BOTTOM,
    //   duration: Duration(seconds: 5),
    // );
    // });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.loose,
        children: [
          Image.asset(
            top_bg,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 0.20.sh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(otp_title),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.20.sw, vertical: 0.02.sh),
                      child: Text(
                        'enter_verification_code'.tr,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: OtpTextField(
                        autoFocus: false,
                        focusedBorderColor: main_color,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        numberOfFields: 4,
                        fieldWidth: 0.12.sw,
                        textStyle: TextStyle(
                          fontSize: 18.sm,
                        ),
                        borderColor: Colors.grey[350]!,
                        showFieldAsBox: true,
                        borderWidth: 2.0,
                        onSubmit: (_otp) {
                          otp = _otp;
                        },
                        onCodeChanged: (_otp) {
                          // print('change called');
                          // print(otp.length.toString());
                          // otp = _otp;
                          // print('after assigning');
                          // print(otp.length.toString());
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(top: 0.04.sh),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: shadow_color.withOpacity(0.18),
                            blurRadius: 10,
                            offset: Offset(0.42, 7.99), // Shadow position
                          ),
                        ],
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: main_color,
                          padding: EdgeInsets.symmetric(vertical: 0.015.sh),
                          fixedSize: Size.fromWidth(0.60.sw),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sm),
                          ),
                        ),
                        child: Text(
                          'verify'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sm,
                          ),
                        ),
                        onPressed: () async {
                          print('click with otp '+otp);
                          FocusScope.of(context).unfocus();
                          if (otp.length == 4) {
                            showTimer.value = false;
                            _cdc.pause();
                            _cdc.setOnPause(() {
                            });
                            loadingWidget(context);
                            await bloc.otpVerifyRequest(
                                _tfc.tec.text.toString(), otp);
                            if (bloc.otpModel.success != true) {
                              print("got success false");
                              Get.back();
                              print('went back');
                              _oc.showSnackBar('sorry'.tr, 'otp_not_matched'.tr);
                            } else {
                              OtpModel _otpModel = bloc.otpModel;
                              await saveId(
                                  _otpModel.data.painter.id.toString());
                              await saveNumber(_otpModel
                                  .data.painter.primaryNumber
                                  .toString());
                              await saveToken(_otpModel.data.token.toString());

                              FirebaseMessaging _firebaseMessaging = await FirebaseMessaging.instance;

                              _firebaseMessaging.getToken().then((value) async {
                                print('SAVING fcm token: $value');
                                saveFCM(value);

                              });

                              ///To load dashboard Data
                              await _alc.initializeApp();
                              print('going next after init data from OTP page');
                               _oc.sendFirebaseToken();
                               Get.back();
                              _oc.toggle(false, true);
                            }
                          } else {
                            print('otp data');
                            print('length '+otp.length.toString());
                            print(otp);
                            _oc.showSnackBar(
                                'attention'.tr, 'otp_required'.tr);
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0.01.sh),
                      ///being commented as it was causing overflow issues
                      // padding: EdgeInsets.symmetric(horizontal: 0.30.sw),
                      child: Obx(()=> showTimer.value? Countdown(
                        controller: _cdc,
                        seconds: 60,
                        build: (ctx, time) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                               InkWell(
                                  onTap: time.toInt() == 0 ? () async {
                                    // await loginBloc.loginRequest(loginBloc.phoneNumber);
                                  } : null,
                                  child: Text(
                                    'resend_code'.tr,
                                    // 'Resend Code',
                                    style: TextStyle(
                                        color: main_color,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              Visibility(
                                  visible: time.toInt() != 0,
                                  child: Row(
                                    children: [
                                      Text(
                                        // ' in 00:${time.toInt().toString()}',
                                        'in'.tr,
                                        style: TextStyle(color: Color(0xFF6F6F6F)),
                                      ),
                                      Text(
                                        // ' in 00:${time.toInt().toString()}',
                                        ' 00:${time.toInt().toString()}',
                                        style: TextStyle(color: Color(0xFF6F6F6F)),
                                      ),

                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                        interval: Duration(seconds: 1),
                        onFinished: () {
                          showTimer.value = false;
                        },
                      ):Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        InkWell(
                          onTap: () async {
                            await loginBloc.loginRequest(loginBloc.phoneNumber);
                            showTimer.value = true;
                          },
                          child: Text(
                            'resend_code'.tr,
                            // 'Resend Code',
                            style: TextStyle(
                                color: main_color,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(nippon_paint_logo),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
