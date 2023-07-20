import 'package:flutter/material.dart';
import 'product.dart';

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

class ShoppingCardDetail extends StatefulWidget {
  final Product product;

  const ShoppingCardDetail({required this.product, super.key});

  @override
  State<ShoppingCardDetail> createState() => _ShoppingCardDetailState();
}

class _ShoppingCardDetailState extends State<ShoppingCardDetail> {
  var heroTag = 'product-image';
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = widget.product.imageUrl;
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
                        ? Hero(tag: heroTag, child: Image.network(imageUrl))
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
                    onPressed: () {
                      setState(() {
                        heroTag = 'cart-image';
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
