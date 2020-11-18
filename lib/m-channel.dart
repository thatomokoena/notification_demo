import 'package:flutter/services.dart';
import 'dart:convert';

class MChannel {
  static const platform =
      const MethodChannel('com.example.notification_demo/notification-hub');

  Future<String> getPushChannel() async {
    String retValue = "";
    try {
      print('MChannel: Getting push channel');
      do {
        retValue = await platform.invokeMethod('getPushChannel');
      } while (jsonDecode(retValue)['status'] == -1);

      if (jsonDecode(retValue)['status'] != -1)
        return jsonDecode(retValue)['pushChannel'];
      else
        return 'Failed';
    } catch (ex) {
      print(ex);
      return 'Failed';
    }
  }
}
