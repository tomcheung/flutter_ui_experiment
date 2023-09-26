import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_ui_experiment/vintage_cars/car_info.dart';

import 'components.dart';

class Handle extends StatelessWidget {
  final Color color;

  const Handle({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: color),
      width: 32,
      height: 5,
    );
  }
}

class TopCarInfo extends StatelessWidget {
  final bool showHandle;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final bool darkBackground;
  final CarInfo carInfo;

  const TopCarInfo({
    super.key,
    required this.carInfo,
    this.darkBackground = true,
    this.showHandle = true,
    this.onVerticalDragUpdate,
  });

  Widget _buildHandle(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: onVerticalDragUpdate,
      child: const Center(child: Handle(color: Colors.grey)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQueryData.fromView(View.of(context)).padding.top;

    final color = darkBackground ? Colors.blue.shade50 : Colors.black;
    return Container(
      color: darkBackground ? Colors.black : Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: topInset, left: 24, right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 42,
              child: showHandle
                  ? _buildHandle(context)
                  : null,
            ),
            Row(
              children: [
                Text(
                  carInfo.year.toString(),
                  style: GoogleFonts.cardo(
                      textStyle: TextStyle(fontSize: 62, color: color)),
                ),
                Text(
                  '-${carInfo.year + 1}',
                  style: GoogleFonts.cardo(
                      textStyle: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    shadows: darkBackground
                        ? TimelineYear.outlinedText(
                            precision: 2,
                            strokeWidth: 1,
                            strokeColor: color.withAlpha(50))
                        : null,
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child:
                  Image.asset('images/vintage_cars/chevrolet_corvette_c3.png'),
            ),
            Text(carInfo.name,
                style: GoogleFonts.dmSerifDisplay(
                    textStyle: TextStyle(fontSize: 45, color: color)))
          ],
        ),
      ),
    );
  }
}
