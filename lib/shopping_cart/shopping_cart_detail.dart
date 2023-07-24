import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product.dart';
import 'product_cart_provider.dart';

class Stepper extends StatelessWidget {
  final Function(int) onValueChange;
  final int value;

  const Stepper({super.key, required this.onValueChange, required this.value});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                if (value > 0) {
                  onValueChange(value - 1);
                }
              },
              icon: const Icon(Icons.remove)),
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          IconButton(
              onPressed: () {
                onValueChange(value + 1);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}

class ShoppingCardDetail extends ConsumerStatefulWidget {
  static const heroTagPrefix = 'product-image';
  final Product product;

  const ShoppingCardDetail({required this.product, super.key});

  @override
  ConsumerState<ShoppingCardDetail> createState() => _ShoppingCardDetailState();
}

class _ShoppingCardDetailState extends ConsumerState<ShoppingCardDetail> {
  var _heroTag = '';
  int _qty = 1;

  @override
  void initState() {
    _heroTag = '${ShoppingCardDetail.heroTagPrefix}-${widget.product.name}';
    super.initState();
  }

  void _addProduct() {
    final newItem = ShoppingCartItem(product: widget.product, quantity: _qty);
    final shoppingCardState = ref.read(shoppingCartProvider.notifier);

    var newShoppingCartItems = List.of(shoppingCardState.state);
    final existProductIndex = shoppingCardState.state
        .indexWhere((element) => element.product == widget.product);
    if (existProductIndex != -1) {
      final newQty = newShoppingCartItems[existProductIndex].quantity + _qty;
      newShoppingCartItems[existProductIndex] =
          newShoppingCartItems[existProductIndex].copyWith(quantity: newQty);
    } else {
      newShoppingCartItems.add(newItem);
    }
    shoppingCardState.state = newShoppingCartItems;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = widget.product.imageAssetName;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              children: [
                SizedBox(
                  height: 300,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: imageUrl != null
                        ? Hero(tag: _heroTag, child: Image.asset(imageUrl))
                        : const Placeholder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.product.name,
                  style: theme.textTheme.titleLarge,
                ),
                Text(widget.product.description),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Stepper(
                          onValueChange: (v) {
                            setState(() => _qty = v);
                          },
                          value: _qty,
                        ),
                      ),
                      const Spacer(),
                      Text('\$${widget.product.price}',
                          style: theme.textTheme.titleLarge),
                    ],
                  ),
                ),
                Text('About the product', style: theme.textTheme.titleMedium)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  padding: const EdgeInsets.all(4),
                  icon: const Icon(Icons.favorite_border),
                ),
                const SizedBox(width: 32),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: theme.colorScheme.primary),
                    onPressed: () {
                      _addProduct();
                      setState(() {
                        _heroTag = 'cart-image-${widget.product.name}';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add to cart'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
