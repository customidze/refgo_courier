import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'networksettings_event.dart';
part 'networksettings_state.dart';

class NetworksettingsBloc extends Bloc<NetworksettingsEvent, NetworksettingsState> {
  NetworksettingsBloc() : super(NetworksettingsInitial()) {
    on<NetworksettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
