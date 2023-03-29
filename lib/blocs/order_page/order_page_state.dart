part of 'order_page_bloc.dart';

@immutable
abstract class OrderPageState {
  get top => null;

  get lb => null;
}

class OrderPageInitial extends OrderPageState {
  final List<bool> lb = [true, false];
}

class SetStatusState extends OrderPageState {
  final Status status;

  SetStatusState({required this.status});
}

class SetTypeOfPaymentsState extends OrderPageState {
  final List<bool> lb;
  SetTypeOfPaymentsState({required this.lb});
}
