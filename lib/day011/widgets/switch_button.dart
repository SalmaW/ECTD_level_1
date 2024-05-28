import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({Key? key}) : super(key: key);

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
          //activeColor: when specifying a color, flutter automatically will make the activeTrackColor smilier to the active
          // activeColor: Colors.yellow,
          value: isChecked,
          //inactiveThumbColor: the color of the circle
          // inactiveThumbColor: Colors.pinkAccent,
          // inactiveTrackColor: Colors.green,
          onChanged: (value) {
            isChecked = !isChecked;
            setState(() {});
          },
        ),
        Theme(
          data: ThemeData(platform: TargetPlatform.iOS),
          //most widgets followed with .adaptive is IOS ui
          child: Switch.adaptive(
            //activeColor: when specifying a color, flutter automatically will make the activeTrackColor smilier to the active
            // activeColor: Colors.yellow,
            value: isChecked,
            //inactiveThumbColor: the color of the circle
            // inactiveThumbColor: Colors.pinkAccent,
            // inactiveTrackColor: Colors.green,
            onChanged: (value) {
              isChecked = !isChecked;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
