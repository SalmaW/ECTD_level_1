import 'package:ectd/day11/widgets/bottom_modal_sheet.dart';
import 'package:ectd/day11/widgets/custom_dialog.dart';
import 'package:ectd/day11/widgets/date_time_picker.dart';
import 'package:ectd/day11/widgets/slider_ex.dart';
import 'package:ectd/day11/widgets/switch_button.dart';
import 'package:flut_grouped_buttons/flut_grouped_buttons.dart';
import 'package:flutter/material.dart';

class RadioCheckButton extends StatefulWidget {
  const RadioCheckButton({super.key});

  @override
  State<RadioCheckButton> createState() => _RadioCheckButtonState();
}

/*class _RadioCheckButtonState extends State<RadioCheckButton> {
  Map<String, bool> data = {
    "Goodmorning": true,
    "Afternoon": false,
    "Goodevening": false
  };
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              // checkColor: Colors.grey,
              activeColor: Colors.blue,
              value: data["Goodmorning"],
              onChanged: (value) {
                resetMapValues();
                data["Goodmorning"] = true;
                setState(() {});
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            Text("Goodmorning"),
          ],
        ),
        Row(
          children: [
            Checkbox(
              // checkColor: Colors.grey,
              activeColor: Colors.pinkAccent,
              value: data["Afternoon"],
              onChanged: (value) {
                resetMapValues();
                data["Afternoon"] = true;
                setState(() {});
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            Text("Afternoon"),
          ],
        ),
        Row(
          children: [
            Checkbox(
              // checkColor: Colors.grey,
              activeColor: Colors.pinkAccent,
              value: data["Goodevening"],
              onChanged: (value) {
                resetMapValues();
                data["Goodevening"] = true;
                setState(() {});
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            Text("Goodevening"),
          ],
        ),
      ],
    );
  }

  void resetMapValues() {
    for (var key in data.keys) {
      data[key] = false;
    }
  }
}*/

class _RadioCheckButtonState extends State<RadioCheckButton> {
  // Map<String, bool> data = {
  //   "Goodmorning": true,
  //   "Afternoon": false,
  //   "Goodevening": false
  // };

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  DateTime? dateTimeValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutGroupedButtons(
            isRadio: true,
            selectedList: ["Goodmorning"],
            data: const ["Goodmorning", "Afternoon", "Goodevening"],
            onChanged: (value) {
              print('value: $value');
            }),
        /*Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(selectedDate == null
                  ? "selected date"
                  : "${selectedDate!.year} - ${selectedDate!.month} - ${selectedDate!.day}"),
              IconButton(
                  onPressed: () async {
                    var result = await showDatePicker(
                        // by default it's set to TRUE, as when you tap anywhere in the gray area around the calendar it will close the calendar
                        barrierDismissible: false,
                        context: context,
                        initialDate: selectedDate == null
                            ? DateTime.now()
                            : selectedDate,
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2025));
                    if (result != null) {
                      selectedDate = result;
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.calendar_today_outlined)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(selectedTime == null
                  ? "selected time"
                  : "${selectedTime!.hour} : ${selectedTime!.minute}"),
              IconButton(
                  onPressed: () async {
                    var result = await showTimePicker(
                        // by default it's set to TRUE, as when you tap anywhere in the gray area around the calendar it will close the calendar
                        barrierDismissible: false,
                        context: context,
                        initialTime: selectedTime ?? TimeOfDay.now());
                    // initialTime: selectedTime == null ? TimeOfDay.now() : selectedTime!

                    if (result != null) {
                      selectedTime = result;
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.schedule_outlined)),
            ],
          ),
        ),*/

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(dateTimeValue == null
                  ? "selected Date & Time"
                  : "${dateTimeValue!.year} - ${dateTimeValue!.month} - ${dateTimeValue!.day}   ${dateTimeValue!.hour} : ${dateTimeValue!.minute} : ${dateTimeValue!.second}"),
              IconButton(
                  onPressed: () async {
                    var result = await showDateTimePicker(
                        // by default it's set to TRUE, as when you tap anywhere in the gray area around the calendar it will close the calendar
                        context,
                        initialDate: dateTimeValue ?? DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2025),
                        initialTime: dateTimeValue == null
                            ? TimeOfDay.now()
                            : TimeOfDay(
                                hour: dateTimeValue!.hour,
                                minute: dateTimeValue!.minute));
                    if (result != null) {
                      dateTimeValue = result;
                      // to show the time based on the time zone of the mobile
                      // DateTime.fromMicrosecondsSinceEpoch().toLocal();
                      // print(dateTimeValue!.millisecondsSinceEpoch);
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.calendar_today_outlined)),
            ],
          ),
        ),
        SliderEx(),
        SwitchButton(),
        CustomDialog(),
        BottomModalSheet(),
      ],
    );
  }

  // void resetMapValues() {
  //   for (var key in data.keys) {
  //     data[key] = false;
  //   }
  // }
}
