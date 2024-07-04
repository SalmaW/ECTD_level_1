import 'dart:io';

void main() {
  print('Hello to ATM services app');
  print('========================================');
  int choice = 0;
  double initBalance = 30000;
  do {
    print('what transaction u want to do?');
    print('========================================');

    print('1. check balance');
    print('2. withdraw cash');
    print('3. deposit cash');
    print('4. quite');

    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      case 1:
        print('your balance is: $initBalance \n');

      case 2: //withdraw
        print(
            'how much do u want to withdraw? \nNOTE that 14% will be taken as charge for the service \n');
        var withdraw = double.parse(stdin.readLineSync()!);
        var charge = withdraw * 0.14;
        var finalWithdraw = withdraw + charge;
        if (finalWithdraw >= initBalance) {
          print('cannot continues this operation, please try again later');
          break;
        } else {
          print('do u want to withdraw $finalWithdraw ? (y/n)');
          var answer = stdin.readLineSync()!;
          if (answer == 'y') {
            initBalance -= finalWithdraw;
            print('your current balance is: $initBalance \n');
            continue;
          } else if (answer == 'n') {
            print('thanks, hope to see u again! \n');
            break;
          } else {
            print('invalid answer \n');
            break;
          }
        }

      case 3: //deposit
        print('how much do u want to deposit?');
        var deposit = int.parse(stdin.readLineSync()!);
        if (deposit < 50) {
          print('cannot continues this operation, please try again later');
          break;
        } else {
          print('do u want to withdraw $deposit ? (y/n)');
          var answer = stdin.readLineSync()!;
          if (answer == 'y') {
            initBalance += deposit;
            print('your current balance is: $initBalance \n');
            continue;
          } else if (answer == 'n') {
            print('thanks, hope to see u again! \n');
            break;
          } else {
            print('invalid answer \n');
            break;
          }
        }

      case 4:
        print('Thanks for banking with us!');
      default:
        print('invalid choice [choices must be between 1-4]');
    }
  } while (choice != 4);
}
