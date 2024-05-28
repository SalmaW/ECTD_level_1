import 'package:flutter/material.dart';
import '../widgets/my_textButton.dart';
import '../pages/c_pizza_page.dart';
import '../pages/fries_page.dart';
import '../pages/v_pizza_page.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        MyTextbutton(
            title: 'Vegetable Pizza',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => VPizzaPage()));
            }),
        MyTextbutton(
            title: 'Cheese Pizza',
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => CPizzaPage()));
            }),
        MyTextbutton(
            title: 'Fries',
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => FriesPage()));
            }),
      ],
    );
  }
}
