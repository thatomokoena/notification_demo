import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/registration.dart';

class DeviceNotificationInstallationAPI {
  final String _baseUrl =
      'https://notificationhubapp.azurewebsites.net/api/'; //TM: The URL to the Azure function app  'http://192.168.8.104:7071/api/'; //
  final Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Header': 'Ocp-Apim-Subscription-Key',
    'HeaderValue': 'e93864b118164cdbba1fb72967c8cc09',
  };

  //POST
  Future<int> registerDevice(Registration registration) async {
    String resource =
        'HttpExample'; //TM: Name of the function in the Azure function app
    var uri = Uri.parse(_baseUrl + resource);
    final http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(registration.toJson()),
    );

    if (response.statusCode == 200 &&
        response.body.toString().contains('successful')) {
      return 0;
    } else {
      return -1;
    }
  }
}
