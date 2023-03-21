import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refgo_courier/domain/get_save_network_settings.dart';
import 'package:refgo_courier/domain/http_request.dart';
import 'package:refgo_courier/enums.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  List<Order>? listOrder;
  DateTime dt = DateTime.now();
  Map? dataForConn = _getDataForConn();
  

  MainPageBloc() : super(MainPageInitial()) {
    // on<MainPageEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<GetOrdersEvent>((event, emit) {
      var result = _getOrdersFromServer(dt);
      emit(GetOrdersState());
    });
    on((event, emit) {
      emit(OnWillPopState());
    });
  }

  _getOrdersFromServer(date){
    //var result = getOrders(dataForConn);
  }

  _getDataForConn()async{
    dataForConn = await getSaveNetworkSettings({});
    return dataForConn;
  }

}
