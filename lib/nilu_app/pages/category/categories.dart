import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../helpers/sql_helper.dart';
import '../category/categories_ops.dart';
import '../../models/category_data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
          // categories ??= [];
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const CategoriesOps()));
              if (result ?? false) {
                getCategories();
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) async {
                var sqlHelper = GetIt.I.get<SqlHelper>();
                var search = await sqlHelper.db!.rawQuery("""
                SELECT * FROM Categories
                WHERE name LIKE '%$value%' OR description LIKE '%$value%'
                """);
                print(search);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                labelText: "Search",
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: PaginatedDataTable2(
                // showCheckboxColumn: true,
                empty: const Center(child: Text("No Data Found")),
                renderEmptyRowsInTheEnd: false,
                isHorizontalScrollBarVisible: true,
                minWidth: 600,
                columnSpacing: 20,
                horizontalMargin: 20,
                wrapInCard: false,
                rowsPerPage: 15,
                border: TableBorder.all(),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                headingRowColor:
                    WidgetStatePropertyAll(Theme.of(context).primaryColor),
                columns: const [
                  DataColumn(label: Text("Id")),
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Description")),
                  DataColumn(label: Center(child: Text("Actions"))),
                ],
                source: MyDataTableSource(categories, getCategories),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  List<CategoryData>? categories;
  VoidCallback getCategories;

  MyDataTableSource(this.categories, this.getCategories);

  @override
  DataRow? getRow(int index) {
    return DataRow2(
      // onSelectChanged: (value) {},
      // selected: true,
      cells: [
        DataCell(Text("${categories?[index].id}")),
        DataCell(Text("${categories?[index].name}")),
        DataCell(Text("${categories?[index].description}")),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (ctx) => CategoriesOps()));
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () async {
                await onDelete(categories?[index].id ?? 0);
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        )),
      ],
    );
  }

  Future<void> onDelete(int id) async {
    try {
      var sqlHelper = GetIt.I.get<SqlHelper>();
      var result = await sqlHelper.db!.delete(
        "Categories",
        where: "id = ?",
        whereArgs: [id],
      );
      if (result > 0) {
        getCategories();
      }
    } catch (e) {}
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories?.length ?? 0;

  @override
  int get selectedRowCount => 0;
}
