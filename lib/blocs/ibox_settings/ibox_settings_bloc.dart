import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ibox_settings_event.dart';
part 'ibox_settings_state.dart';

class IboxSettingsBloc extends Bloc<IboxSettingsEvent, IboxSettingsState> {
  IboxSettingsBloc() : super(IboxSettingsInitial()) {
    on<IboxSettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
