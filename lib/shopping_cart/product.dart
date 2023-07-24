import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String name,
    required num price,
    required String description,
    String? imageAssetName,
  }) = _Product;

  static const List<Product> sample = [
    Product(
        name: 'Seggiano Organic Tagflatelle',
        price: 7.99,
        description: 'description',
        imageAssetName: 'images/shopping_cart/pasta.jpg'),
    Product(
      name: 'Rummo Fusilli No 48 Pasta',
      price: 14.99,
      description: 'description',
      imageAssetName: 'images/shopping_cart/rummo_fusilli_no_48.jpg',
    ),
  ];
}

@freezed
class ShoppingCartItem with _$ShoppingCartItem {
  const factory ShoppingCartItem({
    required Product product,
    required int quantity,
  }) = _ShoppingCartItem;
}
