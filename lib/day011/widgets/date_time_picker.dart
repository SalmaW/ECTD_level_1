import 'package:flutter/material.dart';

Future<DateTime?> showDateTimePicker(BuildContext context,
    {required DateTime firstDate,
    required DateTime lastDate,
    required TimeOfDay initialTime,
    DateTime? initialDate}) async {
  try {
    var resultDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDate: initialDate);

    if (resultDate != null) {
      var resultTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );
      if (resultTime != null) {
        return DateTime(resultDate.year, resultDate.month, resultDate.day,
            resultTime.hour, resultTime.minute, resultDate.second);
      } else {
        return DateTime(resultDate.year, resultDate.month, resultDate.day);
      }
    }

    return null;
  } catch (e) {
    print('Exception: $e');
    return null;
  }
}
