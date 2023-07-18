class Product {
  final String name;
  final num price;
  final String description;

  const Product({
    required this.name,
    required this.price,
    required this.description,
  });

  static const List<Product> sample = [
    Product(name: 'Product A', price: 7.99, description: 'description'),
    Product(name: 'Product B', price: 7.99, description: 'description'),
  ];
}
