import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/components/navbar.dart';
import 'package:nippon_dost/controllers/navbar_controller.dart';
import 'package:nippon_dost/resources/repoitory.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/screens/app_widgets/general_button.dart';
import 'package:nippon_dost/screens/app_widgets/loading_widget.dart';
import 'package:nippon_dost/screens/app_widgets/screen_banner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';

class SupportChatController extends GetxController {
  var noteTextController = TextEditingController();
  FocusNode noteNode = FocusNode();
  var isSendingNote = false.obs;
  var isFileAvailable = false.obs;
  File? file;

  void pickFile() async {

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        file = File(result.files.single.path!);
        isFileAvailable.value = true;
        print(file);
      } else {
        print('file picking canceled');
        // User canceled the picker
      }
    } catch (e) {
      print('got an error: ' + e.toString());
    }
  }
}

class SupportChat extends GetResponsiveView<SupportChatController> {
  @override
  Widget build(BuildContext context) {
    SupportChatController _sc = Get.put(SupportChatController());
    NavbarController _nbc = Get.put(NavbarController());
    final _repository = Repository();

    return WillPopScope(
        child: Scaffold(
          appBar: mainAppBar,
          //bottom nav disabled
          // bottomNavigationBar: NavBar(),
          resizeToAvoidBottomInset: false,
          body: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              ScreenBanner(bannerText: 'settings'.tr),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0.04.sw,
                  vertical: 0.02.sh,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: order_scan_button_bg,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.16),
                            blurRadius: 6,
                            offset: Offset(0, 3), // Shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          _textArea(
                              controller: controller.noteTextController,
                              node: controller.noteNode),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Obx(() => controller.isFileAvailable.value
                                  ? Text('File Selected')
                                  : Container()),
                              // IconButton(
                              //   onPressed: () {
                              //     controller.pickFile();
                              //   },
                              //   icon: ImageIcon(
                              //     AssetImage(paper_clip),
                              //   ),
                              // ),
                              // IconButton(
                              //   onPressed: () {
                              //     print('Tap');
                              //   },
                              //   icon: ImageIcon(
                              //     AssetImage(microphone),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0.03.sh),
                      child: GeneralButton(
                          btnText: 'send'.tr,
                          onTap: () async {
                            if(controller.noteTextController.text.trim().isNotEmpty){
                              loadingWidget(context);
                              controller.noteNode.unfocus();

                              ///Send note to the backend
                              dynamic noteResponseModel;
                              if (controller.file != null) {
                                noteResponseModel =
                                    await _repository.sendNoteSubmitRequest(
                                        controller.noteTextController.text,
                                        controller.file!.path,
                                        true);
                              } else {
                                noteResponseModel =
                                    await _repository.sendNoteSubmitRequest(
                                        controller.noteTextController.text,
                                        "",
                                        false);
                              }

                              ///After getting response
                              Get.back();
                              if (noteResponseModel.success) {
                                controller.noteTextController.clear();
                                controller.noteNode.unfocus();
                                Get.snackbar(
                                  'success'.tr,
                                  'note_uploaded'.tr,
                                  backgroundColor: main_color,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 3),
                                );
                              } else {
                                controller.noteNode.unfocus();
                                Get.snackbar(
                                  'something_went_wrong'.tr,
                                  'please_try_again'.tr,
                                  backgroundColor: main_color,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 3),
                                );
                              }
                            }
                          }),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.SupportHistory);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(0.02.sw),
                        child: Text(
                          'support_history'.tr,
                          style: TextStyle(color: main_color, fontSize: 12.sm),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onWillPop: () async {
          appBarPage = '';
          return true;
        });
  }

  Widget _textArea(
      {required TextEditingController controller, FocusNode? node}) {
    return TextField(
      focusNode: node ?? FocusNode(),
      controller: controller,
      minLines: 8,
      maxLines: 12,
      style: TextStyle(
        color: Color(0xFF00295A),
        fontSize: 14.sm,
      ),
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: 'write_note'.tr,
        contentPadding: EdgeInsets.all(0.04.sw),
        hintStyle: TextStyle(
          color: Color(0xFF00295A),
          fontSize: 14.sm,
        ),
      ),
    );
  }
}
