import '../models/emp.dart';
import '../pages/show_emp.dart';
import 'package:flutter/material.dart';

import '../models/database_helper.dart';

class EmpCardWidget extends StatefulWidget {
  // Employee employee;
  // EmpCardWidget({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Card(
  //     child: ListTile(
  //       leading: const CircleAvatar(),
  //       title: Text(employee.name),
  //       subtitle: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(employee.email),
  //           Text(employee.phone),
  //         ],
  //       ),
  //       trailing: Icon(Icons.delete),
  //       // shape: StadiumBorder(side: BorderSide(color: Colors.black)),
  //     ),
  //   );
  // }

  final Employee employee;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const EmpCardWidget(
      {super.key,
      required this.employee,
      required this.onTap,
      required this.onLongPress});

  @override
  State<EmpCardWidget> createState() => _EmpCardWidgetState();
}

class _EmpCardWidgetState extends State<EmpCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPress,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          elevation: 2,
          child: ListTile(
            leading: const CircleAvatar(),
            title: Text(widget.employee.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.employee.email),
                Text(widget.employee.phone),
              ],
            ),
            trailing: IconButton(
                color: Colors.red,
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                              'Are you sure you want to delete this note?'),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.red)),
                              onPressed: () async {
                                await DataBaseHelper.deleteEmployee(
                                    widget.employee);
                                // Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => ShowEmpPage()),
                                    (Route<dynamic> route) => false);
                                setState(() {});
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                          ],
                        );
                      });
                }),
            // shape: StadiumBorder(side: BorderSide(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
