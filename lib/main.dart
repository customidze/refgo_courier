import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/ibox_settings/ibox_settings_bloc.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/blocs/network_settings/networksettings_bloc.dart';
import 'package:refgo_courier/pages/ibox_settings_page.dart';
import 'package:refgo_courier/pages/main_page.dart';
import 'package:refgo_courier/pages/network_settings_page.dart';
import 'package:refgo_courier/pages/order_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => IboxSettingsBloc(),
        ),
        BlocProvider(
          create: (context) => MainPageBloc(),
        ),
        BlocProvider(
          create: (context) => NetworksettingsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'RefGo courier',
        theme: ThemeData(
        
          primarySwatch: Colors.blue,
        ),
        //home: MainPage(),
        initialRoute: '/',
        routes: {
            '/': (BuildContext context) => MainPage(),
            '/network': (BuildContext context) => NetworkSettingsPage(),
            '/ibox': (BuildContext context) => IboxSettingsPage(),
            '/order': (BuildContext context) => OrderPage(),
          },
      ),
    );
  }
}

