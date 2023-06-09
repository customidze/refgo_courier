import 'package:flutter/material.dart';
import 'package:refgo_courier/domain/order.dart';

class ExpansionGoodsWidget extends StatefulWidget {
  const ExpansionGoodsWidget({super.key, required this.listGoods});
  final List<Good> listGoods;

  @override
  State<ExpansionGoodsWidget> createState() => _ExpansionGoodsWidgetState();
}

class _ExpansionGoodsWidgetState extends State<ExpansionGoodsWidget> {
  final List<Item> _items = <Item>[Item(title: 'title', body: 'body')];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      children: _items.map((Item item) {
        return ExpansionPanel(
            isExpanded: item.isExpanded,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return const Center(child: Text('Грузы'));
            },
            body: Column(
              children: List.generate(widget.listGoods.length, (index) {
                return Row(
                  children: [
                    Text((index + 1).toString()),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.listGoods[index].name),
                        Text(
                            '${widget.listGoods[index].art}, ${widget.listGoods[index].barcode}')
                      ],
                    )
                  ],
                );
              }).toList(),
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
