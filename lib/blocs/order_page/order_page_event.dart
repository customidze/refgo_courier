part of 'order_page_bloc.dart';

@immutable
abstract class OrderPageEvent {}

class SetStatusEvent extends OrderPageEvent {
  Status status;
  SetStatusEvent({required this.status});
}

class SetTypeOfPaymentsEvent extends OrderPageEvent {
  final TypeOfPayment top;
  SetTypeOfPaymentsEvent({required this.top});
}
