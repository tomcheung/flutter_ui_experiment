import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_experiment/shopping_cart/product.dart';
import 'package:flutter_ui_experiment/shopping_cart/product_cart_provider.dart';

class BottomShoppingCartListItem extends StatelessWidget {
  final ShoppingCartItem cartItem;

  const BottomShoppingCartListItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final imageUrl = cartItem.product.imageAssetName;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            foregroundImage: imageUrl != null ? AssetImage(imageUrl) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('${cartItem.quantity}  x'),
          ),
          Expanded(child: Text(cartItem.product.name)),
          Text(
            '\$${cartItem.product.price}',
            style: const TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}

class BottomShoppingCartList extends ConsumerWidget {
  const BottomShoppingCartList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final shoppingCart = ref.watch(shoppingCartProvider);
    final total = ref.watch(shoppingCartTotalProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.white),
        child: ClipRect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Cart',
                style: theme.textTheme.headlineLarge?.merge(
                  const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: ListView(
                  children: shoppingCart
                      .map((i) => BottomShoppingCartListItem(
                            cartItem: ShoppingCartItem(
                              product: i.product,
                              quantity: i.quantity,
                            ),
                          ))
                      .toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$$total',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
