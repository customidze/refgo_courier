import 'package:hive_flutter/hive_flutter.dart';
import 'package:refgo_courier/blocs/network_settings/networksettings_bloc.dart';

 Future<Map> getSaveNetworkSettings(Map settings) async {
    Map? result;

    var box = await Hive.openBox('NetworkSettings');
    if (settings.isEmpty) {
      result = await box.get('NetworkSettings');
    } else {
      box.put('NetworkSettings', settings);
      result = {};
    }
    return result!;
  }

