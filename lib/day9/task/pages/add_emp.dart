import 'package:ectd/day9/task/models/emp.dart';
import 'package:flutter/material.dart';

class AddEmpPage extends StatefulWidget {
  List<Employee> empList;
  AddEmpPage({
    required this.empList,
    super.key,
  });

  @override
  State<AddEmpPage> createState() => _AddEmpPageState();
}

class _AddEmpPageState extends State<AddEmpPage> {
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var passConfirmedController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    emailController.dispose();
    passController.dispose();
    passConfirmedController.dispose();
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid Email Address';
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
                      return 'Please enter a valid Username';
                    }
                  },
                  controller: usernameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLength: 20,
                  decoration: getDecoration('Username', Icons.person),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid Password';
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
                      return 'Please enter a valid Password, and make sure to be matched';
                    }
                  },
                  controller: passConfirmedController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: getDecoration('Confirm Password', Icons.password)
                      .copyWith(suffix: Icon(Icons.visibility_off_sharp)),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var emp = Employee(
                          username: usernameController.text,
                          email: emailController.text,
                          pass: passController.text,
                          passConfirmed: passConfirmedController.text,
                        );
                      }
                    },
                    child: Text('Sign Up')),
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
    prefix: Icon(icon),
    label: Text(label),
  );
}
