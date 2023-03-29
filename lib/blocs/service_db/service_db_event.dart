part of 'service_db_bloc.dart';

@immutable
abstract class ServiceDbEvent {}

class ClearAllDataEvent extends ServiceDbEvent {}

class ClearOrdersEvent extends ServiceDbEvent {}
