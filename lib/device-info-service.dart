import 'dart:async';
import 'dart:io';
import 'package:google_api_availability/google_api_availability.dart';

class DeviceInfoService {
  Future<Map<String, dynamic>> getDeviceInfo() async {
    if (Platform.isIOS) {
      return <String, dynamic>{
        'os': "ios",
      };
    } else if (Platform.isAndroid) {
      bool isSupportGooglePlay = false;
      await checkGooglePlayServices().then((value) {
        if (value == true) isSupportGooglePlay = true;
      });
      return <String, dynamic>{
        'os': "android",
        'supportsGooglePlay': isSupportGooglePlay,
      };
    }
    return <String, dynamic>{'Error:': 'Failed to get platform information.'};
  }

  Future<bool> checkGooglePlayServices([bool showDialog = false]) async {
    GooglePlayServicesAvailability availability = await GoogleApiAvailability
        .instance
        .checkGooglePlayServicesAvailability();
    if (availability.value == 0) return true;

    return false;
  }
}
