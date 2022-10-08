import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final DateTime _selectedDate = DateTime.now();
  final String _startTime =
      DateFormat('hh:mm a').format(DateTime.now()).toString();
  final String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;

  List<int> remindList = [5, 10, 20];
  String _selectRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int _selectColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    icon: const Icon(
                      Icons.date_range_outlined,
                    ),
                    onPressed: () {}),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        icon: Icon(Icons.access_time_outlined),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_outlined,
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
                  hint: '$_selectedRemind minutes early',
                  widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,borderRadius: BorderRadius.circular(15),

                    onChanged: (String? value) {
                      setState(() {
                        _selectedRemind = int.parse(value!) ;
                      });
                    },
                    items: remindList
                        .map<DropdownMenuItem<String>>(
                          (value) => DropdownMenuItem(
                            value: value.toString(),

                              child: Text(
                            '$value',
                            style: const TextStyle(color: Colors.white),
                          )),
                        )
                        .toList(),
                    icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(height: 0,),
                  )),
              InputField(
                  title: 'Repeat',
                  hint: '$_selectRepeat ',
                  widget: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15),
                    onChanged: (String? value) => setState(() {
                      _selectRepeat = value! ;
                    }),
                    items: repeatList
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                              child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          )),
                        )
                        .toList(),
                    icon: const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                    underline: Container(height: 0,),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
