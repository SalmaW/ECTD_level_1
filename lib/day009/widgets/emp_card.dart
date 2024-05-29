import '../models/emp.dart';
import 'package:flutter/material.dart';

class EmpCardWidget extends StatelessWidget {
  Employee employee;
  EmpCardWidget({required this.employee, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(),
        title: Text(employee.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employee.email),
            Text(employee.phone),
          ],
        ),
        trailing: Icon(Icons.delete),
        // shape: StadiumBorder(side: BorderSide(color: Colors.black)),
      ),
    );
  }
}
