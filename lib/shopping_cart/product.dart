class Product {
  final String name;
  final num price;
  final String description;
  final String? imageUrl;

  const Product({
    required this.name,
    required this.price,
    required this.description,
    this.imageUrl,
  });

  static const List<Product> sample = [
    Product(
        name: 'Product A',
        price: 7.99,
        description: 'description',
        imageUrl:
            'https://d262h05t49kych.cloudfront.net/i2brehz4c63yd9tv4pg06zwnvl3e'),
    Product(name: 'Product B', price: 7.99, description: 'description'),
  ];
}

class ShoppingCartItem {
  final Product product;
  final int quantity;

  ShoppingCartItem({
    required this.product,
    required this.quantity,
  });
}
