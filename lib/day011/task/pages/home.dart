import 'package:ectd/day011/task/pages/rooms_panel.dart';
import 'package:ectd/day011/task/widgets/date_time_button.dart';

import '../widgets/radio_check_button.dart';
import '../widgets/slider_widget.dart';
import '../widgets/switch_button.dart';
import '../widgets/bottom_modal_sheet.dart';
import '../widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? checkInDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => RoomsPanel()));
        },
        child: Icon(Icons.local_hotel),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 683 * 0.4,
                width: 1024 * 0.4,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/hotel.jpg',
                    ),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DateTimeButton(
                    checkInOutDate: "Check-in Date:",
                    onDateSelected: (date) {
                      checkInDate = date;
                      setState(() {});
                    },
                    key: Key("check-in"),
                    firstDate: DateTime.now(),
                  ),
                  DateTimeButton(
                    checkInOutDate: "Check-out Date:",
                    key: Key("check-out"),
                    firstDate: checkInDate != null
                        ? checkInDate!.add(Duration(days: 1))
                        : DateTime.now(),
                  ),
                ],
              ),
              SliderWidget(labelName: "Adults"),
              SliderWidget(labelName: "Children"),
              Text(
                "Extra services:",
                style: TextStyle(fontSize: 20),
              ),
              Column(
                children: [
                  RadioCheckButton(
                    isRadio: false,
                    data: const [
                      "Breakfast (15 USD/Day)",
                      "Lunch (10 USD/Day)",
                      "Diner (10 USD/Day)",
                      "Parking (5 USD/Day)"
                    ],
                  ),
                ],
              ),
              Text(
                "Room View:",
                style: TextStyle(fontSize: 20),
              ),
              Column(
                children: [
                  RadioCheckButton(
                    isRadio: true,
                    selectedList: ["No View"],
                    data: const [
                      "No View",
                      "City View",
                      "Sea View",
                      "Pool View",
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
