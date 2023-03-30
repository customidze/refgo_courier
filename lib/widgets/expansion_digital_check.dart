import 'package:flutter/material.dart';
import 'package:refgo_courier/domain/order.dart';

class ExpansionDidgitalCheckWidget extends StatefulWidget {
  const ExpansionDidgitalCheckWidget({super.key, required this.phone});
  final String phone;

  @override
  State<ExpansionDidgitalCheckWidget> createState() =>
      _ExpansionDidgitalCheckWidgetState();
}

class _ExpansionDidgitalCheckWidgetState
    extends State<ExpansionDidgitalCheckWidget> {
  final List<Item> _items = <Item>[Item(title: 'title', body: 'body')];

  @override
  Widget build(BuildContext context) {
    TextEditingController tecEmail = TextEditingController(text: widget.phone);
    TextEditingController tecPhone = TextEditingController(text: widget.phone);

    return ExpansionPanelList(
      children: _items.map((Item item) {
        return ExpansionPanel(
            isExpanded: item.isExpanded,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return const Center(child: Text('Эл. чек'));
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Email'),
                    const SizedBox(
                      width: 9,
                    ),
                    SizedBox(
                      width: 180,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                          onPressed: () {
                            tecEmail.text = '';
                          },
                          icon: const Icon(Icons.clear),
                        )),
                        controller: tecEmail,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Phone'),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 180,
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                          onPressed: () {
                            tecPhone.text = '';
                          },
                          icon: const Icon(Icons.clear),
                        )),
                        controller: tecPhone,
                      ),
                    ),
                  ],
                )
              ],
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
