import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_experiment/mobile_entry.dart';
import 'package:flutter_ui_experiment/web_entry.dart';
import 'animated_todo_list/animated_todo_list.dart';
import 'music_player/music_player.dart';
import 'shopping_cart/shopping_cart_list.dart';
import 'vintage_cars/vintage_cars.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final List<DemoItem> items = [
    DemoItem(
        name: 'Animated TODO list',
        builder: (context) => const AnimatedTodoList()),
    DemoItem(
        name: 'Shopping cart', builder: (context) => const ShoppingCartList()),
    DemoItem(name: 'Vintage cars', builder: (context) => const VintageCars()),
    DemoItem(name: 'Music Player', builder: (context) => const MusicPlayer()),
  ];

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebEntry(items: items);
    } else {
      return MobileEntry(items: items);
    }
  }
}

class DemoItem {
  final String name;
  final WidgetBuilder builder;

  const DemoItem({required this.name, required this.builder});
}
