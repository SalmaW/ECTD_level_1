import '../day011/task/pages/home.dart';
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
          fontFamily: 'Poetsen_One',
          focusColor: Theme.of(context).primaryColorLight),
      // routes: {//navigation by name
      //   '/': (context) => Home(),
      //   '/vpizza': (context) => VPizzaPage(),
      //   '/cpizza': (context) => CPizzaPage(),
      //   '/fries': (context) => FriesPage(),
      // },
      home: HomePage(),
    );
  }
}
