import 'package:ectd/day7/widgets/icon_button.dart';
import 'package:ectd/day7/widgets/my_textButton.dart';
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('WOW Pizza'),
          actions: [
            // IconButton(onPressed: () {}, icon: Icon(Icons.facebook_outlined)),
            // IconButton(onPressed: () {}, icon: Icon(Icons.add)),

            MyIconButton(),
            MyImageButton(),
          ],
        ),
        body: Column(
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                MyTextbutton(title: 'Vegetable Pizza', onPressed: () {}),
                MyTextbutton(title: 'Cheese Pizza', onPressed: () {}),
                MyTextbutton(title: 'Fires', onPressed: () {}),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      'assets/images/place.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Text(
                    "Hi, I'm the Pizza Assistance\nwhat can I help you order?",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
