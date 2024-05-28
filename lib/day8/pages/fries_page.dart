import 'package:ectd/day8/widgets/actionButtons.dart';

import 'home.dart';
import 'v_pizza_page.dart';
import 'package:flutter/material.dart';
import '../widgets/my_textButton.dart';
import 'c_pizza_page.dart';
import 'fries_page.dart';

class FriesPage extends StatelessWidget {
  const FriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fries"),
      ),
      body: Column(
        children: [
          const ActionButtons(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/fries.png',
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 230),
                    child: Text(
                      "Fries Page",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 40,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
