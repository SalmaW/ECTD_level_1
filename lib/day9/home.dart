import 'package:ectd/day9/pages/show_emp.dart';
import 'package:ectd/widgets/icon_button.dart';
import 'package:ectd/widgets/menu_item.dart';
import 'package:ectd/widgets/pop_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text('WOW Pizza'),
        actions: const [
          MyIconButton(),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: MyImageButton(),
            // MyIconButton(onPressed: () {
            //   Navigator.pushNamed(context, '/vpizza');
            // }),
          ),
        ],
      ),
      body: ShowEmpPage(empList: []),
    );
  }
}
/*
  types of storing data as DB:
  1. noSQL -> hive,
  2. SQL -> SQLite(fast)

  Shared Preferences -> use key-value pair
 */
