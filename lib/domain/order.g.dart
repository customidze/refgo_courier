// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 0;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      uidReport: fields[0] as String,
      uid: fields[1] as String,
      nimber: fields[2] as String,
      address: fields[3] as String,
      status: fields[4] as Status,
      lat: fields[5] as double,
      long: fields[6] as double,
      invoice: fields[7] as String,
      inInvoice: fields[8] as String,
      recepientFIO: fields[9] as String,
      customer: fields[10] as String,
      customerContactPerson: fields[11] as String,
      customerTel: fields[12] as String,
      prepaid: fields[13] as bool,
      windowStart: fields[14] as DateTime,
      windowEnd: fields[15] as DateTime,
      deliveryDate: fields[16] as DateTime,
      comment: fields[17] as String,
      note: fields[18] as String,
      tempRegime: fields[19] as String,
      accompanyingDoc: fields[20] as bool,
      listGoods: (fields[21] as List).cast<Good>(),
      lateArrival: fields[22] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.uidReport)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.nimber)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.long)
      ..writeByte(7)
      ..write(obj.invoice)
      ..writeByte(8)
      ..write(obj.inInvoice)
      ..writeByte(9)
      ..write(obj.recepientFIO)
      ..writeByte(10)
      ..write(obj.customer)
      ..writeByte(11)
      ..write(obj.customerContactPerson)
      ..writeByte(12)
      ..write(obj.customerTel)
      ..writeByte(13)
      ..write(obj.prepaid)
      ..writeByte(14)
      ..write(obj.windowStart)
      ..writeByte(15)
      ..write(obj.windowEnd)
      ..writeByte(16)
      ..write(obj.deliveryDate)
      ..writeByte(17)
      ..write(obj.comment)
      ..writeByte(18)
      ..write(obj.note)
      ..writeByte(19)
      ..write(obj.tempRegime)
      ..writeByte(20)
      ..write(obj.accompanyingDoc)
      ..writeByte(21)
      ..write(obj.listGoods)
      ..writeByte(22)
      ..write(obj.lateArrival);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoodAdapter extends TypeAdapter<Good> {
  @override
  final int typeId = 1;

  @override
  Good read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Good(
      nimber: fields[0] as String,
      code: fields[1] as String,
      name: fields[2] as String,
      art: fields[3] as String,
      barcode: fields[4] as String,
      count: fields[5] as num,
      price: fields[6] as num,
    );
  }

  @override
  void write(BinaryWriter writer, Good obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nimber)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.art)
      ..writeByte(4)
      ..write(obj.barcode)
      ..writeByte(5)
      ..write(obj.count)
      ..writeByte(6)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 2;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.registered;
      case 1:
        return Status.received;
      case 2:
        return Status.transit;
      case 3:
        return Status.assigned;
      case 4:
        return Status.on_way;
      case 5:
        return Status.delivered;
      case 6:
        return Status.part_delivered;
      case 7:
        return Status.returned;
      case 8:
        return Status.canceled;
      case 9:
        return Status.customer_cancel;
      case 10:
        return Status.on_way_no_connection;
      case 11:
        return Status.in_place_no_connection;
      case 12:
        return Status.planned;
      default:
        return Status.registered;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.registered:
        writer.writeByte(0);
        break;
      case Status.received:
        writer.writeByte(1);
        break;
      case Status.transit:
        writer.writeByte(2);
        break;
      case Status.assigned:
        writer.writeByte(3);
        break;
      case Status.on_way:
        writer.writeByte(4);
        break;
      case Status.delivered:
        writer.writeByte(5);
        break;
      case Status.part_delivered:
        writer.writeByte(6);
        break;
      case Status.returned:
        writer.writeByte(7);
        break;
      case Status.canceled:
        writer.writeByte(8);
        break;
      case Status.customer_cancel:
        writer.writeByte(9);
        break;
      case Status.on_way_no_connection:
        writer.writeByte(10);
        break;
      case Status.in_place_no_connection:
        writer.writeByte(11);
        break;
      case Status.planned:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TypeOfPaymentAdapter extends TypeAdapter<TypeOfPayment> {
  @override
  final int typeId = 3;

  @override
  TypeOfPayment read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TypeOfPayment.cash;
      case 1:
        return TypeOfPayment.cashless;
      default:
        return TypeOfPayment.cash;
    }
  }

  @override
  void write(BinaryWriter writer, TypeOfPayment obj) {
    switch (obj) {
      case TypeOfPayment.cash:
        writer.writeByte(0);
        break;
      case TypeOfPayment.cashless:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeOfPaymentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
