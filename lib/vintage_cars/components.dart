import 'dart:collection';

import 'package:flutter/material.dart';

class OutlineText extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Color strokeColor;
  final TextStyle textStyle;

  const OutlineText({
    super.key,
    required this.textStyle,
    required this.text,
    required this.strokeColor,
    this.strokeWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    final outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 1
      ..color = strokeColor;

    return Stack(
      children: <Widget>[
        Text(text, style: textStyle.copyWith(foreground: outlinePaint)),
        Text(text, style: textStyle),
      ],
    );
  }
}

class TimelineYear extends StatelessWidget {
  final int year;
  final bool isHighlighted;

  const TimelineYear(
      {super.key, required this.year, this.isHighlighted = false});

  @override
  Widget build(BuildContext context) {
    final color = isHighlighted ? Colors.black : Colors.white;
    const double fontSize = 28;

    return OutlineText(
      text: year.toString(),
      textStyle: TextStyle(color: color, fontSize: fontSize),
      strokeColor: Colors.black,
      strokeWidth: isHighlighted ? 0 : 1,
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
