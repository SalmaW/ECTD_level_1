import '../models/database_helper.dart';
import '../models/emp.dart';
import '../pages/show_emp.dart';
import 'package:flutter/material.dart';

class AddEmpPage extends StatefulWidget {
  final Employee? employee;
  // List<Employee> empList;
  AddEmpPage(
      {this.employee,
      super.key}); //the key tells about the widget state at some point - height, width, .size, .. etc

  @override
  State<AddEmpPage> createState() => _AddEmpPageState();
}

class _AddEmpPageState extends State<AddEmpPage> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  var confirmPassController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailFocusNode = FocusNode();
  final passFocusNode = FocusNode();
  final confirmPassFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  var obscure;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscure = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    phoneController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.employee != null) {
      nameController.text = widget.employee!.name;
      emailController.text = widget.employee!.email;
      passController.text = widget.employee!.pass;
      phoneController.text = widget.employee!.phone;
      confirmPassController.text = widget.employee!.confirmPass;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null
            ? 'Add Employee Data'
            : 'Edit Employee Data'),
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
                  decoration: getDecoration('Name', Icons.person),
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLength: 20, //بتحدد عدد الحروف الي اليوزر يكتبها
                  // autocorrect: true,
                  // obscureText: true, //for password
                  // cursorColor: Colors.red,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      emailFocusNode.requestFocus();
                      return 'Please enter your email';
                    }
                  },
                  decoration: getDecoration('Email', Icons.email),
                  controller: emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      passFocusNode.requestFocus();
                      return 'Please enter your Password';
                    }
                    if (value.length < 6) {
                      passFocusNode.requestFocus();
                      return 'Password must be at least 6 characters';
                    }
                  },
                  decoration:
                      getDecorationWithGesture('Password', Icons.password),
                  obscureText: obscure,
                  controller: passController,
                  focusNode: passFocusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 23),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      confirmPassFocusNode.requestFocus();
                      return 'Please enter your Password';
                    }
                    if (value.length < 6) {
                      confirmPassFocusNode.requestFocus();
                      return 'Password must be at least 6 characters';
                    }
                    if (value != passController.text) {
                      confirmPassFocusNode.requestFocus();
                      return 'Please make sure to enter same Password';
                    }
                  },
                  decoration: getDecorationWithGesture(
                      'Confirm Password', Icons.password),
                  obscureText: obscure,
                  controller: confirmPassController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 23),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      phoneFocusNode.requestFocus();
                      return 'Please enter your Phone Number';
                    }
                  },
                  decoration: getDecoration('Phone', Icons.phone),
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                    onPressed: () async {
                      //it will run if every thing is validated
                      if (formKey.currentState!.validate()) {
                        // var emp = Employee(
                        //   name: nameController.text,
                        //   email: emailController.text,
                        //   pass: passController.text,
                        //   phone: phoneController.text,
                        //   confirmPass: confirmPassController.text,
                        // );
                        // print('Name: ${emp.name}');
                        // print('email: ${emp.email}');
                        // print('password: ${emp.pass}');
                        // print('phone: ${emp.phone}');

                        final Employee model = Employee(
                          id: widget.employee?.id,
                          name: nameController.value.text,
                          email: emailController.value.text,
                          pass: passController.value.text,
                          phone: phoneController.value.text,
                          confirmPass: confirmPassController.value.text,
                        );

                        if (widget.employee == null) {
                          await DataBaseHelper.addEmployee(model);
                        } else {
                          await DataBaseHelper.updateEmployee(model);
                        }

                        // Navigator.pop(context);

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (ctx) => ShowEmpPage()),
                            /*
                          [emp, ...widget.empList] creates a new list where emp is added to the beginning of widget.empList.
                          emp is likely a variable representing a single employee.
                          widget.empList is the existing list of employees passed from the parent widget.
                           */
                            (Route<dynamic> route) => false);
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.employee == null ? 'Done' : 'Edit',
                        style: const TextStyle(fontSize: 20),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration getDecoration(String label, IconData icon,
      [IconData? suffixIcon]) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      suffix: Icon(suffixIcon),
      suffixIconColor: const Color(0xFF6750A4), //right-side icon
      icon: Icon(icon),
      iconColor: const Color(0xFF6750A4), //left-side icon
      // hintText: "  write your name", //place holder until the user enters data
      labelText: label,
    );
  }

  InputDecoration getDecorationWithGesture(String label, IconData icon) {
    return InputDecoration(
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      suffixIcon: IconButton(
        icon:
            obscure ? Icon(Icons.visibility_off_sharp) : Icon(Icons.visibility),
        onPressed: () {
          obscure = !obscure;
          setState(() {});
        },
      ),

      suffixIconColor: const Color(0xFF6750A4), //right-side icon
      icon: Icon(icon),
      iconColor: const Color(0xFF6750A4), //left-side icon
      // hintText: "  write your name", //place holder until the user enters data
      labelText: label,
    );
  }
}
