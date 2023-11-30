import 'package:device_frame/device_frame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class _MobileScrollingBehaviour extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}

class WebEntry extends StatefulWidget {
  final List<DemoItem> items;
  const WebEntry({super.key, required this.items});

  @override
  State<WebEntry> createState() => _WebEntryState();
}

class _WebEntryState extends State<WebEntry> {
  late DemoItem selectedItem;

  @override
  void initState() {
    selectedItem = widget.items.first;
    super.initState();
  }

  Widget _buildItem(BuildContext context, DemoItem item) {
    return SizedBox(
      height: 48,
      child: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        ),
        child: Text(item.name),
        onPressed: () {
          setState(() {
            selectedItem = item;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      color: Colors.black,
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter UI experiment')),
        body: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: 300,
                child: ListView(
                  children: widget.items
                      .map((i) => _buildItem(context, i))
                      .toList(growable: false),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DeviceFrame(
                  device: Devices.ios.iPhone13,
                  screen: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    scrollBehavior: _MobileScrollingBehaviour(),
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      colorScheme:
                          ColorScheme.fromSeed(seedColor: Colors.blueAccent),
                      useMaterial3: true,
                    ),
                    home: MediaQuery(
                        data: const MediaQueryData(
                            padding: EdgeInsets.only(top: 47, bottom: 34)),
                        child: selectedItem.builder(context)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
