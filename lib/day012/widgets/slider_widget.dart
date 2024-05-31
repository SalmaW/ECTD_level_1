import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  final String labelName;
  const SliderWidget({required this.labelName, super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${widget.labelName}: ${value.round()}'),
        Slider(
          divisions: 6,
          label: "${value.round()}",
          min: 0,
          max: 6,
          value: value,
          onChanged: (valueOnChanged) {
            value = valueOnChanged;
            setState(() {});
          },
        ),
      ],
    );
  }
}
