import 'package:flutter/material.dart';
import 'package:uichallenge/vintage_cars/car_info.dart';

import 'components.dart';

class Handle extends StatelessWidget {
  final Color color;
  const Handle({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: color),
      width: 32,
      height: 5,
    );
  }
}

class CarInfoCard extends StatelessWidget {
  final bool darkBackground;
  final CarInfo carInfo;

  const CarInfoCard({super.key, required this.carInfo, this.darkBackground = true});

  @override
  Widget build(BuildContext context) {
    final color = darkBackground ? Colors.blue.shade50 : Colors.black;
    return Card(
      color: darkBackground ? Colors.black : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Text(
                  carInfo.year.toString(),
                  style: TextStyle(fontSize: 62, color: color),
                ),
                Text(
                  '-${carInfo.year + 1}',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    shadows: darkBackground ? TimelineYear.outlinedText(
                        precision: 2,
                        strokeWidth: 1,
                        strokeColor: color.withAlpha(50)) : null,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child:
                  Image.asset('images/vintage_cars/chevrolet_corvette_c3.png'),
            ),
            Text(carInfo.name, style: TextStyle(fontSize: 45, color: color))
          ],
        ),
      ),
    );
  }
}
