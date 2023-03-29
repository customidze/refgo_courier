import 'package:flutter/material.dart';

class ExpansionGoodsWidget extends StatefulWidget {
  const ExpansionGoodsWidget({super.key});

  @override
  State<ExpansionGoodsWidget> createState() => _ExpansionGoodsWidgetState();
}

class _ExpansionGoodsWidgetState extends State<ExpansionGoodsWidget> {
  List<ExpansionPanel> ep = [
    ExpansionPanel(
      isExpanded: false,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text('item'),
          subtitle: Text('item'),
        );
      },
      body: ListTile(
        title: Text('item'),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      children: List.generate(
          1,
          (index) => ExpansionPanel(
                isExpanded: false,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text('item'),
                    subtitle: Text('item'),
                  );
                },
                body: ListTile(
                  title: Text('item'),
                ),
              )),
      expansionCallback: (int index, bool isExpanded) {
        print('r');
        ep[index].isExpanded = !isExpanded;
        setState(() {});
      },
    );
  }
}

ExpansionPanel buildExpansionPanel(item) {
  return ExpansionPanel(
    isExpanded: false,
    headerBuilder: (BuildContext context, bool isExpanded) {
      return ListTile(
        title: Text(item),
        subtitle: Text(item),
      );
    },
    body: ListTile(
      title: Text(item),
    ),
  );
}

class Step {
  bool isExpanded;
  String title;
  String body;
  Step({required this.isExpanded, required this.title, required this.body});
}
