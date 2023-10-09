import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_experiment/shopping_cart/shopping_cart_detail.dart';

import 'product.dart';
import 'product_cart_provider.dart';
import 'shopping_bottom_cart.dart';

class ShoppingCartList extends StatelessWidget {
  const ShoppingCartList({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          theme: ThemeData.from(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xfffbba3f),
                primary: const Color(0xfffbba3f),
              ),
              useMaterial3: true,
              textTheme: const TextTheme(
                  displayLarge:
                      TextStyle(fontSize: 32, fontWeight: FontWeight.w500))),
          home: ShoppingCartListContent(rootContext: context)),
    );
  }
}

class ShoppingCartListContent extends StatefulWidget {
  final BuildContext rootContext;

  const ShoppingCartListContent({super.key, required this.rootContext});

  @override
  State<ShoppingCartListContent> createState() =>
      _ShoppingCartListContentState();
}

class _ShoppingCartListContentState extends State<ShoppingCartListContent>
    with SingleTickerProviderStateMixin {
  static const double bottomCartHeight = 450;
  late AnimationController _verticalOffsetAnimation;

  double _beginOffset = 0;

  @override
  void initState() {
    _verticalOffsetAnimation = AnimationController(
      vsync: this,
      lowerBound: -bottomCartHeight,
      upperBound: 0,
      value: 0,
      duration: const Duration(milliseconds: 250),
    );
    super.initState();
  }

  @override
  void dispose() {
    _verticalOffsetAnimation.dispose();
    super.dispose();
  }

  Widget _buildBottomHeader(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
          animation: _verticalOffsetAnimation,
          child: const BottomShortCart(),
          builder: (context, child) {
            return Opacity(
              opacity: 1 + _verticalOffsetAnimation.value / bottomCartHeight,
              child: child,
            );
          }),
      onTap: () {
        final double targetOffset =
            _verticalOffsetAnimation.value == 0 ? -bottomCartHeight : 0;
        _verticalOffsetAnimation.animateTo(targetOffset,
            curve: Curves.easeInOut);
      },
      onVerticalDragStart: (e) {
        _beginOffset = e.globalPosition.dy - _verticalOffsetAnimation.value;
      },
      onVerticalDragUpdate: (e) {
        final double offset = min(0, e.globalPosition.dy - _beginOffset);
        _verticalOffsetAnimation.value = offset;
      },
      onVerticalDragEnd: (e) {
        const curve = Curves.easeInOut;
        if (e.velocity.pixelsPerSecond.dy < -10) {
          _verticalOffsetAnimation.animateTo(-bottomCartHeight, curve: curve);
        } else if (e.velocity.pixelsPerSecond.dy > 10) {
          _verticalOffsetAnimation.animateTo(0, curve: curve);
        } else if (_verticalOffsetAnimation.value < -bottomCartHeight / 2) {
          _verticalOffsetAnimation.animateTo(-bottomCartHeight, curve: curve);
        } else {
          _verticalOffsetAnimation.animateTo(0, curve: curve);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        LayoutBuilder(
          builder: (_, c) => AnimatedBuilder(
            animation: _verticalOffsetAnimation,
            builder: (context, child) {
              final topOffset =
                  c.maxHeight + _verticalOffsetAnimation.value - 80;
              return Transform.translate(
                offset: Offset(0, topOffset),
                child: SizedBox(
                  height: bottomCartHeight,
                  child: Opacity(
                    opacity: -_verticalOffsetAnimation.value / bottomCartHeight,
                    child: child ?? const Placeholder(),
                  ),
                ),
              );
            },
            child: const Material(
              color: Colors.black,
              child: BottomShoppingCartList(),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _verticalOffsetAnimation,
          builder: (context, child) => Transform.translate(
            offset: Offset(0, _verticalOffsetAnimation.value),
            child: child,
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.of(widget.rootContext).pop();
                },
              ),
              backgroundColor: const Color(0xfff7f4ef),
              title: const Text('Pasta & Noodles'),
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xfff7f4ef),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(42),
                          bottomRight: Radius.circular(42),
                        ),
                      ),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.56,
                        padding: const EdgeInsets.all(8),
                        children: Product.sample
                            .map((e) => ShoppingCartItemCard(product: e))
                            .toList(growable: false),
                      ),
                    ),
                  ),
                  _buildBottomHeader(context)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomShortCart extends ConsumerWidget {
  const BottomShortCart({super.key});

  Widget _buildCartList(BuildContext context, WidgetRef ref) {
    final shoppingItems = ref.watch(shoppingCartProvider);

    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        children: shoppingItems
            .map((s) => Hero(
                  tag: 'cart-image-${s.product.name}',
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      foregroundImage:
                          AssetImage(s.product.imageAssetName ?? ''),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCount = ref.watch(shoppingCartItemCountProvider);
    final theme = Theme.of(context);
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            const Text(
              'Cart',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            _buildCartList(context, ref),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: theme.colorScheme.primary),
              height: 45,
              width: 45,
              alignment: Alignment.center,
              child: Text(
                itemCount.toString(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ShoppingCartItemCard extends StatelessWidget {
  final Product product;

  const ShoppingCartItemCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.imageAssetName;
    final style = Theme.of(context);
    return InkResponse(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => ShoppingCardDetail(
                  product: product,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: imageUrl != null
                  ? Hero(
                      tag:
                          '${ShoppingCardDetail.heroTagPrefix}-${product.name}',
                      child: Image.asset(imageUrl))
                  : Container(color: Colors.grey),
            ),
            const Spacer(),
            Text(
              '\$${product.price}',
              style: style.textTheme.headlineMedium?.apply(fontWeightDelta: 2),
            ),
            Text(product.name),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
