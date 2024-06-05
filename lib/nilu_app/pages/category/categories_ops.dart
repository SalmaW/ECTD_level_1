import '../../helpers/sql_helper.dart';
import '../../widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../widgets/app_button.dart';

class CategoriesOps extends StatefulWidget {
  const CategoriesOps({super.key});

  @override
  State<CategoriesOps> createState() => _CategoriesOpsState();
}

class _CategoriesOpsState extends State<CategoriesOps> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
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
                    return "Name is Required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                controller: descriptionController,
                labelText: "Description",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description is Required";
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
        await sqlHelper.db!.insert("Categories", {
          "name": nameController.text,
          "description": descriptionController.text
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Category Saved Successfully")),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text("Error in Creating Category: $e")),
      );
    }
  }
}
