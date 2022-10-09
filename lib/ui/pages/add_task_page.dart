import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final DateTime _selectDate = DateTime.now();
  final String _startTime =
  DateFormat('hh:mm a').format(DateTime.now()).toString();
  final String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  final List<int> _remindList = [5, 15, 20, 25];
  int _selectRemind = 5;
  String _selectRepeat = 'None';
  final List<String> _repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];
  int _selectColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: buildAppBar(),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                Text(
                  'Add Task',
                  style: headingStyle,
                ),
                InputField(
                  title: 'Title',
                  hint: 'Enter your title',
                  controller: _titleController,
                ),
                InputField(
                  title: 'Note',
                  hint: 'Enter your note',
                  controller: _noteController,
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(_selectDate).toString(),
                  widget: IconButton(
                    icon: const Icon(
                      Icons.date_range_outlined, color: Colors.grey,),
                    onPressed: () {},
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.watch_later_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: _endTime,
                        widget: IconButton(
                          icon: const Icon(
                            Icons.watch_later_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                  title: 'Remind',
                  hint: '$_selectRemind minutes early',
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                        underline: Container(
                          height: 0,
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _selectRemind = int.parse(value!);
                          });
                        },
                        items: _remindList
                            .map<DropdownMenuItem<String>>(
                              (value) =>
                              DropdownMenuItem(
                                value: value.toString(),
                                child: Text(
                                  '$value',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                        )
                            .toList(),

                      ),
                      const SizedBox(width: 10,),
                    ],
                  ),
                ),
                InputField(
                  title: 'Repeat',
                  hint: _selectRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.grey,
                        style: subTitleStyle,
                        borderRadius: BorderRadius.circular(15),
                        underline: Container(
                          height: 0,
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _selectRepeat = value!;
                          });
                        },
                        items: _repeatList
                            .map(
                              (value) =>
                              DropdownMenuItem(
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                value: value,
                              ),
                        )
                            .toList(),
                      ),
                      const SizedBox(width: 10,)
                    ],
                  ),
                ),
                const SizedBox(height: 18,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumn(),
                    MyButton(
                        label: 'Create Task',
                        onTap: () {
                          Get.back();
                        }),
                  ],
                ),

              ],
            ),
          )),
    );
  }

  AppBar buildAppBar() => AppBar(
    leading: IconButton(
      onPressed: ()=> Get.back(),
      icon: const Icon(Icons.arrow_back_ios,size: 24,color: primaryClr,),
    ),
    elevation: 0,
    backgroundColor: context.theme.backgroundColor,
    actions: const [
      CircleAvatar(
        backgroundImage: AssetImage('assets/images/person.jpeg'),
        radius: 18,
      ),
      SizedBox(width: 18,)
    ],
  );



  Column buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: titleStyle),
        const SizedBox(height: 8,),
        Wrap(
          children: List.generate(
            3,
                (index) =>
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CircleAvatar(
                      backgroundColor: index == 0
                          ? primaryClr
                          : index == 1
                          ? pinkClr
                          : orangeClr,
                      radius: 14,
                      child: _selectColor == index
                          ? const Icon(
                        Icons.done,
                        size: 16,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
                ),
          ),
        )
      ],
    );
  }
}
