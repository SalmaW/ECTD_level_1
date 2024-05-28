import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  String title;
  String imagePath;
  MyCard({required this.title, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.transparent,
      color: Colors.deepOrange,
      elevation: 10,
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/$imagePath",
            width: 100,
            height: 100,
          ),
          Text(title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              )),
        ],
      ),
    );
  }
}
