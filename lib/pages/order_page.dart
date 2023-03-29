import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/blocs/order_page/order_page_bloc.dart';
import 'package:refgo_courier/domain/order.dart';
import 'package:refgo_courier/widgets/expansion_goods.dart';
//import 'package:refgo_courier/widgets/progress_indicator.dart';
//import 'package:refgo_courier/widgets/tap_bar_custom.dart';
import 'package:refgo_courier/widgets/tap_bar_widget_2.dart';

// ignore: must_be_immutable
class OrderPage extends StatelessWidget {
  Order? order;
  OrderPage({super.key});
  //List<bool> isSelectedTypeOfPayments = [true, false];

  final List<String> items = Status.values.map((e) => e.name).toList();

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      //BlocProvider.of<MainPageBloc>(context).add(OnWillPopEvent());
      return true; //<-- SEE HERE
    }

    Order order = (ModalRoute.of(context)?.settings.arguments) as Order;
    String? selectedValue;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<OrderPageBloc, OrderPageState>(
            builder: (context, state) {
              String? number = BlocProvider.of<OrderPageBloc>(context).number;
              return Text('Заказ $number');
            },
          ),
        ),
        body: ListView(
          children: [
            Row(
              children: [
                const SizedBox(
                  child: Text('Cтатус:'),
                ),
                BlocBuilder<OrderPageBloc, OrderPageState>(
                  buildWhen: (previous, current) {
                    if (current is SetStatusState) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    Status st =
                        BlocProvider.of<OrderPageBloc>(context).order!.status;

                    return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                      hint: const Text(
                        'Select Item',
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ))
                          .toList(),
                      value: describeEnum(st),
                      onChanged: (value) {
                        // Status newstatus = Status.values.byName(value!);
                        // BlocProvider.of<OrderPageBloc>(context)
                        //     .add(SetStatusEvent(status: newstatus));

                        selectedValue = value;
                      },
                    ));
                  },
                ),
              ],
            ),
            //TapBarCustom(),
            TapBarWidget2(
              order: order,
            ),
            Row(
              children: [
                const Text('Предоплачен'),
                const SizedBox(
                  width: 5,
                ),
                order.prepaid
                    ? const Icon(
                        Icons.task_alt_outlined,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.disabled_by_default_sharp,
                        color: Colors.red,
                      ),
                const SizedBox(
                  width: 5,
                ),
                const Text('Мест 0')
              ],
            ),
            ExpansionGoodsWidget(),
            Row(
              children: [
                BlocBuilder<OrderPageBloc, OrderPageState>(
                  buildWhen: (previous, current) =>
                      !listEquals<bool>(previous.lb, current.lb),
                  //previous.lb != current.lb ? true : false,
                  builder: (context, state) {
                    return SizedBox(
                      height: 30,
                      child: ToggleButtons(
                          borderRadius: BorderRadius.circular(10),
                          onPressed: (index) {
                            if (index == 0) {
                              BlocProvider.of<OrderPageBloc>(context).add(
                                  SetTypeOfPaymentsEvent(
                                      top: TypeOfPayment.cash));
                            } else {
                              BlocProvider.of<OrderPageBloc>(context).add(
                                  SetTypeOfPaymentsEvent(
                                      top: TypeOfPayment.cashless));
                            }
                          },
                          //color: Colors.blue,
                          fillColor: Colors.green,
                          isSelected: state.lb,
                          //selectedColor: const Color.fromARGB(255, 146, 54, 54),
                          children: const [
                            Text(
                              'Наличные',
                              //style: TextStyle(fontSize: 18)
                            ),
                            Text(
                              'Безналичные',
                              //style: TextStyle(fontSize: 18)
                            ),
                          ]),
                    );
                  },
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.receipt)),
              ],
            ),
            //buildExpansionPanel('name'),
            
          ],
        ),
        bottomNavigationBar: SizedBox(
          //color: Colors.green,
          height: MediaQuery.of(context).size.height * 0.1,
          child: ElevatedButton(
              onPressed: () {
                if (selectedValue != null) {
                  Status newstatus = Status.values.byName(selectedValue!);
                  BlocProvider.of<OrderPageBloc>(context)
                      .add(SetStatusEvent(status: newstatus));
                }
                BlocProvider.of<MainPageBloc>(context)
                    .saveOrders(order.deliveryDate);
                BlocProvider.of<MainPageBloc>(context).add(OnWillPopEvent());
                Navigator.pop(context, true);
              },
              child: const Text('Готово')),
              
        ),
      ),
    );
  }
}



 