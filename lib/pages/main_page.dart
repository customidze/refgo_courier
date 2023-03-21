import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/widgets/drawer_main.dart';
import 'package:refgo_courier/widgets/order_item_widget.dart';
import 'package:refgo_courier/widgets/progress_indicator.dart';

class MainPage extends StatelessWidget {
   
  
  MainPage({super.key});

  List? markers;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  BlocProvider.of<MainPageBloc>(context).add(GetOrdersEvent());
                },
                icon: const Icon(Icons.download))
          ],
        ),
        drawer: const DrawerMain(),
        //body: const ProgressInd(),
        body: BlocBuilder<MainPageBloc, MainPageState>(
          buildWhen: (previous, current) =>
              current is GetOrdersState || current is OnWillPopState ? true : false,
          builder: (context, state) {
            if (state is GetOrdersState) {
              markers = List.generate(state.listOrder.length, (index) => {'lat':state.listOrder[index].lat, 'long':state.listOrder[index].long}).toList();
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
          height: 60,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(0, -1),
                  color: Colors.grey,
                  blurRadius: 3,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.amber,
                  child: Text('Наличные:'),
                ),
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  child: Text('Безналичные:'),
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.amber,
                      child: Text('Закрыть смену'),
                    ),
                    InkWell(
                      //hoverColor: Colors.black,
                      onTap: () {
                        Navigator.pushNamed(context, '/map',arguments: markers);
                      },
                      child: Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.white,
                        child: const Text('Карта'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
