import 'package:flutter/material.dart';
import 'package:refgo_courier/enums.dart';

class OrderItemWidget extends StatelessWidget {
  String uid;
  String number;
  String address;
  Status status;

  OrderItemWidget(
      {super.key,
      required this.uid,
      required this.number,
      required this.address,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          children: [
            Text(uid),
            const SizedBox(
              width: 2,
            ),
            Column(
              children: [
                Text(number),
                const SizedBox(
                  height: 2,
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: Text(address,
                        maxLines: 3, overflow: TextOverflow.fade)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
