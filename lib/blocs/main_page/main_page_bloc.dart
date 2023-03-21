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
  Map? dataForConn;
  

  MainPageBloc() : super(MainPageInitial()) {

    _getDataForConn().then((value) async{
      dataForConn = value;
    });
    // on<MainPageEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<GetOrdersEvent>((event, emit) async{
      var result = await _getOrdersFromServer(dt,dataForConn);
      emit(GetOrdersState());
    });
    on((event, emit) {
      emit(OnWillPopState());
    });
  }

  _getOrdersFromServer(date, dataForConn){
    var result = getOrders(dataForConn);
  }

  Future _getDataForConn()async{
    dataForConn = await getSaveNetworkSettings({});
    return dataForConn;
  }

}
