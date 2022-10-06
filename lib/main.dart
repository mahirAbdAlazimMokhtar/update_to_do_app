import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/ui/pages/notification_screen.dart';

import 'home_screen.dart';

void main() => runApp(const ToDoApp());


class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.teal
      ),
      home:const NotificationScreen(payload: 'hi this is payload | mahir',),
    );
  }
}
