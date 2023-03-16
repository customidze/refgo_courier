part of 'networksettings_bloc.dart';

@immutable
abstract class NetworkSettingsState {
  Map networkSettings = {};
}

class NetworkSettingsInitial extends NetworkSettingsState {
  
  @override
  Map networkSettings = {};
  
   
   getAsync()async{
    
    networkSettings =  await getSaveNetworkSettings({});
  //   //add(GetNetworkSettingsEvent(networkSettings: networkSettings));
  
     }
  
}


class GetNetworkSettingsState extends NetworkSettingsState{

  @override
  Map networkSettings;

  GetNetworkSettingsState({required this.networkSettings});
}