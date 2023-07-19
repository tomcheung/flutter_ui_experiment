import 'package:flutter/material.dart';
import 'package:uichallenge/shopping_cart/product.dart';

class BottomShoppingCartListItem extends StatelessWidget {
  final ShoppingCartItem cartItem;

  const BottomShoppingCartListItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final imageUrl = cartItem.product.imageUrl;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            foregroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('${cartItem.quantity}  x'),
          ),
          Expanded(child: Text(cartItem.product.name)),
          Text(cartItem.product.price.toString()),
        ],
      ),
    );
  }
}

class BottomShoppingCartList extends StatelessWidget {
  const BottomShoppingCartList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    BottomShoppingCartListItem(
                      cartItem: ShoppingCartItem(
                        product: Product.sample.first,
                        quantity: 1,
                      ),
                    ),
                    BottomShoppingCartListItem(
                      cartItem: ShoppingCartItem(
                        product: Product.sample.first,
                        quantity: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    backgroundColor:
                        MaterialStateProperty.all(theme.colorScheme.primary),
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
