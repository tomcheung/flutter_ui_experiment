import 'package:flutter/material.dart';
import 'music_player/music_player.dart';
import 'vintage_cars/vintage_cars.dart';
import 'shopping_cart/shopping_cart_list.dart';
import 'animated_todo_list/animated_todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const DemoList(),
    );
  }
}

class DemoList extends StatelessWidget {
  const DemoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Flutter UI experiment'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              child: ListTile(
                title: const Text('Animated TODO list'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AnimatedTodoList()));
                },
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Shopping cart'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ShoppingCartList()));
                },
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Vintage cars'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VintageCars()));
                },
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Music Player'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MusicPlayer()));
                },
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
