part of 'networksettings_bloc.dart';

@immutable
abstract class NetworkSettingsEvent {}

class GetNetworkSettingsEvent extends NetworkSettingsEvent {
  final Map? networkSettings;
  GetNetworkSettingsEvent({required this.networkSettings});
}

class SaveNetworkSettingsEvent extends NetworkSettingsEvent {
  final Map? networkSettings;
  SaveNetworkSettingsEvent({required this.networkSettings});
}
