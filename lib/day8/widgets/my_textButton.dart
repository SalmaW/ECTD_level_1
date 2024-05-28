import 'package:flutter/material.dart';

class MyTextbutton extends StatelessWidget {
  String title;
  Function()? onPressed;
  MyTextbutton({required this.title, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      statesController: WidgetStatesController(),
      style: TextButton.styleFrom(
          foregroundColor: Colors.orange,
          side: BorderSide(color: Colors.grey.shade300)),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
      ),
    );
  }
}
