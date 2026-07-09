import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
      if (kIsWeb) {
        WebBrowserInfo webInfo = await _deviceInfo.webBrowserInfo;
        return {
          'deviceId': 'Unknown',
          'platform': '${webInfo.vendor ?? ''} ${webInfo.userAgent ?? ''}',
        };
      } else if (TargetPlatform.android == defaultTargetPlatform) {
        // Jika Android
        AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        return {
          'deviceId': androidInfo.id,
          'platform':
              '${androidInfo.isPhysicalDevice ? 'Android' : 'Android Emulator'} ${androidInfo.version.release} | ${androidInfo.manufacturer} ${androidInfo.brand} ${androidInfo.model}',
        };
      } else if (TargetPlatform.iOS == defaultTargetPlatform) {
        // Jika iOS
        IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        return {
          'deviceId': iosInfo.identifierForVendor,
          'platform':
              '${iosInfo.isPhysicalDevice ? 'iOS' : 'iOS Simulator'} ${iosInfo.systemVersion} | ${iosInfo.name} ${iosInfo.model} ${iosInfo.systemName}',
        };
      } else {
        return {'deviceId': 'Unknown', 'platform': 'Unknown'};
      }
    } catch (e) {
      return {'deviceId': 'Unknown', 'platform': e.toString()};
    }
  }
}
