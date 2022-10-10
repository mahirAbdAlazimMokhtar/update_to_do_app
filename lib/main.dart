import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/theme.dart';



import 'home_screen.dart';

Future<void> main() async {


  runApp(const ToDoApp());
  WidgetsFlutterBinding.ensureInitialized();
  //await NotifyHelper().initializeNotification();
}


class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.themeLight,
      //this static variable you don't need to () to access the var just use name of class . name of var
      darkTheme: Themes.themeDark,
      //this is a getter ==> use () to Access the variable
      themeMode: ThemeServices().theme,
      home:const HomeScreen(),
    );
  }
}
