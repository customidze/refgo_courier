
part of 'main_page_bloc.dart';



@immutable
abstract class MainPageState {
  get listOrder => null;
}

class MainPageInitial extends MainPageState {}

class GetOrdersState extends MainPageState {
  @override
  final List<Order> listOrder;
  GetOrdersState({required this.listOrder});

}

class OnWillPopState extends MainPageState {
  @override
  final List<Order> listOrder;
  OnWillPopState({required this.listOrder});
}

class ErrorState extends MainPageState {
  final String error;
  ErrorState({required this.error});
}

class WaitState extends MainPageState {}

class SetDateState extends MainPageState{}

