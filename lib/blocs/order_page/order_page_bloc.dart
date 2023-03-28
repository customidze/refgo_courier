import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refgo_courier/blocs/main_page/main_page_bloc.dart';
import 'package:refgo_courier/domain/order.dart';

part 'order_page_event.dart';
part 'order_page_state.dart';

class OrderPageBloc extends Bloc<OrderPageEvent, OrderPageState> {
  String? number;
  Order? order;

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
        emit(SetTypeOfPaymentsState(lb: const [true, false]));
      } else {
        emit(SetTypeOfPaymentsState(lb: const [false, true]));
      }
    });
  }
}
