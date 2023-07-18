import 'package:flutter/material.dart';

import 'product.dart';

class ShoppingCartList extends StatefulWidget {
  const ShoppingCartList({super.key});

  @override
  State<ShoppingCartList> createState() => _ShoppingCartListState();
}

class _ShoppingCartListState extends State<ShoppingCartList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff7f4ef),
        title: Text('Pasta & Noodles'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xfff7f4ef),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(42),
                    bottomRight: Radius.circular(42)),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                children: Product.sample
                    .map((e) => ShoppingCartItem(product: e))
                    .toList(growable: false),
              ),
            ),
          ),
          BottomShortCart()
        ],
      ),
    );
  }
}

class BottomShortCart extends StatelessWidget {
  const BottomShortCart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Text(
              'Cart',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(),
            ),
            Spacer(),
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.orange),
              height: 45,
              width: 45,
              alignment: Alignment.center,
              child: Text('0', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
            )
          ],
        ),
      ),
    );
  }
}

class ShoppingCartItem extends StatelessWidget {
  final Product product;

  const ShoppingCartItem({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(color: Colors.grey),
          ),
          Spacer(),
          Text(
            '\$${product.price}',
            style: style.textTheme.headlineMedium?.apply(fontWeightDelta: 2),
          ),
          Text(product.name),
          Text(product.description),
        ],
      ),
    );
  }
}
