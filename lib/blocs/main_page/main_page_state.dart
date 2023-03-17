part of 'main_page_bloc.dart';

@immutable
abstract class MainPageState {}

class MainPageInitial extends MainPageState {}

class GetOrdersState extends MainPageState {
  List<Order> listOrder = [
    Order(
        uid: '1234f',
        nimber: '1',
        address: 'Видное, Ольховая 2',
        status: Status.inway),
    Order(
        uid: '1234g',
        nimber: '2',
        address:
            '142703, Россия, Московская область, Видное, Советский проезд д. 3',
        status: Status.delivered)
  ];
}

class Order {
  String uid;
  String nimber;
  String address;
  Status status;
  Order(
      {required this.uid,
      required this.nimber,
      required this.address,
      required this.status});
}
