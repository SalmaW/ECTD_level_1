import 'package:flutter/material.dart';

class MyCounterF extends StatefulWidget {
  String title;
  MyCounterF({required this.title, super.key});

  @override
  State<MyCounterF> createState() => _MyCounterFState();
}

class _MyCounterFState extends State<MyCounterF> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.title),
        IconButton(
          onPressed: () {
            _counter += 1;
            setState(() {});
            print('$_counter');
          },
          icon: Icon(Icons.add),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('$_counter'),
        ),
        IconButton(
            onPressed: () {
              _counter -= 1;
              setState(() {});
              print('$_counter');
            },
            icon: Icon(Icons.remove)),
      ],
    );
  }
}
