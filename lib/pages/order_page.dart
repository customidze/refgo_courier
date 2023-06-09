import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/blocs/order_page/order_page_bloc.dart';
import 'package:refgo_courier/domain/order.dart';
import 'package:refgo_courier/widgets/expansion_digital_check.dart';
import 'package:refgo_courier/widgets/expansion_goods.dart';
//import 'package:refgo_courier/widgets/progress_indicator.dart';
//import 'package:refgo_courier/widgets/tap_bar_custom.dart';
import 'package:refgo_courier/widgets/tap_bar_widget_2.dart';
import 'package:duration_picker/duration_picker.dart';

// ignore: must_be_immutable
class OrderPage extends StatelessWidget {
  Order? order;
  OrderPage({super.key});
  //List<bool> isSelectedTypeOfPayments = [true, false];

  final List<String> items = Status.values.map((e) => e.name).toList();
  final List<String> itemsRus = [
    'В пути',
    'Назначен',
    'Частично доставлен',
    'Доставлен',
    'Отмена',
    'Отказ',
    'В пути(не дозвонился)',
    'На месте(не дозвонился)',
    //''
    //'Не известный статус'
  ];
  //TimeOfDay late = TimeOfDay(hour: 0, minute: 0);

  @override
  Widget build(BuildContext context) {
    Duration late = Duration(
        seconds: BlocProvider.of<OrderPageBloc>(context).order!.lateArrival);
    var blcOrder = BlocProvider.of<OrderPageBloc>(context).order!;

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
              return Text(
                'Заказ $number',
                style: const TextStyle(fontSize: 18),
              );
            },
          ),
          actions: [
            SizedBox(
                width: 80,
                child: ElevatedButton(
                    onPressed: () async {
                      //showTimePicker(context: context, initialTime: late,);
                      late = await showDurationPicker(
                              context: context, initialTime: late) ??
                          late;
                      BlocProvider.of<OrderPageBloc>(context)
                          .add(SetLateEvent(late: late));
                    },
                    child: BlocBuilder<OrderPageBloc, OrderPageState>(
                      buildWhen: (previous, current) =>
                          current is SetLateState ? true : false,
                      builder: (context, state) {
                        if (state is SetLateState ||
                            //BlocProvider.of<OrderPageBloc>(context).order!.late != Duration.zero
                            blcOrder.lateArrival != 0) {
                          return Text(
                            BlocProvider.of<OrderPageBloc>(context)
                                .order!
                                .lateArrival
                                .toString()
                                .replaceAll(':00.000000', ''),
                            style: const TextStyle(fontSize: 15),
                          );
                        } else {
                          return const Text(
                            'Опоздание',
                            style: TextStyle(fontSize: 9),
                          );
                        }
                      },
                    )))
          ],
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
                    String stRus;
                    if (st == Status.on_way) {
                      stRus = 'В пути';
                    } else if (st == Status.assigned) {
                      stRus = 'Назначен';
                    } else if (st == Status.delivered) {
                      stRus = 'Частично доставлен';
                    } else if (st == Status.part_delivered) {
                      stRus = 'Доставлен';
                    } else if (st == Status.canceled) {
                      stRus = 'Отмена';
                    } else if (st == Status.returned) {
                      stRus = 'Отказ';
                    } else if (st == Status.on_way_no_connection) {
                      stRus = 'В пути(не дозвонился)';
                    } else if (st == Status.in_place_no_connection) {
                      stRus = 'На месте(не дозвонился)';
                    } else {
                      stRus = '';
                    }

                    return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                      hint: const Text(
                        'Select Item',
                      ),
                      items: itemsRus
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ))
                          .toList(),
                      //value: describeEnum(st),
                      value: stRus,
                      onChanged: (value) {
                        Status? newstatus;

                        if (value == 'В пути') {
                          newstatus = Status.on_way;
                        } else if (value == 'Назначен') {
                          newstatus = Status.assigned;
                        } else if (value == 'Доставлен') {
                          newstatus = Status.delivered;
                        } else if (value == 'Частично доставлен') {
                          newstatus = Status.part_delivered;
                        } else if (value == 'Отмена') {
                          newstatus = Status.canceled;
                        } else if (value == 'Отказ') {
                          newstatus = Status.returned;
                        } else if (value == 'В пути(не дозвонился)') {
                          newstatus = Status.on_way_no_connection;
                        } else if (value == 'На месте(не дозвонился)') {
                          newstatus = Status.in_place_no_connection;
                        }
                        if (newstatus != null) {
                          BlocProvider.of<OrderPageBloc>(context)
                              .add(SetStatusEvent(status: newstatus));
                          selectedValue = value;
                        }
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
            ExpansionGoodsWidget(listGoods: order.listGoods),
            Row(
              children: [
                BlocBuilder<OrderPageBloc, OrderPageState>(
                  buildWhen: (previous, current) =>
                      current is SetTypeOfPaymentsState ? true : false,
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
                          //isSelected: state.lb,
                          isSelected:
                              BlocProvider.of<OrderPageBloc>(context).top,
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
                IconButton(onPressed: () {}, icon: const Icon(Icons.receipt)),
              ],
            ),
            ExpansionDidgitalCheckWidget(
              phone: order.customerTel,
            ),
            Row(children: const [Text('Услуги')]),
            Row(children: const [Text('К оплате(НП)')]),
            Row(children: const [Text('Принято')])
            //buildExpansionPanel('name'),
          ],
        ),
        bottomNavigationBar: SizedBox(
          //color: Colors.green,
          height: MediaQuery.of(context).size.height * 0.1,
          child: ElevatedButton(
              onPressed: () {
                if (selectedValue != null) {
                  Status? newstatus;
                  if (selectedValue == 'В пути') {
                    newstatus = Status.on_way;
                  } else if (selectedValue == 'Назначен') {
                    newstatus = Status.assigned;
                  } else if (selectedValue == 'Доставлен') {
                    newstatus = Status.delivered;
                  } else if (selectedValue == 'Частично доставлен') {
                    newstatus = Status.part_delivered;
                  } else if (selectedValue == 'Отмена') {
                    newstatus = Status.canceled;
                  } else if (selectedValue == 'Отказ') {
                    newstatus = Status.returned;
                  } else if (selectedValue == 'В пути(не дозвонился)') {
                    newstatus = Status.on_way_no_connection;
                  } else if (selectedValue == 'На месте(не дозвонился)') {
                    BlocProvider.of<OrderPageBloc>(context)
                        .add(SetStatusEvent(status: newstatus!));
                  }
                }
                BlocProvider.of<MainPageBloc>(context)
                    .saveOrders(DateTime.now());

                BlocProvider.of<OrderPageBloc>(context)
                    .add(SendDataToServerEvent());

                BlocProvider.of<MainPageBloc>(context).add(OnWillPopEvent());
                Navigator.pop(context, true);
              },
              child: const Text('Готово')),
        ),
      ),
    );
  }
}
