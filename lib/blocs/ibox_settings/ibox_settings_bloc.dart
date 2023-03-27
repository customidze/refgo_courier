// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'ibox_settings_event.dart';
part 'ibox_settings_state.dart';

class IboxSettingsBloc extends Bloc<IboxSettingsEvent, IboxSettingsState> {
  IboxSettingsBloc() : super(IboxSettingsInitial()) {
    on<IboxSettingsEvent>((event, emit) {
      //  implement event handler
    });
  }
}
