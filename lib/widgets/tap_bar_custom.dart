import 'package:flutter/material.dart';

class TapBarCustom extends StatefulWidget {
  TapBarCustom({super.key});
  int activeTab = 1;

  @override
  State<TapBarCustom> createState() => _TapBarCustomState();
}

class _TapBarCustomState extends State<TapBarCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.amber,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                if (widget.activeTab != 1) {
                  setState(() {
                    widget.activeTab = 1;
                  });
                }
              },
              child: Column(
                children: [
                  const Text('Доставка'),
                  Container(
                    height: 2,
                    width: 60,
                    color: widget.activeTab == 1 ? Colors.amber : Colors.white,
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (widget.activeTab != 2) {
                  setState(() {
                    widget.activeTab = 2;
                  });
                }
              },
              child: Column(
                children: [
                  const Text('Фото'),
                  Container(
                    height: 2,
                    width: 30,
                    color: widget.activeTab == 2 ? Colors.amber : Colors.white,
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (widget.activeTab != 3) {
                  setState(() {
                    widget.activeTab = 3;
                  });
                }
              },
              child: Column(
                children: [
                  const Text('Ответственный'),
                  Container(
                    height: 2,
                    width: 97,
                    color: widget.activeTab == 3 ? Colors.amber : Colors.white,
                  )
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
