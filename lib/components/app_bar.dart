import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nippon_dost/routes/app_pages.dart';
import 'package:nippon_dost/utils/app_colors.dart';
import 'package:nippon_dost/utils/app_images.dart';
 //to remember current page
String appBarPage  = '';
AppBar mainAppBar = AppBar(
  backgroundColor: secondary_color,
  foregroundColor: Colors.black,
  centerTitle: false,
  automaticallyImplyLeading: false,
  title: Padding(
    padding: EdgeInsets.only(top: 10),
    child: Container(
      width: Get.width * 0.80,
      height: Get.height * 0.10,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Image.asset(
          nippon_logo,
          fit: BoxFit.scaleDown,
        ),
      ),
    ),
  ),
  actions: <Widget>[
    IconButton(
      icon: Image.asset(question_circle),
      onPressed: () =>{
        if(appBarPage != 'support_chat'){
          if(appBarPage=='notifications' || appBarPage =='settings')
            Get.back(),
        Get.toNamed(Routes.SupportChat),
        appBarPage = 'support_chat',
      }

},
    ),
    IconButton(
      icon: Image.asset(settings),
      onPressed: () =>{
      if(appBarPage != 'settings'){
        if(appBarPage=='notifications' || appBarPage =='support_chat')
          Get.back(),
      Get.toNamed(Routes.Settings),
        appBarPage = 'settings',
      },
      }
    ),
    IconButton(
      icon: Image.asset(bell),
      onPressed: () =>{
      if(appBarPage != 'notifications'){
        if(appBarPage=='settings' || appBarPage =='support_chat')
          Get.back(),
        Get.toNamed(Routes.Notifications),
        appBarPage = 'notifications',
      }
      }
    ),
  ],
);






