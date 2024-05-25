import 'package:ectd/day10/task10/models/database_helper.dart';
import 'package:ectd/day10/task10/models/emp.dart';
import 'package:ectd/day10/task10/pages/add_emp.dart';
import 'package:ectd/day10/task10/pages/person_bottomNavigationBar_page.dart';
import 'package:ectd/day10/task10/pages/phone_bottomNavigationBar_page.dart';
import 'package:ectd/day10/task10/widgets/emp_card.dart';
import 'package:flutter/material.dart';

class ShowEmpPage extends StatefulWidget {
  // List<Employee> empList;
  // final Employee? employee;
  ShowEmpPage({super.key});

  @override
  State<ShowEmpPage> createState() => _ShowEmpPageState();
}

class _ShowEmpPageState extends State<ShowEmpPage> {
  int currentIndex = 0;
  List<Widget> bodies = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Phone'),
    ),
    const Center(
      child: Text('Profile'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
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
          items: const [
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
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (ctx) => AddEmpPage()));
            setState(() {});
          },
        ),
        appBar: AppBar(
          title: const Text('Show Employees'),
        ),
        // body: bodies[currentIndex];
        // body: widget.empList.isEmpty
        //     ? Center(child: SelectableText('No data'))
        //     : Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: ListView(
        //           children: getEmpCard(),
        //         ),
        //       ),
        body: FutureBuilder<List<Employee>?>(
          future: DataBaseHelper.getAllEmployees(),
          builder: (context, AsyncSnapshot<List<Employee>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => EmpCardWidget(
                    employee: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddEmpPage(employee: snapshot.data![index])));
                      setState(() {});
                    },
                    onLongPress: () async {
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
                                        snapshot.data![index]);
                                    Navigator.pop(context);
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
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('No employees yet'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}

// List<Widget> getEmpCard() {
//   List<Widget> empCard = [];
//   for (var emp in widget.empList) {
//     empCard.add(EmpCardWidget(employee: emp));
//   }
//   return empCard;
// }
