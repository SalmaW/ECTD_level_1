import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../EASY_POS_R5/sql_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Stack(
            children: [
              Container(
                height: 360,
                width: 360,
                color: Colors.red,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 300,
                    width: 300,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'key is not good';
                                    }
                                  },
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'key is not good';
                                    }
                                  },
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'key is not good';
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              // var sql = SqlHelper();
                              // await sql.init();
                              var sql = GetIt.I.get<SqlHelper>();
                              await sql.createTables();
                              // var result = await sql.db?.insert("Customers", {
                              //   "name": "salma",
                              //   "phone": "123456789",
                              //   "address": "new cairo",
                              // });
                              var data = await sql.db?.query("Customers");

                              // print("result: $result"); //returns int id
                              print("data: $data"); //returns table data

                              // await sql.createTables();

                              if (formKey.currentState!.validate()) {
                                //code to run
                              }
                            },
                            child: const Text('click me')),
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   child: Container(
              //     height: 200,
              //     width: 200,
              //     color: Colors.yellow,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
