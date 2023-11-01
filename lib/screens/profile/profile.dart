import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nippon_dost/resources/models/error_model.dart';
import 'package:nippon_dost/resources/models/profile_model.dart';
import 'package:nippon_dost/resources/repoitory.dart';
import 'package:nippon_dost/screens/app_widgets/loading_widget.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
import 'bloc/profile_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  RxList<ProfileData> profileData = <ProfileData>[].obs;
  var isImageAvailable = false.obs;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  final _repository = Repository();

  void getProfileData() {
    ProfileModel pm = profileBloc.profileData;
    profileData.value = pm.data;
  }



  ///To Pick an image from phone Storage
  handleImagePicker() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!.path.isNotEmpty)
    handleImageUpload();
  }

  ///To upload selected image to database
  handleImageUpload() async {
    final bytes = (await image!.readAsBytes()).lengthInBytes;
    if(bytes>2000){
      isImageAvailable.value = false;
      loadingWidget(Get.context!);
      dynamic imageResponseModel =
      await _repository.sendImageSubmitRequest(image!.path);
      print(imageResponseModel.toString());
      if(imageResponseModel.success){
        profileBloc.updateProfileImage(image!.path);
      }

      ///After getting response
      Get.back();
      if (imageResponseModel.success) {
        image!.path.isNotEmpty
            ? isImageAvailable.value = true
            : isImageAvailable.value = false;
        Get.snackbar(
          'success'.tr,
          'image_updated'.tr,
          backgroundColor: main_color,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          'Sorry',
          imageResponseModel.message,
          backgroundColor: main_color,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
        );
      }
    }else{
      isImageAvailable.value = false;
      Get.snackbar(
        'sorry'.tr,
        'image_size_large'.tr,
        backgroundColor: main_color,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }

  }
}

class Profile extends GetResponsiveView<ProfileController> {
  @override
  Widget builder() {
    ProfileController _pfc = Get.put(ProfileController());
    _pfc.getProfileData();

    return Column(
      children: <Widget>[
        Container(
          width: 1.0.sw,
          height: 0.30.sh,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 0.30.sw,
                child: Stack(
                  children: <Widget>[
                    Obx(() => controller.isImageAvailable.value
                        ? CircleAvatar(
                            backgroundImage:
                                Image.file(File(controller.image!.path)).image,
                            radius: 0.15.sw,
                          )
                        : CircleAvatar(
                            // radius: 20,
                            radius: 0.15.sw,
                            child: _pfc.profileData[0].painterImg != null
                                ? CachedNetworkImage(
                                    imageUrl: _pfc.profileData[0].painterImg!,
                                    fit: BoxFit.fill,
                                    width: Get.width,
                                    height: Get.height,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                    placeholder: (context, url) => Container(),
                                    errorWidget: (context, url, error) =>
                                        Container())
                                : Image.asset(user_image),
                            // radius: 0.15.sw,
                          )),
                    Positioned(
                      bottom: -5.sp,
                      right: -25.sp,
                      child: RawMaterialButton(
                        onPressed: () => controller.handleImagePicker(),
                        // elevation: 2.0,
                        child: Image.asset(edit_image),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 0.01.sh),
                child: Text(
                  _pfc.profileData[0].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(
              horizontal: 0.04.sw,
              vertical: 0.02.sh,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF3F6FD),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF707070),
                  blurRadius: 6,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                _listTile(
                  account_image,
                  _pfc.profileData[0].name,
                ),
                _divider(),
                _listTile(
                  mobileNo_image,
                  _pfc.profileData[0].primaryNumber,
                ),
                _divider(),
                _listTile(
                  address_image,
                  _pfc.profileData[0].address,
                ),
                _divider(),
                _listTile(
                  cnic_image,
                  _pfc.profileData[0].cnic,
                ),
                _divider(),
                _listTile(
                  date_image,
                  formattedDate(_pfc.profileData[0].createdAt),
                ),
              ],
            )),
      ],
    );
  }

  Widget _listTile(String img, String txt) {
    return ListTile(
      leading: Image.asset(img),
      title: Text(txt),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.10.sw),
      child: Divider(
        thickness: 1,
        height: 2,
        color: Color(0xFFCFDBFF),
      ),
    );
  }

  String formattedDate(String createdAt) {
    DateTime dateTime = DateTime.parse(createdAt);
    String formatDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formatDate;
  }
}
