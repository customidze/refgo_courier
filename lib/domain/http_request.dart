import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getTestConn(Map dataForConn) async {
  //Map dataForConn = await getSettingFromDB();
  String addrServer = dataForConn['addrServer'];
  String userName = dataForConn['userName'];
  String passwd = dataForConn['passwd'];
  String id = dataForConn['id'];

  String result = '';
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$userName:$passwd'));
  var url = Uri.http(addrServer, 'tms/hs/es-mobile/GetDeliveryReport',{'id':id});

  final response = await http.post(url,
      body: '{login:$userName,password:$passwd}',
      headers: <String, String>{'authorization': basicAuth}).then((response) {
    //print(response.statusCode);

    //print(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      //saveSettingsInBD(addrServer, userName, passwd);
      print(utf8.decode(response.bodyBytes));
      result = response.statusCode.toString();
    } else {
      result = response.statusCode.toString();
    }
  });

  return result;
}

Future<String> getOrders(Map dataForConn) async {
  //Map dataForConn = await getSettingFromDB();
  String addrServer = dataForConn['addrServer'];
  String userName = dataForConn['userName'];
  String passwd = dataForConn['passwd'];
  String id = dataForConn['id'];

  String result = '';
  String basicAuth = 'Basic ' + base64Encode(utf8.encode('$userName:$passwd'));
  var url = Uri.http(addrServer, 'tms/hs/es-mobile/GetDeliveryReport',{'id':id});

  final response = await http.post(url,
      body: '{login:$userName,password:$passwd}',
      headers: <String, String>{'authorization': basicAuth}).then((response) {
    //print(response.statusCode);

    print(utf8.decode(response.bodyBytes));

    if (response.statusCode == 200) {
      //saveSettingsInBD(addrServer, userName, passwd);
      print(utf8.decode(response.bodyBytes));
      result = response.statusCode.toString();
    } else {
      result = response.statusCode.toString();
    }
  });

  return result;
}