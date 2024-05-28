import 'car.dart';

class SportCar extends Car {
  String? brand;
  double? cost;
  double? acceleration;

  SportCar({
    required super.color,
    super.manufactureYear,
    super.motorSpeed,
    this.brand,
    this.acceleration,
    this.cost,
  });

  double? calcAcceleration(
      {double? initiSpeed, double? finalSpeed, double? time}) {
    motorSpeed = finalSpeed;
    finalSpeed = initiSpeed! + motorSpeed!;
    double accSpeed = (finalSpeed - initiSpeed) / time!;
    return accSpeed;
  }

  @override
  void carInfo({required String brand, int? year}) {
    print(
        "your Dream Car info are: $color $brand in $year style with $acceleration m/s and $cost\$\nARE U SURE THE INFO IS CORRECT? [y/n]");
  }
}
