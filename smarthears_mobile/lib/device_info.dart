import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class DeviceData {
  String id;
  String phoneModel;
  String sdkVersion;

  DeviceData(this.id, this.phoneModel, this.sdkVersion);
}

class DeviceInfo {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late DeviceData deviceData;

  Future<DeviceInfo> init() async {
    try {
      if (Platform.isAndroid) {
        deviceData = buildDeviceData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = buildDeviceData(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      print('Error retrieving device info');
    }
    return this;
  }

  DeviceData buildDeviceData(dynamic deviceInfo) {
    if (deviceInfo is AndroidDeviceInfo) {
      var version = deviceInfo.version;
      return DeviceData(deviceInfo.id, deviceInfo.model,
          '${version.baseOS}-${version.codename}-${version.incremental}-${version.release}-${version.securityPatch}-${version.previewSdkInt.toString()}-${version.sdkInt.toString()}');
    } else {
      return DeviceData(deviceInfo.identifierForVendor, deviceInfo.model,
          deviceInfo.systemName + "-" + deviceInfo.systemVersion);
    }
  }

  DeviceData getDeviceData() => deviceData;
}
