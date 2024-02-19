/* import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class VerticalPath extends StatefulWidget {
  const VerticalPath({super.key});

  @override
  State<VerticalPath> createState() => _VerticalPathState();
}

class _VerticalPathState extends State<VerticalPath> {
  List<Item> _data = [
    Item(
        headerValue: 'Panel 1',
        expandedValue: 'Additional content for Panel 1'),
    Item(
        headerValue: 'Panel 2',
        expandedValue: 'Additional content for Panel 2'),
    Item(
        headerValue: 'Panel 3',
        expandedValue: 'Additional content for Panel 3'),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data[index].isExpanded = !isExpanded;
              });
            },
            children: _data.map((Item item) {
              return Column(children: [ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Container(
                      child: Text(item.headerValue)),
                  );
                },
                body: ListTile(
                  title: Text(item.expandedValue),
                ),
                isExpanded: item.isExpanded,
              )],);
            }).toList(),
          ),
        ));
  }
}

class Item {
  Item({
    required this.headerValue,
    required this.expandedValue,
    this.isExpanded = false,
  });

  String headerValue;
  String expandedValue;
  bool isExpanded;
}
 */