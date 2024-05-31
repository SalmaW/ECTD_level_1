import '../pages/rooms_panel.dart';
import '../widgets/date_time_button.dart';
import '../widgets/radio_check_button.dart';
import '../widgets/slider_widget.dart';
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
        onPressed: () async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            showCloseIcon: true,
            backgroundColor: Colors.brown,
            content: Row(
              children: [
                Icon(Icons.add),
                Text('item has been added successfully')
              ],
            ),
          ));
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => const RoomsPanel()));
        },
        child: const Icon(Icons.local_hotel),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
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
                child: const SizedBox(),
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
                    key: const Key("check-in"),
                    firstDate: DateTime.now(),
                  ),
                  DateTimeButton(
                    checkInOutDate: "Check-out Date:",
                    key: const Key("check-out"),
                    firstDate: checkInDate != null
                        ? checkInDate!.add(Duration(days: 1))
                        : DateTime.now(),
                  ),
                ],
              ),
              const SliderWidget(labelName: "Adults"),
              const SliderWidget(labelName: "Children"),
              const Text(
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
              const Text(
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
