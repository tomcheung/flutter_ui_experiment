import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class StackedCard extends StatefulWidget {
  final Widget Function(int) itemBuilder;
  final Function(int)? onIndexChange;
  final double cornerRadius;
  final Duration animationDuration;

  const StackedCard({
    super.key,
    required this.itemBuilder,
    this.cornerRadius = 16,
    this.animationDuration = const Duration(milliseconds: 550),
    this.onIndexChange
  });

  @override
  State<StackedCard> createState() => _StackedCardState();
}

class _StackedCardState extends State<StackedCard>
    with TickerProviderStateMixin {
  late AnimationController _cardAnimator;
  (double, double) _dragBeginInfo = (0, 0);
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (d) {
        _dragBeginInfo = (_cardAnimator.value, d.localPosition.dx);
      },
      onHorizontalDragUpdate: (d) {
        final dragProgress =
            clampDouble((d.localPosition.dx - _dragBeginInfo.$2) / 300, -1, 1);
        _cardAnimator.value = _dragBeginInfo.$1 - dragProgress;
      },
      onHorizontalDragEnd: (d) {
        _cardAnimator.animateTo(_cardAnimator.value.roundToDouble(),
            duration: widget.animationDuration, curve: Curves.easeOutCubic);
        widget.onIndexChange?.call(_cardAnimator.value.round());
      },
      child: AnimatedBuilder(
        animation: _cardAnimator,
        builder: (context, child) => Stack(
          fit: StackFit.expand,
          children: [3, 2, 1, 0].map((idx) {
            final transition = _cardAnimator.value % 1;
            final i = idx - transition;

            final itemIndex = _cardAnimator.value.toInt() + idx;
            Widget content;
            if (idx <= 1) {
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
                  borderRadius: BorderRadius.circular(widget.cornerRadius),
                ),
              );
            }

            Widget item;
            if (idx > 0) {
              item = Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.translationValues(0, i * -10, 0)
                    .scaled(pow(0.9, i)),
                child: content,
              );
            } else {
              item = Transform(
                alignment: Alignment.bottomLeft,
                origin: const Offset(-30, 300),
                transform:
                    Matrix4.rotationZ(0.3 * i), //..translate(i * 100, 0, 0),
                child: OverflowBox(
                  alignment: Alignment.topCenter,
                  maxHeight: 900,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(widget.cornerRadius),
                    ),
                    child: content,
                  ),
                ),
              );
            }

            double opacity = 1;
            if (idx == 3) {
              opacity = pow(0.5, 3) * transition;
            } else if (idx > 0) {
              opacity *= pow(0.5, i).toDouble();
            } else {
              opacity = 1 - transition;
            }

            return Opacity(
              opacity: opacity,
              child: item,
            );
          }).toList(growable: false),
        ),
      ),
    );
  }
}
