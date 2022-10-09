import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/pages/notification_screen.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

import 'controllers/task_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: buildAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _addTaskBar(),
              _addDateBar(),
              const SizedBox(
                height: 6,
              ),
              _showTasks(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() =>
      AppBar(
        leading: IconButton(
          onPressed: () => ThemeServices().switchTheme(),
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined,
            size: 24,
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 18,
          ),
          SizedBox(
            width: 18,
          )
        ],
      );

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: subHeadingStyle,
              )
            ],
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () async {
                await Get.to(() => const AddTaskPage());
                _taskController.getTask();
              }),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 20),
      child: DatePicker(
        DateTime.now(),
        width: 60,
        height: 100,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        deactivatedColor: Colors.white,
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey)),
        initialSelectedDate: _selectDate,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 22, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey)),
        onDateChange: (newDate) {
          setState(() {
            _selectDate = newDate;
          });
        },
      ),
    );
  }

  _showTasks() {
    return _noTaskMsg();
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 2000),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction:SizeConfig.orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
              children: [
                SizeConfig.orientation == Orientation.landscape ?const SizedBox(
                    height: 6): const SizedBox(height:220 ,),
                SvgPicture.asset(
                  'assets/images/task.svg',
                  height: 90,
                  semanticsLabel: 'Task',
                  color: primaryClr.withOpacity(0.5),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text(
                    'You do not have any tasks yet!\n Add new tasks to make your days productive.',
                    style: subTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizeConfig.orientation == Orientation.landscape ?const SizedBox(
                    height: 120): const SizedBox(height:180 ,),
              ],
            ),
          ),
        )
      ],
    );
  }
}
