import 'package:flutter/material.dart';

Future<DateTime?> showDateTimePicker(BuildContext context,
    {required DateTime firstDate,
    required DateTime lastDate,
    required TimeOfDay initialTime,
    required DateTime? initialDate}) async {
  try {
    var pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: initialDate);

    if (pickedDate != null) {
      var pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );
      if (pickedTime != null) {
        return DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
            pickedTime.hour, pickedTime.minute, pickedDate.second);
      } else {
        return DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
      }
    }
    return null;
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
