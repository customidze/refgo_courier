import 'package:hive/hive.dart';


part 'order.g.dart';
@HiveType(typeId: 0)
class Order {
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
      required this.accompanyingDoc});
}

class Good {
  String nimber;
  String code;
  String name;
  String art;
  String barcode;
  num count;
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

@HiveType(typeId: 1)
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
@HiveType(typeId: 2)
enum TypeOfPayment{
  @HiveField(0)
  cash,
  @HiveField(1)
  cashless
}