import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/widgets/drawer_main.dart';
import 'package:refgo_courier/widgets/order_item_widget.dart';
import 'package:refgo_courier/widgets/progress_indicator.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

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
              current is GetOrdersState ? true : false,
          builder: (context, state) {
            if (state is GetOrdersState) {
              return ListView(
                children: List.generate(state.listOrder.length, (index) {
                  return OrderItemWidget(
                    uid: state.listOrder[index].uid,
                    number: state.listOrder[index].nimber,
                    address: state.listOrder[index].address,
                    status: state.listOrder[index].status,
                  );
                }).toList(),
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
      ),
    );
  }
}
