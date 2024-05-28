import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MenuItem extends StatelessWidget {
  String title;
  String imagePath;
  MenuItem({required this.title, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrange,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        children: [
          Image.asset(
            width: 120,
            // height: 100,
            'assets/images/$imagePath',
            // fit: BoxFit.scaleDown,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
