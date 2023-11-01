import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nippon_dost/components/navbar.dart';
import 'package:nippon_dost/resources/models/support_history_model.dart';
import 'package:nippon_dost/resources/models/support_model.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/resources/repoitory.dart';
import 'package:nippon_dost/screens/app_widgets/screen_banner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/utils/app_colors.dart';

class SupportHistoryController extends GetxController {


  final _repository = Repository();
  var isLoading = false.obs;
  SupportHistoryModel? _supportHistoryModel;

  @override
  void onInit() {
    // TODO: implement onInit
    print("came in onInit");
    getSupportHistory();
    super.onInit();
  }



  void getSupportHistory()async{
    isLoading.value = true;
    print('get support history called');
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("going to call for gift details");
        var response =  await _repository.sendSupportHistoryRequest();
        print('got response from API');
        print(response);
        if(response.success){
          isLoading.value = false;
          _supportHistoryModel = response;
        }else
          isLoading.value = false;
      }else{
        isLoading.value = false;
      }
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.snackbar(
        'sorry'.tr,
        'something_went_wrong'.tr,
        backgroundColor: main_color,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      isLoading.value = false;
      Get.snackbar(
        'sorry'.tr,
        'something_went_wrong'.tr,
        backgroundColor: main_color,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    }
  }


  RxList<SupportModel> supportHistory = [
    SupportModel(
        ticketNo: '12345',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ………. view more',
        status: 'Close',
        date: '29/11/21',
        time: '11:00 pm'),
    SupportModel(
        ticketNo: '12345',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ………. view more',
        status: 'Close',
        date: '29/11/21',
        time: '11:00 pm'),
  ].obs;
}

class SupportHistory extends GetResponsiveView<SupportHistoryController> {
  @override
  Widget build(BuildContext context) {
    print("cam in build");
    SupportHistoryController _shc = Get.put(SupportHistoryController());

    return Scaffold(
      appBar: mainAppBar,
      // bottomNavigationBar: NavBar(),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          ScreenBanner(bannerText: 'support_history'.tr),
          Expanded(
            child: Container(
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
                    color: Color(0xFF000000).withOpacity(0.16),
                    blurRadius: 6,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Obx(()=> _shc.isLoading.value? Center(child: CircularProgressIndicator(),): _shc._supportHistoryModel!=null? ListView.separated(
                itemCount: _shc._supportHistoryModel!.data!.length,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  DateTime datetime = DateTime.parse(_shc._supportHistoryModel!.data![index].createdAt!);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 0.02.sh, left: 0.05.sw),
                        child: Text(
                          'Ticket No: ${_shc._supportHistoryModel!.data![index].ticketNo}',
                          style: TextStyle(
                            color: main_color,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sm,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.02.sh, left: 0.05.sw),
                        child: Text(
                          '${_shc._supportHistoryModel!.data![index].message}',
                          style: TextStyle(
                            color: Color(0xFF7C7C7C),
                            fontSize: 14.sm,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0.02.sh, left: 0.05.sw, bottom: 0.02.sh),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    color: main_color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sm,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 14.sm),
                                  child: Text(
                                    '${_shc._supportHistoryModel!.data![index].status}',
                                    style: TextStyle(
                                      color:
                                          _shc._supportHistoryModel!.data![index].status ==
                                                  'Close'
                                              ? Color(0xFF7EEB00)
                                              : Color(0xFFEBC400),
                                      fontSize: 14.sm,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 14.sm),
                              child: Text(
                                '${datetime.hour}:${datetime.minute}',
                                style: TextStyle(
                                  color: Color(0xFF9AA7BB),
                                  fontSize: 14.sm,
                                ),
                              ),
                            ),
                            // Text(
                            //   '${_shc.supportHistory[index].date}',
                            //   style: TextStyle(
                            //     color: Color(0xFF9AA7BB),
                            //     fontSize: 14.sm,
                            //   ),
                            // ),
                          ],
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (ctx, index) {
                  return _divider();
                },
              ):Center(child: Text(
                'data_not_available'.tr,
                style: TextStyle(color: main_color, fontSize: 12.sm),
              ),)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listTile(String txt) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.01.sh),
      child: ListTile(
        title: Text(
          txt,
          style: TextStyle(
            color: Color(0xFF00295A),
            fontSize: 14.sm,
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
      child: Divider(
        thickness: 1,
        height: 2,
        color: Color(0xFFCFDBFF),
      ),
    );
  }
}
