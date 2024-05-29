import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            //as it will await for the AlertDialog then it will push
            // var resultPush = await Navigator.push(context, route);

            var result = await showDialog(
                // barrierDismissible: false,
                context: context,
                builder: (ctx) {
                  //dialogs don't have call back
                  return AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("please confirm this"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                });
            if (result == true) {
              print('user wanted delete');
            } else {
              // this line will be printed in 2 cases:
              // 1. when user tap on 'Cancel'
              // 2. when user tap on barrierDismissible area as it's value is true
              print('user did not want delete');
            }
            return result;
          },
          child: Text("Show Dialog"),
        ),
        ElevatedButton(
          onPressed: () async {
            //as it will await for the AlertDialog then it will push
            // var resultPush = await Navigator.push(context, route);

            var result = await showDialog(
                // barrierDismissible: false,
                context: context,
                builder: (ctx) {
                  //dialogs don't have call back
                  return CupertinoAlertDialog(
                    title: Text("Are you sure?"),
                    content: Text("please confirm this"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                });
            if (result == true) {
              print('user wanted delete');
            } else {
              // this line will be printed in 2 cases:
              // 1. when user tap on 'Cancel'
              // 2. when user tap on barrierDismissible area as it's value is true
              print('user did not want delete');
            }
            return result;
          },
          child: Text("Show IOS Dialog"),
        ),
        ElevatedButton(
          onPressed: () async {
            //as it will await for the AlertDialog then it will push
            // var resultPush = await Navigator.push(context, route);

            var result = await showDialog(
                // barrierDismissible: false,
                context: context,
                builder: (ctx) {
                  //dialogs don't have call back
                  return Dialog(
                    child: SizedBox(
                      height: 200,
                      width: 100,
                      child: Column(
                        children: [
                          Text('Are you sure?'),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text('yes')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text('No')),
                        ],
                      ),
                    ),
                  );
                });
            if (result == true) {
              print('user wanted delete');
            } else {
              // this line will be printed in 2 cases:
              // 1. when user tap on 'Cancel'
              // 2. when user tap on barrierDismissible area as it's value is true
              print('user did not want delete');
            }
            return result;
          },
          child: Text("Show custom Dialog"),
        ),
      ],
    );
  }
}
