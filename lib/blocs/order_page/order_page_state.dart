part of 'order_page_bloc.dart';

@immutable
abstract class OrderPageState {}

class OrderPageInitial extends OrderPageState {
  
  
}

class SetStatusState extends OrderPageState{
  Status status;

  SetStatusState({required this.status});
}
