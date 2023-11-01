import 'dart:async';
import 'dart:developer';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nippon_dost/models/my_notification_model.dart';
import 'package:nippon_dost/resources/api_provider.dart';
import 'package:nippon_dost/screens/notification/notications.dart';
import 'package:nippon_dost/services/notification_sp_services.dart';

class NotificationService {
  static String serverKey = "AAAAQk4PX7k:APA91bEeLsm02vqpJg2zaLv0m1vRcXAFOWsAy62TUQjZusO_vl2phiNO23pTiUuddeb9ryMkPt-b5fmMntBEtA8wYUE7uAt5U95XEobQHRGSj4WJ1VjrF3oUWuEU7lsmNFfnP6lEvuHO";
  StreamSubscription? _subscription;

  AndroidNotificationChannel? channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // NotificationContent? notificationContent;

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  subCribedTopics(topic)async {
    print("Subcribed Called");
    FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  NotificationPop() {
    showNotification("","");
    // getNotification();
  }

  setFcmToken()async{
    FirebaseMessaging _firebaseMessaging = await FirebaseMessaging.instance;

    final fcm = GetStorage();
    _firebaseMessaging.getToken().then((value) async {
      print('fcm token: $value');
      fcm.write('fcm', value);
    });
  }
  initNotification()async{
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('background');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    var initializationSettings = InitializationSettings( android:
    initializationSettingsAndroid,iOS:  initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {});
  }
  Future<void> backgroundMessageHandler(RemoteMessage message) async {
    print("ON MESSAGE LISTENER <<<<<<<<<<<<<<<<");
    await showNotification(message.notification!.title!,
        message.notification!.body!);
    NotificationSpServices().saveANotificationsToSp(MyNotificationModel(
      body: message.notification!.body!,
     title: message.notification!.title!,
       time: DateTime.now(),
    ));
  }

  showNotification(String title,String body) async {
    if (!kIsWeb) {
      var androidPlatformChannelSpecifics =const AndroidNotificationDetails(
          'channel_ID', 'channel name',
          importance: Importance.max,
          playSound: true,
          showProgress: true,
          priority: Priority.high,
          ticker: 'test ticker');

      var iOSChannelSpecifics =const IOSNotificationDetails(
        badgeNumber: 1,
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
      );
      var platformChannelSpecifics = NotificationDetails(
          android:
          androidPlatformChannelSpecifics,iOS:  iOSChannelSpecifics);
      await flutterLocalNotificationsPlugin
          .show(0, title, body, platformChannelSpecifics, payload: 'NIPON');
    }
  }



  // getNotification(BuildContext context) async {
  //   channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     importance: Importance.max,
  //   );
  //   FirebaseMessaging.instance
  //       .getInitialMessage()
  //       .then((RemoteMessage? message) {
  //     if (message != null) {
  //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => Notifications(),
  //           settings: RouteSettings(name: "main")));
  //       print('A new onMessageOpenedApp event was published!!!!1');
  //       // Navigator.pushNamed(navigatorKey.currentState!.context, MessageTabs.routeName);
  //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(index: 4)));
  //     }
  //   });
  //
  //
  //   _subscription =   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     AwesomeNotifications().initialize(
  //         'resource://drawable/app_icon',
  //       [
  //         NotificationChannel(
  //             channelGroupKey: 'basic_channel_group',
  //             channelKey: 'call_channel', /* same name */
  //             channelName: 'Basic notifications',
  //             channelDescription: 'Notification channel for basic tests',
  //             defaultColor: Color(0xFF9D50DD),
  //             ledColor: Colors.white)
  //       ],
  //     );
  //     print("<<<${message.data}");
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null && !kIsWeb) {
  //       notificationContent  = NotificationContent(
  //           id: 10,
  //           channelKey: 'call_channel',
  //           title:notification.title,
  //         body: notification.body,
  //         bigPicture: message.data['image'],
  //         // icon:
  //       );
  //       if (notificationContent != null) {
  //         AwesomeNotifications().createNotification(content: notificationContent!);
  //       }
  //       // flutterLocalNotificationsPlugin!.show(
  //       //   notification.hashCode,
  //       //   notification.title,
  //       //   notification.android !=  null ? notification.android!.imageUrl :
  //       //   notification.body,
  //       //   NotificationDetails(
  //       //     android: AndroidNotificationDetails(
  //       //       channel!.id,
  //       //       channel!.name,
  //       //       channelDescription: channel!.description,
  //       //
  //       //       icon: 'app_icon',
  //       //     ),
  //       //   ),
  //       // );
  //     }
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (BuildContext context) => Notifications(),
  //         settings: RouteSettings(name: "main")));
  //     print(message.data.toString());
  //     print('A new onMessageOpenedApp event was published!2');
  //   });
  // }
}
