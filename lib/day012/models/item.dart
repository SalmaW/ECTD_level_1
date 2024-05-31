import 'package:flutter/material.dart';

class Item {
  final Widget image;
  final String headerText;
  final String expandedText;
  bool isExpanded;

  Item({
    required this.image,
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
  });
}
