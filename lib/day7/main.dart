import 'package:ectd/day7/my_card.dart';
import 'package:ectd/day7/my_counter.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.pink,
          foregroundColor: Colors.yellow,
          splashColor: Colors.blue,
          elevation: 10,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('data'),
          actions: [
            PopupMenuButton(onSelected: (selectedValue) {
              print('selectedValue $selectedValue');
            }, itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('hello'),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text('say'),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text('what'),
                  value: 3,
                ),
              ];
            })
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(15),
                height: 100,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.pink[200],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/v_pizza.png',
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text('Vegetable Pizza',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                  ],
                ),
              ),
              MyCard(title: "Vegetable Pizza", imagePath: "v_pizza.png"),
              MyCard(title: "Cheese Pizza", imagePath: "c_pizza.png"),
              MyCounterF(title: 'my title'),
              ElevatedButton(
                onPressed: () {},
                // onPressed: null, -> disabled button
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text('hello'),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'text Button',
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(),
                child: Text('hello'),
              ),
              ButtonBar(
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(),
                    child: Text('feild 1'),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(),
                    child: Text('feild 2'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
