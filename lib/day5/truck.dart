import 'sportCar.dart';

class Truck extends SportCar {
  double? weight;

  Truck({
    required super.color,
    super.manufactureYear,
    super.motorSpeed,
    super.cost,
    this.weight,
  });

  String truckWeightSpeed({double? weight, double? speed}) {
    double finalSpeed = weight! / speed!;
    return 'NOTE THAT: the speed will decrease in speed\nso the final speed with the entered weight is: $finalSpeed';
  }

  @override
  void carInfo({required String brand, int? year}) {
    print(
        "your Dream Car info are: $color $brand in $year style that can take $weight kg and $cost\$\nARE U SURE THE INFO IS CORRECT? [y/n]");
  }
}
