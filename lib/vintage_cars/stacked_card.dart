import 'dart:math';

import 'package:flutter/material.dart';

class StackedCard extends StatefulWidget {
  final Widget Function(int) itemBuilder;
  final int currentIndex;
  final double cornerRadius;
  final Duration? animationDuration;

  const StackedCard({
    super.key,
    required this.itemBuilder,
    this.currentIndex = 0,
    this.cornerRadius = 16,
    this.animationDuration,
  });

  @override
  State<StackedCard> createState() => _StackedCardState();
}

class _StackedCardState extends State<StackedCard>
    with TickerProviderStateMixin {
  late AnimationController _cardAnimator;
  final Map<int, (int, Widget)> _itemMap = {};

  @override
  void initState() {
    _cardAnimator = AnimationController(
      vsync: this,
      value: 0,
      lowerBound: 0,
      upperBound: 999,
    );
    super.initState();
  }

  @override
  void dispose() {
    _cardAnimator.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant StackedCard oldWidget) {
    _cardAnimator.animateTo(
      widget.currentIndex.toDouble(),
      curve: Curves.easeOutSine,
      duration: widget.animationDuration ?? const Duration(milliseconds: 550),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final currentCardIndex = _cardAnimator.value.toInt();
    _itemMap[currentCardIndex] =
        (currentCardIndex, widget.itemBuilder(currentCardIndex));

    // _cardAnimator.value = 0.1;
    return AnimatedBuilder(
      animation: _cardAnimator,
      builder: (context, child) => Stack(
        fit: StackFit.expand,
        children: [2, 1, 0, -1].map((idx) {
          final transition = _cardAnimator.value % 1;
          final i = idx + transition;

          final itemIndex = _cardAnimator.value.toInt();
          Widget content;
          if (idx <= 0) {
            final cachedItem = _itemMap[itemIndex];
            if (cachedItem != null && cachedItem.$1 == itemIndex) {
              content = cachedItem.$2;
            } else {
              content = widget.itemBuilder(itemIndex);
              _itemMap[itemIndex] = (itemIndex, content);
            }
          } else {
            content = Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(widget.cornerRadius)),
            );
          }

          Widget item;
          if (idx >= 0) {
            item = Transform(
              alignment: Alignment.topCenter,
              transform:
                  Matrix4.translationValues(0, i * -10, 0).scaled(pow(0.9, i)),
              child: content,
            );
          } else {
            item = Transform(
              alignment: Alignment.bottomLeft,
              transform: Matrix4.rotationZ(0.3 * i)..translate(i * 100, i * 30, 0),
              child: content,
            );
          }

          double opacity = 1;
          if (idx < 0 || idx > 1) {
            opacity = idx > 0 ? 1 - transition : transition;
          }

          if (idx > 0) {
            opacity *= pow(0.5, idx).toDouble();
          }

          return Opacity(
            opacity: opacity,
            child: item,
          );
        }).toList(growable: false),
      ),
    );
  }
}
