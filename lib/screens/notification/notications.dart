import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nippon_dost/components/navbar.dart';
import 'package:nippon_dost/models/my_notification_model.dart';
import 'package:nippon_dost/resources/models/notication_mdel.dart';
import 'package:nippon_dost/components/app_bar.dart';
import 'package:nippon_dost/screens/app_widgets/screen_banner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/screens/notification/notification_service.dart';
import 'package:nippon_dost/services/notification_sp_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notifications extends StatefulWidget {
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<MyNotificationModel> notificationsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();
  }
  getNotifications()async{
    notificationsList=await NotificationSpServices().getAllNotificationsFromSp();
    notificationsList.sort((a,b) => b.time.compareTo(a.time));
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: mainAppBar,
      //Bottom bar not required here
      // bottomNavigationBar: NavBar(),
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          ScreenBanner(bannerText: 'notifications'.tr),
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
              // child: Container(
              //   color: Colors.transparent,
              //   width: Get.width,
              //   child: Center(
              //     child: Text(
              //       'Coming Soon!',
              //       style: TextStyle(
              //         fontSize: 25.sm,
              //         color: Colors.indigo.shade600,
              //       ),
              //     ),
              //   ),
              // ),
              child:notificationsList.isEmpty? Center(child: Text("No Notifications found"),):
              ListView.builder(
                itemCount: notificationsList.length,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.05.sw, vertical: 0.02.sh),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start  ,
                      children: [
                        Text(
                          '${notificationsList[index].title}',
                          style: TextStyle(
                            color: Color(0xFF7C7C7C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text(
                          '${notificationsList[index].body}',
                          style: TextStyle(
                            color: Color(0xFF7C7C7C),
                            fontSize: 14.sm,
                          ),
                        ),const SizedBox(height: 5,),
                        Row(mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              (notificationsList[index].time.day==DateTime.now().day&&
                                  notificationsList[index].time.month==DateTime.now().month&&
                                  notificationsList[index].time.year==DateTime.now().year?"Today at ":"" )+
                                  DateFormat(
                                      notificationsList[index].time.day==DateTime.now().day&&
                                          notificationsList[index].time.month==DateTime.now().month&&
                                          notificationsList[index].time.year==DateTime.now().year
                                          ? "hh:mm aa" :
                                      notificationsList[index].time.year!=DateTime.now().year? "dd MMM yyyy hh:mm aa" :
                                      "dd MMM hh:mm aa")
                                      .format(notificationsList[index].time),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF7C7C7C),
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
                // separatorBuilder: (ctx, index) {
                //   return _divider();
                // },
              ),
            ),
          ),
          // TextButton(onPressed: ()async{
          //   SharedPreferences pref = await SharedPreferences.getInstance();
          //   pref.remove("all_notifications");
          // }, child: Text("TAP ME")),
        ],
      ),
    ), onWillPop: ()async{
      appBarPage = '';
      return true;
    });
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
