import 'package:flutter/material.dart';

class BottomModalSheet extends StatefulWidget {
  const BottomModalSheet({Key? key}) : super(key: key);

  @override
  State<BottomModalSheet> createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return Container(
              height: 200,
              width: 200,
              child: Icon(Icons.add),
            );
          },
        );
      },
      child: Text("bottom modal sheet"),
    );
  }
}
