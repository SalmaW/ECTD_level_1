import '../models/order.dart';
import '../models/order_item.dart';
import '../widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../helpers/sql_helper.dart';
import '../models/product_data.dart';

class SaleOp extends StatefulWidget {
  final Order? order;
  const SaleOp({this.order, super.key});

  @override
  State<SaleOp> createState() => _SaleOpState();
}

class _SaleOpState extends State<SaleOp> {
  String? orderLabel;
  List<ProductData>? products;
  List<OrderItem> selectedOrderItem = [];

  @override
  void initState() {
    initPage();
    super.initState();
  }

  void initPage() {
    orderLabel = widget.order == null
        ? "#ORDER${DateTime.now().microsecondsSinceEpoch}"
        : "${widget.order!.id}";
    getProducts();
  }

  void getProducts() async {
    try {
      var sqlHelper = GetIt.I.get<SqlHelper>();
      var data = await sqlHelper.db!.rawQuery("""
      select P.* ,C.name as categoryName,C.description as categoryDescription 
      from Products P
      inner join Categories C
      where P.categoryId = C.id
      """);

      if (data.isNotEmpty) {
        products = [];
        for (var item in data) {
          products!.add(ProductData.fromJson(item));
        }
      } else {
        products = [];
      }
    } catch (e) {
      print('Error In get data $e');
      products = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order == null ? 'Add New Sale' : 'Update Sale'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Label : $orderLabel',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        color: Colors.red,
                        //TODO: add client drop down here
                        child: const Text("TODO: add client drop down here"),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                onClickedAddProduct();
                              },
                              icon: const Icon(Icons.add)),
                          const Text(
                            "Add Products",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Order Items",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      for (var orderItem in selectedOrderItem)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            leading: Image.network(
                                orderItem.productData?.image ?? ""),
                            title: Text(
                                '${orderItem.productData?.name ?? ""}, ${orderItem.productCount}X'),
                            trailing: Text(
                                '${(orderItem.productCount ?? 0) * (orderItem.productData?.price ?? 0)}'),
                          ),
                        ),
                      Container(
                        color: Colors.red,
                        //TODO: add discount textField
                        child: const Text('TODO: add discount textField'),
                      ),
                      Text(
                        "Total Price = $calculateTotalPrice",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              AppButton(
                  onPressed: selectedOrderItem.isEmpty
                      ? null
                      : () async {
                          await onSetOrder();
                        },
                  label: 'Add Order'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSetOrder() async {
    try {
      var sqlHelper = GetIt.I.get<SqlHelper>();
      var orderId = await sqlHelper.db!.insert(
        "Orders",
        {
          "label": orderLabel,
          "totalPrice": calculateTotalPrice,
          "discount": 0,
          "clientId": 1
        },
      );

      var batch = sqlHelper.db!.batch();
      for (var orderItem in selectedOrderItem) {
        batch.insert('orderProductItems', {
          "orderId": orderId,
          "productId": orderItem.productId,
          "productCount": orderItem.productCount ?? 0,
        });
        sqlHelper.backupDatabase();
        var result = await batch.commit();
        print(">>>>>>>>>>> selected order items ids: $result");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Order Set Successfully")),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text("Error in Creating Order: $e")),
      );
    }
  }

  double get calculateTotalPrice {
    double total = 0;
    for (var orderItem in selectedOrderItem) {
      total = total +
          ((orderItem.productCount ?? 0) * (orderItem.productData?.price ?? 0));
    }

    return total;
  }

  void onClickedAddProduct() async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: (products?.isEmpty ?? false)
                    ? const Center(child: Text("No Data Found"))
                    : Column(
                        children: [
                          const Text(
                            "Products",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView(children: [
                              for (var product in products!)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    leading: Image.network(
                                        product.image ?? "no image"),
                                    title: Text(product.name ?? "no name"),
                                    subtitle: getOrderItem(product.id!) == null
                                        ? null
                                        : Row(
                                            children: [
                                              IconButton(
                                                  onPressed: getOrderItem(
                                                                  product
                                                                      .id!) !=
                                                              null &&
                                                          getOrderItem(product
                                                                      .id!)
                                                                  ?.productCount ==
                                                              1
                                                      ? null
                                                      : () {
                                                          // var orderItem =
                                                          //     getOrderItem(
                                                          //         product.id!);
                                                          // if ((orderItem
                                                          //             ?.productCount ??
                                                          //         0) <
                                                          //     1) {
                                                          //   onDeleteItem(product.id!);
                                                          //   setStateDialog(() {});
                                                          // }
                                                          getOrderItem(product
                                                                      .id!)
                                                                  ?.productCount =
                                                              (getOrderItem(product
                                                                              .id!)
                                                                          ?.productCount ??
                                                                      0) -
                                                                  1;
                                                          setStateDialog(() {});
                                                        },
                                                  icon:
                                                      const Icon(Icons.remove)),
                                              Text(getOrderItem(product.id!)!
                                                  .productCount
                                                  .toString()),
                                              IconButton(
                                                  onPressed: () {
                                                    getOrderItem(product.id!)
                                                            ?.productCount =
                                                        (getOrderItem(product
                                                                        .id!)
                                                                    ?.productCount ??
                                                                0) +
                                                            1;
                                                    setStateDialog(() {});
                                                  },
                                                  icon: const Icon(Icons.add)),
                                            ],
                                          ),
                                    trailing: getOrderItem(product.id!) == null
                                        ? IconButton(
                                            onPressed: () {
                                              onAddItem(product);
                                              setStateDialog(() {});
                                            },
                                            icon: const Icon(Icons.add))
                                        : IconButton(
                                            onPressed: () {
                                              onDeleteItem(product.id!);
                                              setStateDialog(() {});
                                            },
                                            icon: const Icon(Icons.delete)),
                                  ),
                                ),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          AppButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              label: "Back"),
                        ],
                      ),
              ),
            );
          });
        });
    setState(() {});
  }

  OrderItem? getOrderItem(int productId) {
    for (var item in selectedOrderItem) {
      if (item.productId == productId) {
        return item;
      }
    }
    return null;
  }

  void onAddItem(ProductData product) {
    selectedOrderItem.add(OrderItem(
        productId: product.id, productCount: 1, productData: product));
  }

  void onDeleteItem(int productId) {
    for (var i = 0; i < selectedOrderItem.length; i++) {
      if (selectedOrderItem[i].productId == productId) {
        selectedOrderItem.removeAt(i);
        break;
      }
    }
  }
}
