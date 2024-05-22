import 'package:ectd/day10/pages/home.dart';
import 'package:ectd/day9//home.dart';
import 'package:ectd/day9/pages/show_emp.dart';
import 'package:flutter/material.dart';

import 'day10/EASY_POS_R5/sql_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var sqlHelper = SqlHelper();
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
      home: HomePage(),
    );
  }
}
