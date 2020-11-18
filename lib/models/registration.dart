import './installation.dart';

class Registration {
  int devicePlatform;
  Installation installation;

  Registration(this.installation, this.devicePlatform);

  int get getDevicePlatform => devicePlatform;

  set setDevicePlatform(int devicePlatform) =>
      this.devicePlatform = devicePlatform;

  Installation get getInstallation => installation;

  set setInstallation(Installation installation) =>
      this.installation = installation;

  Map<String, dynamic> toJson() => {
        'installation': installation.toJson(),
        'devicePlatform': devicePlatform,
      };
}
