import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:refgo_courier/domain/get_save_network_settings.dart';
import 'package:refgo_courier/enums.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  List<Order>? listOrder;
  DateTime dt = DateTime.now();
  Map? dataForConn;

  MainPageBloc() : super(MainPageInitial()) {
    _getDataForConn().then((value) async {
      dataForConn = value;
    });
    // on<MainPageEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<GetOrdersEvent>((event, emit) {
      //var result = await _getOrdersFromServer(dt, dataForConn);
      //emit(GetOrdersState());
    });
    on<OnWillPopEvent>((event, emit) {
      emit(OnWillPopState(listOrder: listOrder!));
    });
    on<RequestOrdersEvent>((event, emit) {
      if (dataForConn != null) {
        emit(WaitState());
        _getOrders(dataForConn!);
      } else {
        emit(ErrorState(error: 'Не заполнены сетевые настройки!'));
      }
    });
  }

  // _getOrdersFromServer(date, dataForConn) async {
  //   var result = await getOrders(dataForConn);
  // }

  Future _getDataForConn() async {
    dataForConn = await getSaveNetworkSettings({});
    return dataForConn;
  }

  Future _getOrders(Map dataForConn) async {
    //Map dataForConn = await getSettingFromDB();
    String addrServer = dataForConn['ctrlAddrServer'];
    String userName = dataForConn['ctrlUserName'];
    String passwd = dataForConn['ctrlPasswd'];
    String id = dataForConn['ctrlId'];

    Map resultJson = {};
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$userName:$passwd'))}';
    var url =
        Uri.http(addrServer, 'tms/hs/es-mobile/GetDeliveryReport', {'id': id});

    final response = await http.post(url,
        body: '{login:$userName,password:$passwd}',
        headers: <String, String>{'authorization': basicAuth}).then((response) {
      //print(response.statusCode);

      //print(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        resultJson = jsonDecode(utf8.decode(response.bodyBytes));
        resultJson['status'] = 'ok';

        List reportsList = resultJson['Отчеты'];

        if (reportsList.isEmpty) {
          emit(GetOrdersState(listOrder: const []));
          return;
        }

        listOrder =
            List.generate(reportsList[0]['Заказы'].length, (index) {
          return Order(
              uid: reportsList[0]['Заказы'][index]['УИДДокументаДоставки'],
              nimber: reportsList[0]['Заказы'][index]['Номер'],
              address: reportsList[0]['Заказы'][index]['АдресДоставки'],
              status: Status.inway,
              lat: reportsList[0]['Заказы'][index]['Долгота'],
              long: reportsList[0]['Заказы'][index]['Широта']);
        }).toList();
        emit(GetOrdersState(listOrder: listOrder!));

        print(utf8.decode(response.bodyBytes));
      } else {
        resultJson = {
          'info': response.statusCode.toString(),
          'status': 'error'
        };
      }
    });

    //return result;
  }
}
