import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/blocs/order_page/order_page_bloc.dart';
import 'package:refgo_courier/enums.dart';

class OrderItemWidget extends StatelessWidget {
  String uid;
  String number;
  String address;
  Status status;

  Order order;

  OrderItemWidget(
      {super.key,
      required this.uid,
      required this.number,
      required this.address,
      required this.status,
      required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<OrderPageBloc>(context).number = number;
        BlocProvider.of<OrderPageBloc>(context).order = order;
        Navigator.pushNamed(context, '/order', arguments: order);
      },
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          children: [
            //Text(uid),
            status == Status.inway
                ? const Icon(Icons.car_crash_outlined)
                : const Icon(Icons.done),
            const SizedBox(
              width: 2,
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(number),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(address,
                      //textAlign: TextAlign.center,

                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
