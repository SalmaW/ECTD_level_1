import 'package:flut_grouped_buttons/flut_grouped_buttons.dart';
import 'package:flutter/material.dart';

class RadioCheckButton extends StatefulWidget {
  late bool isRadio;
  late List<String>? selectedList;
  late List<String> data;
  RadioCheckButton(
      {required this.isRadio,
      this.selectedList,
      required this.data,
      super.key});

  @override
  State<RadioCheckButton> createState() => _RadioCheckButtonState();
}

class _RadioCheckButtonState extends State<RadioCheckButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FlutGroupedButtons(
            isRadio: widget.isRadio,
            selectedList: widget.selectedList,
            data: widget.data,
            onChanged: (value) {
              print('value: $value');
            }),
      ],
    );
  }
}
