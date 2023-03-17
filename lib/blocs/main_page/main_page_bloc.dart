import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refgo_courier/enums.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  List<Order>? listOrder;

  MainPageBloc() : super(MainPageInitial()) {
    // on<MainPageEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<GetOrdersEvent>((event, emit) {
      emit(GetOrdersState());
    });
  }
}
