import '../../helpers/sql_helper.dart';
import '../../widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../widgets/app_button.dart';

class ClientsOps extends StatefulWidget {
  const ClientsOps({super.key});

  @override
  State<ClientsOps> createState() => _ClientsOpsState();
}

class _ClientsOpsState extends State<ClientsOps> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  final emailFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppTextFormField(
                controller: nameController,
                labelText: "Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    emailFocusNode.requestFocus();
                    return "Name is Required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: emailController,
                labelText: "Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    emailFocusNode.requestFocus();
                    return "Email is Required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: phoneController,
                textInputType: TextInputType.number,
                labelText: "Phone",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Phone is Required";
                  }
                  if (value.length < 11) {
                    phoneFocusNode.requestFocus();
                    return 'Invalid Phone Number, must be 11 numbers (ignore +20)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: addressController,
                labelText: "Address",
                validator: (value) {
                  if (value!.isEmpty) {
                    addressFocusNode.requestFocus();
                    return "Address is Required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppButton(
                onPressed: () async {
                  await onSubmit();
                },
                label: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    try {
      if (formKey.currentState!.validate()) {
        var sqlHelper = GetIt.I.get<SqlHelper>();
        await sqlHelper.db!.insert("Clients", {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "address": addressController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Client Saved Successfully")),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text("Error in Creating Client: $e")),
      );
    }
  }
}
