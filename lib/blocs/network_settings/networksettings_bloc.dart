import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refgo_courier/domain/get_save_network_settings.dart';

part 'networksettings_event.dart';
part 'networksettings_state.dart';

class NetworkSettingsBloc
    extends Bloc<NetworkSettingsEvent, NetworkSettingsState> {
  Map? networkSettings;

  NetworkSettingsBloc() : super(
    NetworkSettingsInitial()) {
    getAsync();
    on<NetworkSettingsEvent>((event, emit) {
      //getAsync();
      if (event is SaveNetworkSettingsEvent) {
        networkSettings = event.networkSettings;
      }
      //print(networkSettings);
    });
    on<GetNetworkSettingsEvent>((event, emit) {
      emit(GetNetworkSettingsState(networkSettings: event.networkSettings!));
    });
    on<SaveNetworkSettingsEvent>((event, emit) {
      networkSettings = event.networkSettings;
      getSaveNetworkSettings(event.networkSettings!);
    });
  }

  getAsync() async {
    networkSettings = await getSaveNetworkSettings({});
    add(GetNetworkSettingsEvent(networkSettings: networkSettings));
  }
}
