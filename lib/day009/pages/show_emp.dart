import 'package:ectd/day009/pages/add_emp.dart';
import 'package:ectd/day009/widgets/emp_card.dart';
import 'package:flutter/material.dart';
import '../models/emp.dart';

class ShowEmpPage extends StatefulWidget {
  List<Employee> empList;
  ShowEmpPage({required this.empList, super.key});

  @override
  State<ShowEmpPage> createState() => _ShowEmpPageState();
}

class _ShowEmpPageState extends State<ShowEmpPage> {
  int currentIndex = 0;
  List<Widget> bodies = [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Phone'),
    ),
    Center(
      child: Text('Profile'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(),
              accountName: Text('name'),
              accountEmail: Text('example@gmail.com'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('QR'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.menu),
              title: Text('menu'),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        type: BottomNavigationBarType.shifting,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: "Phone",
            backgroundColor: Colors.redAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            backgroundColor: Colors.blueAccent,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AddEmpPage(
                        empList: widget.empList,
                      )));
        },
      ),
      appBar: AppBar(
        title: const Text('ShowEmp'),
      ),
      // body: bodies[currentIndex];
      body: widget.empList.isEmpty
          ? Center(child: SelectableText('No data'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: getEmpCard(),
              ),
            ),
    );
  }

  List<Widget> getEmpCard() {
    List<Widget> empCard = [];
    for (var emp in widget.empList) {
      empCard.add(EmpCardWidget(employee: emp));
    }
    return empCard;
  }
}
