import 'package:flutter/material.dart';
import 'package:uichallenge/vintage_cars/stacked_card.dart';

class VintageCars extends StatefulWidget {
  const VintageCars({super.key});

  @override
  State<VintageCars> createState() => _VintageCarsState();
}

class _VintageCarsState extends State<VintageCars> {
  int item = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                item += 1;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              setState(() {
                item -= 1;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StackedCard(
          itemBuilder: (i) => _CardItem(content: 'Page $i'),
          currentIndex: item,
        ),
      ),
    );
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
