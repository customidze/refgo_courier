part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

class GetOrdersEvent extends MainPageEvent {}

class OnWillPopEvent extends MainPageEvent {}

class RequestOrdersEvent extends MainPageEvent {
  final DateTime dt;
  RequestOrdersEvent({required this.dt});
}

class SetDateEvent extends MainPageEvent {
  final DateTime date;
  SetDateEvent({required this.date});
}
