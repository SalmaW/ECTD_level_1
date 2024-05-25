import 'package:ectd/day10/task10/pages/show_emp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Gilroy',
      ),
      // routes: {//navigation by name
      //   '/': (context) => Home(),
      //   '/vpizza': (context) => VPizzaPage(),
      //   '/cpizza': (context) => CPizzaPage(),
      //   '/fries': (context) => FriesPage(),
      // },
      home: ShowEmpPage(),
    );
  }
}
