import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/network_settings/networksettings_bloc.dart';
import 'package:refgo_courier/domain/http_request.dart';

class NetworkSettingsPage extends StatelessWidget {
  NetworkSettingsPage({Key? key}) : super(key: key);
  final ctrlAddrServer = TextEditingController();
  final ctrlUserName = TextEditingController();
  final ctrlPasswd = TextEditingController();
  final ctrlId = TextEditingController();

  //var _bloc = BlocProvider.of<NetworksettingsBloc>(context).;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkSettingsBloc, NetworkSettingsState>(
      builder: (context, state) {
        var networkSettings =
            BlocProvider.of<NetworkSettingsBloc>(context).networkSettings;
        if (networkSettings != null) {
          ctrlAddrServer.text = networkSettings['ctrlAddrServer'];
          ctrlUserName.text = networkSettings['ctrlUserName'];
          ctrlPasswd.text = networkSettings['ctrlPasswd'];
          ctrlId.text = networkSettings['ctrlId'];
        }
        //  else if (state.networkSettings.isNotEmpty) {
        //   ctrlAddrServer.text = state.networkSettings['ctrlAddrServer'];
        //   ctrlUserName.text = state.networkSettings['ctrlUserName'];
        //   ctrlPasswd.text = state.networkSettings['ctrlPasswd'];
        // }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Сетевые настройки'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  //initialValue: 'http://192.168.1.135:443',
                  controller: ctrlAddrServer,
                  decoration: InputDecoration(
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(15.0),
                    //   borderSide: BorderSide(
                    //     color: Colors.red,
                    //   ),
                    // ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    hintText: 'example.com',
                    labelText: 'Адрес сервера',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    //initialValue: 'testapi',
                    controller: ctrlUserName,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      hintText: 'Введите имя пользователя',
                      labelText: 'имя пользователя',
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  //initialValue: 'sc1or6',
                  controller: ctrlPasswd,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    hintText: 'Введите пароль',
                    labelText: 'Пароль',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    //obscureText: true,
                    //initialValue: 'sc1or6',
                    controller: ctrlId,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      hintText: 'MobKas01',
                      labelText: 'Введите идентификатор базы',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text("Тест соединения"),
                      onPressed: () async {
                        if (ctrlAddrServer.text == '' ||
                            ctrlUserName.text == '' ||
                            ctrlPasswd.text == '' ||
                            ctrlId.text == '') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text('Заполните все поля!!!'),
                                );
                              });
                          return;
                        } else {
                          var result = await getTestConn({
                            'addrServer': ctrlAddrServer.text,
                            'userName': ctrlUserName.text,
                            'passwd': ctrlPasswd.text,
                            'id': ctrlId.text
                          });
                        }

                        // if (res == 'ok') {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //           title: Text('Соединение успешно'),
                        //         );
                        //       });
                        // } else {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //           title: Text('Соединение провалено!'),
                        //         );
                        //       });
                        // }
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                      child: const Text("Сохранить"),
                      onPressed: () {
                        if (ctrlAddrServer.text == '' ||
                            ctrlUserName.text == '' ||
                            ctrlPasswd.text == '' ||
                            ctrlId.text == '') {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                  title: Text('Заполните все поля!!!'),
                                );
                              });
                          return;
                        } else {
                          BlocProvider.of<NetworkSettingsBloc>(context)
                              .add(SaveNetworkSettingsEvent(networkSettings: {
                            'ctrlAddrServer': ctrlAddrServer.text,
                            'ctrlUserName': ctrlUserName.text,
                            'ctrlPasswd': ctrlPasswd.text,
                            'ctrlId': ctrlId.text
                          }));
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
