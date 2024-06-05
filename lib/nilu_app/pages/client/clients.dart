import 'package:data_table_2/data_table_2.dart';
import 'package:ectd/nilu_app/models/client_data.dart';
import 'package:ectd/nilu_app/pages/client/client_ops.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../helpers/sql_helper.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  List<ClientData>? clients;

  @override
  void initState() {
    getClients();
    super.initState();
  }

  void getClients() async {
    try {
      var sqlHelper = GetIt.I.get<SqlHelper>();
      var data =
          await sqlHelper.db!.query("Clients"); //select all from categories
      if (data.isNotEmpty) {
        clients = [];
        for (var item in data) {
          // categories ??= [];
          clients!.add(ClientData.fromJson(item));
        }
      } else {
        clients = [];
      }
    } catch (e) {
      clients = [];
      print("Error in get data $e");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clients"),
        actions: [
          IconButton(
            onPressed: () async {
              var result = await Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const ClientsOps()));
              if (result ?? false) {
                getClients();
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
                SELECT * FROM Clients
                WHERE name LIKE '%$value%' OR phone LIKE '%$value%'
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
                minWidth: 700,
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
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Phone")),
                  DataColumn(label: Text("Address")),
                  DataColumn(label: Center(child: Text("Actions"))),
                ],
                source: MyDataTableSource(clients, getClients),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  List<ClientData>? clients;
  VoidCallback getClients;

  MyDataTableSource(this.clients, this.getClients);

  @override
  DataRow? getRow(int index) {
    return DataRow2(
      // onSelectChanged: (value) {},
      // selected: true,
      cells: [
        DataCell(Text("${clients?[index].id}")),
        DataCell(Text("${clients?[index].name}")),
        DataCell(Text("${clients?[index].email}")),
        DataCell(Text("${clients?[index].phone}")),
        DataCell(Text("${clients?[index].address}")),
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
                await onDelete(clients?[index].id ?? 0);
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
        "Clients",
        where: "id = ?",
        whereArgs: [id],
      );
      if (result > 0) {
        getClients();
      }
    } catch (e) {}
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => clients?.length ?? 0;

  @override
  int get selectedRowCount => 0;
}
