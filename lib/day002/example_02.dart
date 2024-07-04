import 'dart:io';

void main() {
  // example 2
  print('what is the day today?');
  var day = stdin.readLineSync();

  switch (day) {
    case 'friday':
      print('today is $day');
      break;
    case 'saturday':
      print('today is $day');
      break;
    case 'sunday':
      print('today is $day');
      break;
    case 'monday':
      print('today is $day');
      break;
    case 'tuesday':
      print('today is $day');
      break;
    case 'wednesday':
      print('today is $day');
      break;
    case 'thursday':
      print('today is $day');
      break;
    default:
      print('the word is invalid, try again');
  }
}
