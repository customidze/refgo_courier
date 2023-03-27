import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/widgets/drawer_main.dart';
import 'package:refgo_courier/widgets/order_item_widget.dart';
import 'package:refgo_courier/widgets/progress_indicator.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  List? markers;
  DateTime dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<MainPageBloc, MainPageState>(
        listener: (context, state) {
          if (state is ErrorState) {
            SnackBar snackBar = SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: GestureDetector(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime.now())
                    .then((pickedDate) {
                  if (pickedDate == null) {
                    return;
                  } else {
                    dt = pickedDate;
                    BlocProvider.of<MainPageBloc>(context)
                        .add(SetDateEvent(date: pickedDate));
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    //color: Colors.blueGrey,
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                height: 30,
                width: 120,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  BlocBuilder<MainPageBloc, MainPageState>(
                    buildWhen: (previous, current) =>
                        current is SetDateState ? true : false,
                    builder: (context, state) {
                      return Text(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          '${dt.day.toString()}-${dt.month.toString()}-${dt.year.toString()}');
                    },
                  ),
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  )
                ]),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<MainPageBloc>(context)
                        .add(RequestOrdersEvent(dt: dt));
                  },
                  icon: const Icon(Icons.download))
            ],
          ),
          drawer: const DrawerMain(),
          //body: const ProgressInd(),
          body: BlocBuilder<MainPageBloc, MainPageState>(
            buildWhen: (previous, current) => current is GetOrdersState ||
                    current is OnWillPopState ||
                    current is WaitState
                ? true
                : false,
            builder: (context, state) {
              if (state is GetOrdersState || state is OnWillPopState) {
                if (state.listOrder.isEmpty) {
                  const Center(
                    child: SizedBox(
                      child: Text('Нет заказов...'),
                    ),
                  );
                }
                markers = List.generate(
                    state.listOrder.length,
                    (index) => {
                          'lat': state.listOrder[index].lat,
                          'long': state.listOrder[index].long
                        }).toList();
                return RawScrollbar(
                  thumbVisibility: true,
                  thumbColor: Colors.green,
                  radius: const Radius.circular(10),
                  thickness: 7,
                  child: ListView(
                    children: List.generate(state.listOrder.length, (index) {
                      return OrderItemWidget(
                        uid: state.listOrder[index].uid,
                        number: state.listOrder[index].nimber,
                        address: state.listOrder[index].address,
                        status: state.listOrder[index].status,
                        order: state.listOrder[index],
                      );
                    }).toList(),
                  ),
                );
              } else if (state is WaitState) {
                return const ProgressInd();
              } else {
                return const Center(
                  child: SizedBox(
                    child: Text('Нет заказов...'),
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: BottomAppBar(
            height: 80,
            child: Container(
              decoration: const BoxDecoration(
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //     offset: Offset(0, -1),
                  //     color: Colors.white,
                  //     blurRadius: 3,
                  //   ),
                  // ],
                  ),
              child: Column(
                children: [
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.amber,
                    child: const Text('Наличные:'),
                  ),
                  Container(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.blue,
                    child: const Text('Безналичные:'),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Закрыть смену'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        //hoverColor: Colors.black,
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/map',
                                arguments: markers);
                          },

                          // width: MediaQuery.of(context).size.width * 0.5,
                          // color: Colors.white,
                          child: const Center(child: Text('Карта')),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Future<void> _showDatePicker()async{
  //   final DateTime picked=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
  //   if(picked != null)
  //   {
  //   //print(DateFormat("yyyy-MM-dd").format(picked));
  //   }
  // }
}
