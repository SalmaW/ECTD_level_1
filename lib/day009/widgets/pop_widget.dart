import 'package:flutter/material.dart';

class PopWidget extends StatefulWidget {
  PopWidget({super.key});

  @override
  State<PopWidget> createState() => _PopWidgetState();
}

class _PopWidgetState extends State<PopWidget> {
  String textSelected = "search";
  var options = ["search", "profile", "inbox", " calender"];
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(options[selectedIndex]),
        PopupMenuButton(
          onSelected: (value) {
            selectedIndex = value;
            setState(() {});
          },
          itemBuilder: (ctx) {
            var itemsList = <PopupMenuEntry>[];

            for (var i = 0; i < options.length; i++) {
              itemsList.add(
                PopupMenuItem(
                  value: i,
                  child: Text(options[i]),
                ),
              );
            }

            return itemsList;
          },
        ),
      ],
    );
  }
}
