import 'dart:io';

import 'car.dart';
import 'sportCar.dart';
import 'truck.dart';

void main() {
  print('Welcome to Cars World! To build your dream car');
  print('========================================');
  int choice = 0;

  do {
    print('what type of car do u want?');
    print('========================================');

    print('1. family car');
    print('2. sport car');
    print('3. truck');
    print('4. quite');
    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        famCar();
      case 2:
        sportCar();
      case 3:
        truck();
      case 4:
        print('Thank u for choosing Cars World! See u soon');
      default:
        print('invalid choice [choices must be between 1-4]');
    }
  } while (choice != 4);
}

void famCar() {
  print('family guy Wonderful! please answer the following questions\n');
  String isCarInfoCorrect = '';
  while (isCarInfoCorrect != 'y') {
    print('what color do u want it to be?');
    String userColor = stdin.readLineSync()!;
    double userMotorSpeed;
    do {
      print('what is preferred max motor speed km/h? [200 - 320]');
      userMotorSpeed = double.parse(stdin.readLineSync()!);
      if (userMotorSpeed > 320 || userMotorSpeed < 200) {
        print('PLEASE enter valid motor speed!!!');
        continue;
      }
      print(
          'what brand and manufacture year do u prefer for the other details of your dream car?');
      String userBrand = stdin.readLineSync()!;
      int userManufactureYear;
      do {
        userManufactureYear = int.parse(stdin.readLineSync()!);
        if (userManufactureYear < 1960 || userManufactureYear > 2030) {
          print('PLEASE enter valid manufacture year!!!');
          continue;
        }
      } while (userManufactureYear < 1960 || userManufactureYear > 2030);
      Car car = Car(
        color: userColor,
        motorSpeed: userMotorSpeed,
        manufactureYear: userManufactureYear,
      )..carInfo(brand: userBrand, year: userManufactureYear);
      isCarInfoCorrect = stdin.readLineSync()!;
      if (isCarInfoCorrect != 'y')
        print('PLEASE enter the correct info of your car\n');
    } while (userMotorSpeed > 320 || userMotorSpeed < 200);
  }
  print("Happy to serve u!\n");
}

void sportCar() {
  print('Sports man Awesome! please answer the following questions\n');
  String isCarInfoCorrect = '';
  while (isCarInfoCorrect != 'y') {
    print('what color do u want it to be?');
    String userColor = stdin.readLineSync()!;

    double userMotorSpeed;
    do {
      print(
          'what is preferred motor speed? [0 - 100 meters] [consider the racing capability]');
      userMotorSpeed = double.parse(stdin.readLineSync()!);
      if (userMotorSpeed > 100 || userMotorSpeed < 1) {
        print('PLEASE enter valid motor speed!!!');
        continue;
      }

      double userAccSpeed;
      do {
        print(
            'what is preferred acceleration speed per second? [0 - 100 seconds]');
        userAccSpeed = double.parse(stdin.readLineSync()!);
        if (userAccSpeed > 100 || userAccSpeed < 1) {
          print('PLEASE enter valid Acceleration speed!!!');
          continue;
        }
        print(
            'what brand and manufacture year do u prefer for the other details of your dream car?');
        String userBrand = stdin.readLineSync()!;

        int userManufactureYear;
        do {
          userManufactureYear = int.parse(stdin.readLineSync()!);
          if (userManufactureYear < 1960 || userManufactureYear > 2030) {
            print('PLEASE enter valid manufacture year!!!');
            continue;
          }
          print('what is the minimum cost for u?');
          double userCost = double.parse(stdin.readLineSync()!);
          SportCar scar = SportCar(
            color: userColor,
            manufactureYear: userManufactureYear,
            brand: userBrand,
            acceleration: userAccSpeed,
            cost: userCost,
          )
            ..calcAcceleration(
              initiSpeed: 0,
              finalSpeed: userMotorSpeed,
              time: userAccSpeed,
            )
            ..carInfo(brand: userBrand, year: userManufactureYear);
          isCarInfoCorrect = stdin.readLineSync()!;
          if (isCarInfoCorrect != 'y')
            print('PLEASE enter the correct info of your car\n');
        } while (userManufactureYear < 1960 || userManufactureYear > 2030);
      } while (userAccSpeed > 100 || userAccSpeed < 1);
    } while (userMotorSpeed > 320 || userMotorSpeed < 200);
  }
  print("Happy to serve u!\n");
}

void truck() {
  print('Tough man Cool! please answer the following questions\n');
  String isCarInfoCorrect = '';
  while (isCarInfoCorrect != 'y') {
    print('what color do u want it to be?');
    String userColor = stdin.readLineSync()!;
    double userMotorSpeed;
    do {
      print('what is preferred max motor speed km/h? [200 - 320]');
      userMotorSpeed = double.parse(stdin.readLineSync()!);
      if (userMotorSpeed > 320 || userMotorSpeed < 200) {
        print('PLEASE enter valid motor speed!!!');
        continue;
      }

      double userWeight;
      do {
        print(
            'what is the preferred weight that can be carried in kg? [400 - 1000]');
        userWeight = double.parse(stdin.readLineSync()!);
        if (userWeight > 1000 || userMotorSpeed < 400) {
          print('PLEASE enter weight from the rang 100 - 1000 !!!');
          continue;
        }
        print(
            'what brand and manufacture year do u prefer for the other details of your dream car?');
        String userBrand = stdin.readLineSync()!;
        int userManufactureYear;
        do {
          userManufactureYear = int.parse(stdin.readLineSync()!);
          if (userManufactureYear < 1960 || userManufactureYear > 2030) {
            print('PLEASE enter valid manufacture year!!!');
            continue;
          }
        } while (userManufactureYear < 1960 || userManufactureYear > 2030);
        print('what is the minimum cost for u?');
        double userCost = double.parse(stdin.readLineSync()!);
        Truck tcar = Truck(
            color: userColor,
            manufactureYear: userManufactureYear,
            weight: userWeight,
            cost: userCost,
            motorSpeed: userMotorSpeed)
          ..truckWeightSpeed(weight: userWeight, speed: userMotorSpeed)
          ..carInfo(brand: userBrand, year: userManufactureYear);
        isCarInfoCorrect = stdin.readLineSync()!;
        if (isCarInfoCorrect != 'y')
          print('PLEASE enter the correct info of your car\n');
      } while (userWeight > 1000 || userMotorSpeed < 400);
    } while (userMotorSpeed > 320 || userMotorSpeed < 200);
  }
  print("Be safe!\n");
}
