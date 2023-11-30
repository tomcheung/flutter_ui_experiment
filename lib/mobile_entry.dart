import 'package:flutter/material.dart';
import 'main.dart';

class MobileEntry extends StatelessWidget {
  final List<DemoItem> items;
  const MobileEntry({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: _DemoList(items: items),
    );
  }
}

class _DemoList extends StatelessWidget {
  final List<DemoItem> items;
  const _DemoList({super.key, required this.items});

  Widget _buildItem(BuildContext context, DemoItem item) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: item.builder));
        },
        trailing: const Icon(Icons.arrow_forward),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter UI experiment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: items
              .map((i) => _buildItem(context, i))
              .toList(growable: false),
        ),
      ),
    );
  }
}
