import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/ui/pages/notification_screen.dart';

import '../models/task.dart';

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

//
  initializeNotification() async {
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));
    //this for android settings
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');
//this for Ios settings
    const IOSInitializationSettings initializationSettingsDarwin =
    IOSInitializationSettings(
    );
//this for create setting for both platform
    var initSetting = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);


    await flutterLocalNotificationsPlugin.initialize(
        initSetting, onSelectNotification: (String? payload) async {
      selectNotification(payload!);
    }).
    then((_) =>
    {
      debugPrint('initialize Notification : Success')
    }).catchError((Object error) {
      debugPrint('Error : $error');
    });
  }




  Future selectNotification(String payload) async {
    print('notification payload :$payload');
    await Get.to(NotificationScreen(payload: payload));
  }
//display notification
  displayNotification({required String title, required String body}) async {
    const androidDetail = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        'your channel description',
        priority: Priority.high,
        showWhen: false
    );

    const iosDetail = IOSNotificationDetails();
    const noticeDetail = NotificationDetails(
      iOS: iosDetail,
      android: androidDetail,
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, noticeDetail,payload: 'item x');
  }



scheduledNotification()async{
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'title',
    'body',
    tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    const NotificationDetails(
      android:AndroidNotificationDetails( 'your channel id',
          'your channel name',
          'your channel description',
          priority: Priority.high,
          showWhen: false),
    ),
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}


}

