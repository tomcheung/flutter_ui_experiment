import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'product.dart';

final shoppingCartProvider = StateProvider<List<ShoppingCartItem>>((ref) => []);

final shoppingCartItemCountProvider =
    Provider<int>((ref) => ref.watch(shoppingCartProvider).length);

final shoppingCartTotalProvider = Provider<num>((ref) {
  final shoppingCart = ref.watch(shoppingCartProvider);

  return shoppingCart.fold(
      0,
      (value, shoppingCartItem) =>
          (value + shoppingCartItem.product.price * shoppingCartItem.quantity));
});
