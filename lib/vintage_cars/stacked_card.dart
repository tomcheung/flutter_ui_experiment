import 'dart:math';

import 'package:flutter/material.dart';

class StackedCard extends StatefulWidget {
  final Widget Function(int) itemBuilder;
  final int currentIndex;
  final Duration? animationDuration;

  const StackedCard(
      {super.key,
      required this.itemBuilder,
      this.currentIndex = 0,
      this.animationDuration});

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
      curve: Curves.easeOut,
      duration: widget.animationDuration ?? const Duration(milliseconds: 250),
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final currentCardIndex = _cardAnimator.value.toInt();
    _itemMap[currentCardIndex] = (currentCardIndex, widget.itemBuilder(currentCardIndex));


    return AnimatedBuilder(
      animation: _cardAnimator,
      builder: (context, child) => Stack(
        fit: StackFit.expand,
        children: [2, 1, 0, -1].map((idx) {
          final transition = _cardAnimator.value % 1;
          final i = idx + transition;

          final itemIndex = _cardAnimator.value.toInt();
          var content = _itemMap[itemIndex];
          if (content == null || content.$1 != itemIndex) {
            content = (itemIndex, widget.itemBuilder(itemIndex));
            _itemMap[itemIndex] = content;
          }

          final item = Transform(
            alignment: Alignment.topCenter,
            transform:
                Matrix4.translationValues(0, i * -10, 0).scaled(pow(0.9, i)),
            child: content.$2,
          );

          double opacity = 1;
          if (idx < 0 || idx > 1) {
            opacity = idx > 0 ? 1 - transition : transition;
          }

          if (idx > 0) {
            opacity *= pow(0.9, idx).toDouble();
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
