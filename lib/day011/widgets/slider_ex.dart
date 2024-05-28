import 'package:flutter/material.dart';

class SliderEx extends StatefulWidget {
  const SliderEx({Key? key}) : super(key: key);

  @override
  State<SliderEx> createState() => _SliderExState();
}

class _SliderExState extends State<SliderEx> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          divisions: 100,
          //label: show where the current pointer is
          label: "${value.round()}",
          min: 0,
          max: 100,
          value: value,
          onChanged: (valueOnChanged) {
            setState(() {
              value = valueOnChanged;
            });
          },
        ),
        Text('value is: ${value.round()}'),
      ],
    );
  }
}
