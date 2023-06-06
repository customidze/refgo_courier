import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refgo_courier/domain/get_save_network_settings.dart';
import 'package:refgo_courier/domain/order.dart';

part 'order_page_event.dart';
part 'order_page_state.dart';

class OrderPageBloc extends Bloc<OrderPageEvent, OrderPageState> {
  String? number;
  Order? order;
  List<bool> top = const [true, false];

  OrderPageBloc() : super(OrderPageInitial()) {
    //   on<OrderPageEvent>((event, emit) {
    //     // TODO: implement event handler
    //   });
    on<SetStatusEvent>((event, emit) {
      order!.status = event.status;
      emit(SetStatusState(status: event.status));
    });
    on<SetTypeOfPaymentsEvent>((event, emit) {
      if (event.top == TypeOfPayment.cash) {
        top = const [true, false];
        emit(SetTypeOfPaymentsState(lb: const [true, false]));
      } else {
        top = const [false, true];
        emit(SetTypeOfPaymentsState(lb: const [false, true]));
      }
    });
    on<SendDataToServerEvent>((event, emit) async {
      Map dataForConn = await getSaveNetworkSettings({});
      order?.sendToServer(dataForConn);
    });
    on<SetLateEvent>((event, emit) {
      order!.lateArrival = event.late.inSeconds;
      emit(SetLateState(late: event.late));
    });
  }
}
