import 'package:flutter/material.dart';
import '../widgets/actionButtons.dart';
import 'home.dart';
import 'v_pizza_page.dart';
import '../day7/task/my_textButton.dart';
import 'c_pizza_page.dart';
import 'fries_page.dart';

class CPizzaPage extends StatelessWidget {
  const CPizzaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cheese Pizza"),
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
                    'assets/images/c_pizza.png',
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(
                      "Cheese Page",
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
