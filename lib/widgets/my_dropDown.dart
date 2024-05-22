import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedIndex,
      icon: Icon(Icons.keyboard_arrow_down),
      underline: SizedBox(),
      items: const [
        DropdownMenuItem(
          child: Text('item 1'),
          value: 1,
        ),
        DropdownMenuItem(
          child: Text('item 2'),
          value: 2,
        ),
        DropdownMenuItem(
          child: Text('item 3'),
          value: 3,
        ),
      ],
      onChanged: (value) {
        selectedIndex = value as int;
        setState(() {});
        print('value: $value');
      },
    );
  }
}
