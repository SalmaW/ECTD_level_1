import 'package:flutter/material.dart';

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
                            onPressed: () {
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
