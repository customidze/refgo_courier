part of 'main_page_bloc.dart';

@immutable
abstract class MainPageEvent {}

class GetOrdersEvent extends MainPageEvent {}

class OnWillPopEvent extends MainPageEvent{}

class RequestOrdersEvent extends MainPageEvent{}
