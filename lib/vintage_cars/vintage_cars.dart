import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uichallenge/vintage_cars/stacked_card.dart';

class VintageCars extends StatefulWidget {
  const VintageCars({super.key});

  @override
  State<VintageCars> createState() => _VintageCarsState();
}

class _VintageCarsState extends State<VintageCars> {
  static const startYear = 1959;

  ScrollController _scrollController = ScrollController();
  int _currentYear = startYear;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Timeline',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _currentYear += 1;
              });
            },
            child: Text("Test"),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.all(18.0),
                child: TimelineYear(
                  year: startYear + i,
                  isHighlighted: startYear + i == _currentYear,
                ),
              ),
            ),
          ),
          Expanded(
            child: StackedCard(
              itemBuilder: (i) => _CardItem(content: 'Year ${startYear + i}'),
              currentIndex: _currentYear - startYear,
            ),
          ),
        ],
      ),
    );
  }
}

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

class _CardItem extends StatelessWidget {
  final String content;

  const _CardItem({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.black54,
      elevation: 10,
      child: Center(child: Text(content)),
    );
  }
}
