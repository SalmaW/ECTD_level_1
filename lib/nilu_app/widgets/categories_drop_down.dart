import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../models/category_data.dart';
import '../helpers/sql_helper.dart';

class CategoriesDropDown extends StatefulWidget {
  final int? selectedValue;
  final void Function(int?)? onChange;
  const CategoriesDropDown({
    super.key,
    this.selectedValue,
    required this.onChange,
  });

  @override
  State<CategoriesDropDown> createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  List<CategoryData>? categories;
  @override
  void initState() {
    getCategories();
    super.initState();
  }

  void getCategories() async {
    try {
      var sqlHelper = GetIt.I.get<SqlHelper>();
      var data =
          await sqlHelper.db!.query("Categories"); //select all from categories
      if (data.isNotEmpty) {
        categories = [];
        for (var item in data) {
          categories!.add(CategoryData.fromJson(item));
        }
      } else {
        categories = [];
      }
    } catch (e) {
      categories = [];
      print("Error in get data $e");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return categories == null
        ? const Center(child: CircularProgressIndicator())
        : (categories?.isEmpty ?? false)
            ? const Center(child: Text("No Data Found"))
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: const Text(
                      "select category",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    value: widget.selectedValue,
                    items: [
                      for (var category in categories!)
                        DropdownMenuItem(
                          value: category.id,
                          child: Text(category.name ?? "No Name"),
                        ),
                    ],
                    onChanged: widget.onChange,
                  ),
                ),
              );
  }
}
