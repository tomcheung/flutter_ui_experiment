final class CarInfo {
  int year;
  String name;

  CarInfo({
    required this.name,
    required this.year
  });

  static CarInfo chevroletCorvetteC3 = CarInfo(name: 'Chevrolet Corvette C3', year: 1961);
}
