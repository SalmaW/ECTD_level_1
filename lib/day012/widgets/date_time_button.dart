import '../widgets/date_time_picker.dart';
import 'package:flutter/material.dart';

class DateTimeButton extends StatefulWidget {
  final String checkInOutDate;
  final ValueChanged<DateTime>? onDateSelected;
  final DateTime? firstDate;
  DateTimeButton(
      {required this.checkInOutDate,
      this.firstDate,
      this.onDateSelected,
      super.key});

  @override
  State<DateTimeButton> createState() => _DateTimeButtonState();
}

class _DateTimeButtonState extends State<DateTimeButton> {
  DateTime? dateTimeValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.checkInOutDate,
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(dateTimeValue == null
                  ? "selected Date & \nTime of Arrival"
                  : "${dateTimeValue!.year} - ${dateTimeValue!.month} - ${dateTimeValue!.day}\n         ${dateTimeValue!.hour} : ${dateTimeValue!.minute}"),
              IconButton(
                  onPressed: () async {
                    var initialDate = dateTimeValue ?? DateTime.now();
                    if (widget.firstDate != null &&
                        initialDate.isBefore(widget.firstDate!)) {
                      initialDate = widget.firstDate!;
                    }

                    var result = await showDateTimePicker(
                      context,
                      initialDate: initialDate,
                      firstDate: widget.firstDate ?? DateTime(2023),
                      lastDate: DateTime(2025),
                      initialTime: dateTimeValue == null
                          ? TimeOfDay.now()
                          : TimeOfDay(
                              hour: dateTimeValue!.hour,
                              minute: dateTimeValue!.minute),
                    );
                    if (result != null) {
                      dateTimeValue = result;
                      widget.onDateSelected?.call(result);
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.calendar_today_outlined)),
            ],
          ),
        ],
      ),
    );
  }
}
