import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:refgo_courier/domain/get_save_network_settings.dart';
import 'package:refgo_courier/domain/order.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  List<Order>? listOrder;
  DateTime dt = DateTime.now();
  Map? dataForConn;

  MainPageBloc() : super(MainPageInitial()) {
    _getOrdersFromDB(DateTime.now());

    _getDataForConn().then((value) async {
      dataForConn = value;
    });
    // on<MainPageEvent>((event, emit) {
    //   // implement event handler
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
        _getOrders(dataForConn!, dt);
      } else {
        emit(ErrorState(error: 'Не заполнены сетевые настройки!'));
      }
    });
    on<SetDateEvent>((event, emit) {
      _getOrdersFromDB(event.date);
      emit(SetDateState());
    });
  }

  // _getOrdersFromServer(date, dataForConn) async {
  //   var result = await getOrders(dataForConn);
  // }

  Future _getDataForConn() async {
    dataForConn = await getSaveNetworkSettings({});
    return dataForConn;
  }

  Future _getOrders(Map dataForConn, DateTime dt) async {
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
          // ignore: invalid_use_of_visible_for_testing_member
          emit(GetOrdersState(listOrder: const []));
          return;
        }

        listOrder = List.generate(reportsList[0]['Заказы'].length, (index) {
          return Order(
            uidReport: reportsList[0]['Заказы'][index]['УИДОтчета'],
            uid: reportsList[0]['Заказы'][index]['УИДДокументаДоставки'],
            nimber: reportsList[0]['Заказы'][index]['Номер'],
            address: reportsList[0]['Заказы'][index]['АдресДоставки'],
            status: Status.on_way,
            lat: reportsList[0]['Заказы'][index]['Долгота'],
            long: reportsList[0]['Заказы'][index]['Широта'],
            invoice: reportsList[0]['Заказы'][index]['НомерНакладной'],
            inInvoice: reportsList[0]['Заказы'][index]['ВхНакладная'],
            recepientFIO: reportsList[0]['Заказы'][index]['ФИОПолучателя'],
            customer: reportsList[0]['Заказы'][index]['Заказчик'],
            customerContactPerson: reportsList[0]['Заказы'][index]
                ['ЗаказчикКонтактноеЛицо'],
            customerTel: reportsList[0]['Заказы'][index]['ЗаказчикТелефон'],
            prepaid: reportsList[0]['Заказы'][index]['Предоплачен'],
            windowStart:
                DateTime.parse(reportsList[0]['Заказы'][index]['ВремяС']),
            windowEnd:
                DateTime.parse(reportsList[0]['Заказы'][index]['ВремяПо']),
            deliveryDate:
                DateTime.parse(reportsList[0]['Заказы'][index]['ДатаДоставки']),
            comment: reportsList[0]['Заказы'][index]['Комментарий'],
            note: reportsList[0]['Заказы'][index]['Примечание'],
            tempRegime: reportsList[0]['Заказы'][index]['ТемпературныйРежим'],
            accompanyingDoc: reportsList[0]['Заказы'][index]
                ['СопроводительнаяДокументация'],
          );
        }).toList();
        emit(GetOrdersState(listOrder: listOrder!));

        if (listOrder!.isNotEmpty) {
          saveOrders(DateTime.now());
        }

        //print(utf8.decode(response.bodyBytes));
      } else {
        resultJson = {
          'info': response.statusCode.toString(),
          'status': 'error'
        };
      }
    });

    //return result;
  }

  saveOrders(DateTime dtKey) async {
    var boxOrders = await Hive.openBox('Orders');
    boxOrders.put(
        '${dtKey.day}-${dtKey.month}-${dtKey.year}',
        listOrder);
  }

  _getOrdersFromDB(DateTime dtKey) async {
    var boxOrders = await Hive.openBox('Orders');
    List? listOrderDynamic =
        await boxOrders.get('${dtKey.day}-${dtKey.month}-${dtKey.year}');
    if (listOrderDynamic != null) {
      listOrder = listOrderDynamic.cast<Order>();

      emit(GetOrdersState(listOrder: listOrder!));
    }else{
      emit(GetOrdersState(listOrder: const []));
    }

  }
}
