import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

part 'order.g.dart';


@HiveType(typeId: 0)
class Order{
  @HiveField(0)
  String uidReport;
  @HiveField(1)
  String uid;
  @HiveField(2)
  String nimber;
  @HiveField(3)
  String address;
  //TypeOfDelevivery
  @HiveField(4)
  Status status;
  @HiveField(5)
  double lat;
  @HiveField(6)
  double long;
  @HiveField(7)
  String invoice;
  @HiveField(8)
  String inInvoice;
  @HiveField(9)
  String recepientFIO;
  @HiveField(10)
  String customer;
  @HiveField(11)
  String customerContactPerson;
  @HiveField(12)
  String customerTel;
  //NPPlan
  //NPFact
  //typeOfPayment
  @HiveField(13)
  bool prepaid;
  @HiveField(14)
  DateTime windowStart;
  @HiveField(15)
  DateTime windowEnd;
  @HiveField(16)
  DateTime deliveryDate;
  @HiveField(17)
  String comment;
  @HiveField(18)
  String note;
  @HiveField(19)
  String tempRegime;
  @HiveField(20)
  bool accompanyingDoc;
  @HiveField(21)
  List<Good> listGoods;
  @HiveField(22)
  int lateArrival;

  //String cost;

  Order(
      {required this.uidReport,
      required this.uid,
      required this.nimber,
      required this.address,
      required this.status,
      required this.lat,
      required this.long,
      required this.invoice,
      required this.inInvoice,
      required this.recepientFIO,
      required this.customer,
      required this.customerContactPerson,
      required this.customerTel,
      required this.prepaid,
      required this.windowStart,
      required this.windowEnd,
      required this.deliveryDate,
      required this.comment,
      required this.note,
      required this.tempRegime,
      required this.accompanyingDoc,
      required this.listGoods,
      required this.lateArrival
      });

  sendToServer(Map dataForConn) async {
    String addrServer = dataForConn['ctrlAddrServer'];
    String userName = dataForConn['ctrlUserName'];
    String passwd = dataForConn['ctrlPasswd'];
    String id = dataForConn['ctrlId'];

    DateTime lateDT = DateTime(1);

    Duration duration = Duration(seconds: lateArrival);
    DateTime late = lateDT.add(duration);
    //0000-01-01T00:30:00.000
    //"Опоздание":"0001-01-01T00:30:52"
    String lateString = late.toIso8601String().substring(0, late.toIso8601String().length -4);

    String jsonStringBody = '''{'НомерОтчета':'0001','УИДОтчета':$uidReport,'Заказы':[{НомерОтчета':'0001','УИДОтчета':$uidReport,
      'УИДДокументаДоставки':$uid,'ЭтоЗаказ':'true','Номер':$nimber,'СтатусЗаказа':${status.name},'Опоздание':$lateString
    }]}''';


    String result = '';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$userName:$passwd'));
    var url =
        Uri.http(addrServer, 'tms/hs/es-mobile/SendDeliveryReport', {'id': id});

    final response = await http.post(url,
        //body: '{login:$userName,password:$passwd}',
        body: jsonStringBody,
        headers: <String, String>{'authorization': basicAuth}).then((response) {
      //print(response.statusCode);

      print(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        //saveSettingsInBD(addrServer, userName, passwd);
        //BlocProvider.of<MainPageBloc>(context).add(GetOrdersEvent());
        print(utf8.decode(response.bodyBytes));
        result = response.statusCode.toString();
      } else {
        result = response.statusCode.toString();
      }
    });
  }
}

@HiveType(typeId: 1)
class Good {
  @HiveField(0)
  String nimber;
  @HiveField(1)
  String code;
  @HiveField(2)
  String name;
  @HiveField(3)
  String art;
  @HiveField(4)
  String barcode;
  @HiveField(5)
  num count;
  @HiveField(6)
  num price;
  Good(
      {required this.nimber,
      required this.code,
      required this.name,
      required this.art,
      required this.barcode,
      required this.count,
      required this.price});
}

@HiveType(typeId: 2)
enum Status {
  @HiveField(0)
  registered,
  @HiveField(1)
  received,
  @HiveField(2)
  transit,
  @HiveField(3)
  assigned,
  @HiveField(4)
  on_way,
  @HiveField(5)
  delivered,
  @HiveField(6)
  part_delivered,
  @HiveField(7)
  returned,
  @HiveField(8)
  canceled,
  @HiveField(9)
  customer_cancel,
  @HiveField(10)
  on_way_no_connection,
  @HiveField(11)
  in_place_no_connection,
  @HiveField(12)
  planned
}

@HiveType(typeId: 3)
enum TypeOfPayment {
  @HiveField(0)
  cash,
  @HiveField(1)
  cashless
}

