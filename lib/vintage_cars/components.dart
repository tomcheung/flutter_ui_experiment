
import 'dart:collection';

import 'package:flutter/material.dart';

class TimelineYear extends StatelessWidget {
  static List<Shadow> outlineShadow = outlinedText(
    strokeWidth: 1,
    strokeColor: Colors.black45,
    precision: 1,
  );
  final int year;
  final bool isHighlighted;

  const TimelineYear(
      {super.key, required this.year, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    final color = isHighlighted ? Colors.black : Colors.white;
    return Center(
      child: AnimatedDefaultTextStyle(
        style: TextStyle(
          color: color,
          fontSize: 27,
          shadows: outlineShadow,
        ),
        duration: const Duration(milliseconds: 220),
        child: Text(year.toString()),
      ),
    );
  }

  static List<Shadow> outlinedText(
      {double strokeWidth = 2,
        Color strokeColor = Colors.black,
        int precision = 5}) {
    Set<Shadow> result = HashSet();
    for (int x = 1; x < strokeWidth + precision; x++) {
      for (int y = 1; y < strokeWidth + precision; y++) {
        double offsetX = x.toDouble();
        double offsetY = y.toDouble();
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
      }
    }
    return result.toList();
  }
}
