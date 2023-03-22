part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {
  get listOrder => null;
  
}

class MainPageInitial extends MainPageState {}

class GetOrdersState extends MainPageState {
  List<Order> listOrder;
  GetOrdersState({required this.listOrder});

  
  //  = [
  //   Order(
  //       uid: '1234f',
  //       nimber: 'НФНФ-42342344',
  //       address: 'Видное, Ольховая 2',
  //       status: Status.inway,
  //       lat: 54.926934,
  //       long: 37.392463),
  //   Order(
  //       uid: '1234g',
  //       nimber: 'НФНФ-42342345',
  //       address:
  //           '142703, Россия, Московская область, Видное, Советский проезд д. 3',
  //       status: Status.delivered,
  //       lat: 54.924908,
  //       long: 37.402234),
  //   Order(
  //       uid: '1234f',
  //       nimber: 'НФНФ-42342344',
  //       address: 'Видное, Ольховая 2',
  //       status: Status.inway,
  //       lat: 54.913297,
  //       long: 37.415733),
  //   Order(
  //       uid: '1234g',
  //       nimber: 'НФНФ-42342345',
  //       address: 'Корстон',
  //       status: Status.delivered,
  //       lat: 54.918405,
  //       long: 37.427263),
  //   Order(
  //       uid: '1234f',
  //       nimber: 'НФНФ-42342344',
  //       address: 'россельхоз банк',
  //       status: Status.inway,
  //       lat: 54.919761,
  //       long: 37.436876),
  //   Order(
  //       uid: '1234g',
  //       nimber: 'НФНФ-42342345',
  //       address:
  //           '142703, Россия, Московская область, Видное, Советский проезд д. 3',
  //       status: Status.delivered,
  //       lat:55.641658, 
  //       long:37.619584),
   
  // ];
}

class OnWillPopState extends MainPageState{
  List<Order> listOrder;
  OnWillPopState({required this.listOrder});
  
}
class ErrorState extends MainPageState{
  final String error;
  ErrorState({required this.error});
}
class WaitState extends MainPageState{}

class Order {
  String uid;
  String nimber;
  String address;
  Status status;
  double lat;
  double long;
  //String cost;
  Order(
      {required this.uid,
      required this.nimber,
      required this.address,
      required this.status,
      required this.lat,
      required this.long});
}
