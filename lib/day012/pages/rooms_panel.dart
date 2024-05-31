import 'package:flutter/material.dart';
import '../models/item.dart';

class RoomsPanel extends StatefulWidget {
  const RoomsPanel({super.key});

  @override
  State<RoomsPanel> createState() => _RoomsPanelState();
}

class _RoomsPanelState extends State<RoomsPanel> {
  final List<Item> _data = <Item>[
    Item(
        image: Image.asset("assets/images/single_room.jpg"),
        headerText: 'Single Room',
        expandedText: "This is a single room"),
    Item(
        image: Image.asset("assets/images/double_room.jpeg"),
        headerText: 'Double Room',
        expandedText: "This is a double room"),
    Item(
        image: Image.asset("assets/images/king_room.jpg"),
        headerText: 'King Room',
        expandedText: "This is a king room"),
    Item(
        image: Image.asset("assets/images/connecting_room.jpg"),
        headerText: 'Connecting Room',
        expandedText: "This is a connecting room"),
    Item(
        image: Image.asset("assets/images/sweet_room.jpg"),
        headerText: 'Sweet Room',
        expandedText: "This is a sweet room"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Panel"),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            for (var item in _data) {
              item.isExpanded = false;
            }
            //for helps the user when tapping another ExpansionPanel it will close the old ExpansionPanel
            _data[index].isExpanded = !_data[index].isExpanded;
            setState(() {});
          },
          children: _data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Stack(
                  children: [
                    ListTile(
                      title: item.image,
                    ),
                    Positioned(
                      right: 30,
                      top: 10,
                      child: Text(
                        item.headerText,
                        style: const TextStyle(
                            fontSize: 20, color: Colors.black38),
                      ),
                    ),
                  ],
                );
              },
              body: ListTile(
                title: Text(item.headerText),
                subtitle: Text(item.expandedText),
                trailing: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () async {
                  var result = await showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text("Are you sure?"),
                          content: const Text("please confirm this"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                _data.removeWhere(
                                    (Item currentItem) => item == currentItem);
                                Navigator.pop(context, true);
                                setState(() {});
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      });
                  if (result == true) {
                    print('user wanted delete');
                  } else {
                    print('user did not want delete');
                  }
                  return result;
                },
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}
