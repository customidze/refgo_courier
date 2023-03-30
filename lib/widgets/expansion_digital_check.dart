import 'package:flutter/material.dart';
import 'package:refgo_courier/domain/order.dart';

class ExpansionGoodsWidget extends StatefulWidget {
  const ExpansionGoodsWidget({super.key, required this.phone});
 final String phone;

  @override
  State<ExpansionGoodsWidget> createState() => _ExpansionGoodsWidgetState();
}

class _ExpansionGoodsWidgetState extends State<ExpansionGoodsWidget> {
  final List<Item> _items = <Item>[Item(title: 'title', body: 'body')];
  TextEditingController tec = TextEditingController(text: widget.phone);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      children: _items.map((Item item) {
        return ExpansionPanel(
            isExpanded: item.isExpanded,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return const Center(child: Text('Эл. чек'));
            },
            body: Column(
              children: [const Text('Email'),Row(children: [
                Text('Phone'),
                TextField(controller: ,),
              ],)],
            ));
      }).toList(),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _items[index].isExpanded = !_items[index].isExpanded;
        });
      },
    );
  }
}

class Item {
  bool isExpanded;
  String title;
  String body;
  Item({this.isExpanded = false, required this.title, required this.body});
}
