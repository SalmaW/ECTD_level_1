class Product {
  String name;
  double price;
  String barcode;

  Product(this.name, this.price, this.barcode);
}

double calculateTotalPrice(List<Product> products) {
  double totalPrice = 0;
  for (var product in products) {
    totalPrice += product.price;
  }
  return totalPrice;
}

void main() {
  // Create a list of 7 products with different prices
  List<Product> products = [
    Product('Product 1', 10.99, '123456'),
    Product('Product 2', 20.49, '234567'),
    Product('Product 3', 5.99, '345678'),
    Product('Product 4', 15.79, '456789'),
    Product('Product 5', 8.99, '567890'),
    Product('Product 6', 12.99, '678901'),
    Product('Product 7', 30.99, '789012'),
  ];

  // Calculate total price of all products
  double total = calculateTotalPrice(products);
  print('Total price of all products: \$${total.toStringAsFixed(2)}');
}
