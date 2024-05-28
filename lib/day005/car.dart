class Car {
  String color = 'Black';
  int? manufactureYear;
  double? motorSpeed;

  Car({
    required this.color,
    this.manufactureYear,
    this.motorSpeed,
  });

  double? showMotorSpeed({double? speed}) {
    return speed;
  }

  void carInfo({required String brand, int? year}) {
    year = manufactureYear;
    print(
        "your Dream Car info are: $color $brand in $year style\nARE U SURE THE INFO IS CORRECT? [y/n]");
  }
}
