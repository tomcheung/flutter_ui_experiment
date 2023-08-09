import 'package:flutter/material.dart';
import 'package:uichallenge/vintage_cars/car_info.dart';

class CarDetailInfo extends StatelessWidget {
  final CarInfo info;

  const CarDetailInfo({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 14);
    const valueStyle = TextStyle(fontSize: 20);
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Production', style: titleStyle),
                  Text('${info.year}-${info.year + 1}', style: valueStyle),
                ],
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Class', style: titleStyle),
                    Text('Sportcars', style: valueStyle),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
          Container(height: 1, color: Colors.grey),
          const Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: Text('The third generation Carvette'),
          )
        ],
      ),
    );
  }
}
