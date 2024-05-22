import 'package:ectd/widgets/actionButtons.dart';
import 'package:flutter/material.dart';

import '../day7/task/my_textButton.dart';
import 'c_pizza_page.dart';
import 'fries_page.dart';
import 'home.dart';

class VPizzaPage extends StatelessWidget {
  const VPizzaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vegetable Pizza"),
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
                    'assets/images/v_pizza.png',
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(
                      "Vegetable Page",
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
