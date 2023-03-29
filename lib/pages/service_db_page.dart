import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/network_settings/networksettings_bloc.dart';
import 'package:refgo_courier/blocs/service_db/service_db_bloc.dart';

class ServiceDbPage extends StatelessWidget {
  const ServiceDbPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Обслуживание БД'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Полная очистка БД'),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Text('Вы уверены?'),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (BlocProvider.of<NetworkSettingsBloc>(
                                                context)
                                            .networkSettings !=
                                        null) {
                                      BlocProvider.of<NetworkSettingsBloc>(
                                              context)
                                          .networkSettings = null;
                                    }

                                    BlocProvider.of<ServiceDbBloc>(context)
                                        .add(ClearAllDataEvent());
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Да')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Нет'))
                            ],
                          );
                        });
                  },
                  child: const Text('Очистить')),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('Вы уверены?'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<ServiceDbBloc>(context)
                                    .add(ClearOrdersEvent());
                                Navigator.of(context).pop();
                              },
                              child: const Text('Да')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Нет'))
                        ],
                      );
                    });
              },
              child: const Text('Очистить заказы')),
        ],
      ),
    );
  }
}
