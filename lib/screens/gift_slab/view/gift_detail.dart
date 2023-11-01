import 'dart:io';
import 'package:html/parser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/resources/models/gift_details_model.dart';
import 'package:nippon_dost/resources/repoitory.dart';
import 'package:nippon_dost/screens/gift_slab/controller/gift_controller.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class GiftDetailController extends GetxController {
  GiftDetailsModel? giftDetailsModel;
  final _repository = Repository();
  var isLoading = false.obs;
  String errorText = '';
  String description = '';

  @override
  void onInit() {
    // TODO: implement onInit
    getGiftDetails();
    super.onInit();
  }

  //to convert HTML text to string
  String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  void getGiftDetails() async {
    GiftController _gc = Get.put(GiftController());
    int index = _gc.selectedIndex;
    isLoading.value = true;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var response = await _repository.sendGiftDetailsRequest(index);
        if (response.success) {
          isLoading.value = false;
          giftDetailsModel = response;
          description =
              parseHtmlString(giftDetailsModel!.data.description);
        } else {
          isLoading.value = false;
          errorText = response.message;
        }
      } else {
        isLoading.value = false;
      }
    } on SocketException catch (_) {
      Get.snackbar(
        'sorry'.tr,
        'something_went_wrong'.tr,
        backgroundColor: main_color,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      isLoading.value = false;
      Get.snackbar(
        'sorry'.tr,
        'something_went_wrong'.tr,
        backgroundColor: main_color,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }
}

class GiftDetail extends GetResponsiveView<GiftDetailController> {
  GiftDetailController _gdc = Get.put(GiftDetailController());
  @override
  Widget builder() {
    return Scaffold(
      appBar: mainAppBar,
      // bottomNavigationBar: NavBar(),
      body: ListView(
        // direction: Axis.vertical,
        children: [
          Container(
            width: 1.0.sw,
            // height: 0.25.sh,
            padding: EdgeInsets.symmetric(
              vertical: 0.04.sh,
              horizontal: 0.02.sw,
            ),
            decoration: BoxDecoration(
              color: top_banner_color,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  top_banner_gradient_begin, //Begin
                  top_banner_gradient_end, //End
                ],
              ),
            ),
            child: Obx(() => _gdc.isLoading.value
                ? Container()
                // loadingWidget(Get.context!)
                : _gdc.giftDetailsModel != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _text(_gdc.giftDetailsModel!.data.giftPoint,
                              Color(0xFFA3BEDF), 15.sm, FontWeight.normal),
                          _text(_gdc.giftDetailsModel!.data.name, Colors.white,
                              22.sm, FontWeight.bold),
                          _text(
                              'delivery_days'.tr +
                                  ' ${_gdc.giftDetailsModel!.data.deliveryDays}',
                              Colors.white,
                              15.sm,
                              FontWeight.bold),
                          _text(
                              'Gift Value'.tr +
                                  ' ${_gdc.giftDetailsModel!.data.giftValue}',
                              Colors.white,
                              15.sm,
                              FontWeight.bold),
                        ],
                      )
                    : Container()),
          ),
          //Image Container
          Container(
              margin: EdgeInsets.symmetric(vertical: 0.032.sh),
              child: Obx(
                () => _gdc.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : _gdc.giftDetailsModel != null
                        ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: _gdc.giftDetailsModel!.data.slabImg,
                                    fit: BoxFit.fitHeight,
                                    width: 0.80.sw,
                                    height: 0.20.sh,
                                    placeholder: (context, url) => Container(),
                                    errorWidget: (context, url, error) => Center(
                                      child: _text(
                                          'image_not_available'.tr,
                                          Color(0xFFA3BEDF),
                                          15.sm,
                                          FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                    width: 1.0.sw,
                                    // height: 0.25.sh,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 0.04.sh,
                                      horizontal: 0.08.sw,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Description', style:  TextStyle(color: Color(0xff03428D), fontWeight: FontWeight.bold),),
                                        SizedBox(height: 0.01.sh,),
                                        Text(_gdc.description,
                                          overflow: TextOverflow.fade,
                                          // maxLines: 12,
                                          textAlign: TextAlign.left, style:  TextStyle(color: Color(0xff03428D), fontWeight: FontWeight.bold),),
                                      ],),),
                              )

                            ],
                          )
                        : Center(
                            child: _text(_gdc.errorText, Color(0xFFA3BEDF),
                                15.sm, FontWeight.normal),
                          ),
              )),
        ],
      ),
    );
  }

  Widget _text(
    String text,
    Color color,
    double fontSize,
    FontWeight fontWeight,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0.05.sw,
        top: 0.01.sh,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
