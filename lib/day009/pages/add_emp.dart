import 'package:ectd/day009/models/emp.dart';
import 'package:ectd/day009/pages/show_emp.dart';
import 'package:flutter/material.dart';

class AddEmpPage extends StatefulWidget {
  List<Employee> empList;
  AddEmpPage(
      {required this.empList,
      super.key}); //the key tells about the widget state at some point - height, width, .size, .. etc

  @override
  State<AddEmpPage> createState() => _AddEmpPageState();
}

class _AddEmpPageState extends State<AddEmpPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // when the uses enters data it removes the validation msg
                  validator: (value) {
                    // used when the user did not enter any data, so it throws a validation msg. and when
                    // entering new data, it updates the formKey
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                  },
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLength: 20, //بتحدد عدد الحروف الي اليوزر يكتبها
                  // autocorrect: true,
                  // obscureText: true, //for password

                  // cursorColor: Colors.red,
                  decoration: getDecoration('Name', Icons.person),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: getDecoration('Email', Icons.email),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your pass';
                    }
                  },
                  controller: passController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: getDecoration('Password', Icons.password)
                      .copyWith(suffix: Icon(Icons.visibility_off_sharp)),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value != passController.text) {
                      return 'Please renter your password';
                    }
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: getDecoration('Phone', Icons.phone),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var emp = Employee(
                          name: nameController.text,
                          email: emailController.text,
                          pass: passController.text,
                          phone: phoneController.text,
                        );
                        // print('Name: ${emp.name}');
                        // print('email: ${emp.email}');
                        // print('password: ${emp.pass}');
                        // print('phone: ${emp.phone}');

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => ShowEmpPage(
                                    empList: [emp, ...widget.empList])),
                            /*
                          [emp, ...widget.empList] creates a new list where emp is added to the beginning of widget.empList.
                          emp is likely a variable representing a single employee.
                          widget.empList is the existing list of employees passed from the parent widget.
                           */
                            (Route<dynamic> route) => false);
                      }
                    },
                    child: Text('Done')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration getDecoration(String label, IconData icon) {
  return InputDecoration(
    border:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    disabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    errorBorder:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

    // suffix: Icon(Icons.person), //right-side icon
    prefix: Icon(icon), //left-side icon
    // hintText: "  write your name", //place holder until the user enters data
    label: Text(label),
  );
}
