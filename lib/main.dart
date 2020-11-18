import 'package:flutter/material.dart';
import 'package:notification_demo/device-notification-installation.dart';
import 'package:notification_demo/models/device-platform.dart';
import 'package:notification_demo/models/installation.dart';
import 'package:notification_demo/models/registration.dart';
import './device-info-service.dart';
import './m-channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Registration App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final txtEmailController = TextEditingController();
  final txtServiceNumController = TextEditingController();

  final MChannel _mChannel = MChannel();
  final DeviceNotificationInstallationAPI _deviceNotificationInstallationAPI =
      DeviceNotificationInstallationAPI();
  String _pushChannel;
  DeviceInfoService _deviceInfoService = DeviceInfoService();
  Map<String, dynamic> _deviceData;
  String _response;

  @override
  void initState() {
    super.initState();
    _deviceInfoService.getDeviceInfo().then((value) {
      setState(() {
        _deviceData = value;
      });
    });

    _mChannel.getPushChannel().then((value) {
      setState(() {
        _pushChannel = value;
        print('FCM token: $_pushChannel');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: txtServiceNumController,
              decoration: InputDecoration(
                hintText: 'Service Number',
              ),
            ),
            TextField(
              controller: txtEmailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            Text(
              '$_response',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          registerDevice();
        },
        child: Text('Reg'),
      ),
    );
  }

  void registerDevice() {
    if (_pushChannel != 'Failed' &&
        txtEmailController.text.isNotEmpty &&
        txtServiceNumController.text.isNotEmpty) {
      int devicePlatform = DevicePlatform.UNKNOWN;

      if (_deviceData['os'] == 'ios')
        devicePlatform = DevicePlatform.APNS;
      else if (_deviceData['os'] == 'android' &&
          _deviceData['supportsGooglePlay'] == true)
        devicePlatform = DevicePlatform.GCM;
      else if (_deviceData['os'] == 'android' &&
          _deviceData['supportsGooglePlay'] == false)
        devicePlatform = DevicePlatform.HMS;

      Installation installation = Installation(
          txtEmailController.text, _pushChannel, txtServiceNumController.text);
      Registration registration = Registration(installation, devicePlatform);
      print(registration.toJson().toString());

      _deviceNotificationInstallationAPI
          .registerDevice(registration)
          .then((value) {
        if (value == 0) {
          setState(() {
            _response = 'Registration successful';
          });
        } else {
          setState(() {
            _response = 'Registration unsuccessful';
          });
        }
      });
    } else {
      print('Why am I here???:(');
    }
  }
}
