import 'package:flutter/material.dart';

class Item {
  Widget image;
  String headerText;
  String expandedText;
  bool isExpanded;

  Item({
    required this.image,
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
  });
}
