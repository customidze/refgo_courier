import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refgo_courier/blocs/ibox_settings/ibox_settings_bloc.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/blocs/network_settings/networksettings_bloc.dart';
import 'package:refgo_courier/blocs/order_page/order_page_bloc.dart';
import 'package:refgo_courier/blocs/service_db/service_db_bloc.dart';
import 'package:refgo_courier/pages/ibox_settings_page.dart';
import 'package:refgo_courier/pages/main_page.dart';
import 'package:refgo_courier/pages/network_settings_page.dart';
import 'package:refgo_courier/pages/order_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:refgo_courier/pages/service_db_page.dart';
import 'package:refgo_courier/pages/yandex_map_page.dart';
//import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
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
          create: (context) => NetworkSettingsBloc(),
        ),
        BlocProvider(
          create: (context) => ServiceDbBloc(),
        ),
        BlocProvider(
          create: (context) => OrderPageBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'RefGo courier',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        //home: MainPage(),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => MainPage(),
          '/network': (BuildContext context) => NetworkSettingsPage(),
          '/ibox': (BuildContext context) => const IboxSettingsPage(),
          '/db': (BuildContext context) => const ServiceDbPage(),
          '/order': (BuildContext context, {arguments}) => OrderPage(),
          '/map': (BuildContext context, {arguments}) => YandexMapPage(),
        },
      ),
    );
  }
}
