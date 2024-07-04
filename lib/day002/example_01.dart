import 'dart:io';

void main() {
  // example 1

  print('pleas enter your weight: ');
  double personWeight = double.parse(stdin.readLineSync().toString());

  if (personWeight < 90 && personWeight > 50) {
    // 51-89
    print('your weight is Normal');
  } else if (personWeight >= 90 && personWeight <= 105) {
    print('you are fat');
  } else if (45 <= personWeight && personWeight <= 50) {
    print('you are thin');
  } else {
    print('you have to visit a doctor');
  }
}
