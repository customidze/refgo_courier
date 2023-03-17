import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'service_db_event.dart';
part 'service_db_state.dart';

class ServiceDbBloc extends Bloc<ServiceDbEvent, ServiceDbState> {
  ServiceDbBloc() : super(ServiceDbInitial()) {
    // on<ServiceDbEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<ClearAllDataEvent>((event, emit) {
      _deleteAllData();
    });
  }
  _deleteAllData()async{
    await Hive.close();
    Hive.deleteFromDisk();
  }
}
