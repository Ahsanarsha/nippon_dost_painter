import 'dart:convert';
import 'dart:developer';

import 'package:nippon_dost/models/my_notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSpServices{
  final String key ="all_notifications";
  Future<void> saveANotificationsToSp(MyNotificationModel notification)async{
    print("SAVING NOTIFICATION");
    SharedPreferences pref =await SharedPreferences.getInstance();
    List<Map<String,dynamic>> tempMap=[];
    List<MyNotificationModel> allNotifications = await getAllNotificationsFromSp();
    allNotifications.forEach((element) {
      tempMap.add(element.toJson());
    });
    tempMap.add(notification.toJson());
    pref.setString(key, tempMap.toString());
  }

  Future<List<MyNotificationModel>> getAllNotificationsFromSp()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    List<MyNotificationModel> temp=[];
    try{
      if (pref.containsKey(key)) {
        final String cont = pref.getString(key) ?? "";
        log(cont.toString());
          List<String> tem= cont.contains("},")?cont.split("},"):cont.split("}");
        for (var items in tem) {
          temp.add(MyNotificationModel.fromJson(
              getAllNotificationsMapItem(items)));
        }
      }
    }catch(e){
      print(e);
    }
    return temp;
  }

  Map<String,dynamic> getAllNotificationsMapItem(String str){
    Map<String,dynamic> tempMap={};
    String temp = str.replaceAll("[", "").replaceAll("]", "").replaceAll("{", "").replaceAll("}", "");
    try{
      // print(temp+" <<<AASDASD");
      temp.split(",").forEach((element) {
        tempMap.putIfAbsent(
            element.split(": ")[0].trim(), () => element.split(": ")[1].trim());
      });
    }catch(e){}
    return tempMap;
  }
}