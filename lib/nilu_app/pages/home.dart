import '../helpers/sql_helper.dart';
import '../widgets/grid_view_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool isTableInitialized = false;

  @override
  void initState() {
    initializeTables();
    super.initState();
  }

  void initializeTables() async {
    var sqlHelper = GetIt.I.get<SqlHelper>();
    isTableInitialized = await sqlHelper.createTables();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(),
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3 +
                      (kIsWeb ? 0 : 57), // 57 works on my emulator
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Easy Pos',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: isLoading
                                  ? Transform.scale(
                                      scale: .5,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: isTableInitialized
                                          ? Colors.green
                                          : Colors.red,
                                      radius: 10,
                                    ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        headerItem('Exchange rate', '1USD = 50 EGP'),
                        headerItem('Today\'s sales', '1000 EGP'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              color: const Color(0xffFAFAFA),
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  GridViewItem(
                    color: Colors.orange,
                    iconData: Icons.receipt,
                    label: 'All Sales',
                  ),
                  GridViewItem(
                    color: Colors.pink[200],
                    iconData: Icons.inventory_2,
                    label: 'Products',
                  ),
                  GridViewItem(
                    color: Colors.lightBlue,
                    iconData: Icons.people,
                    label: 'Clients',
                  ),
                  GridViewItem(
                    color: Colors.green,
                    iconData: Icons.shopping_basket,
                    label: 'New Sale',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headerItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: const Color(0xff206ce1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  // fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white54,
                  // fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
