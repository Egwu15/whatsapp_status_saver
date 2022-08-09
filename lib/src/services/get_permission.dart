import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saf/saf.dart';

import '../config/config.dart';

class DevicePermission {
  checkFilePermissionStatus() async {
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
    ].request();

    if (result[Permission.storage] != PermissionStatus.granted) {
      debugPrint("no permission for storage");
    }
  }

  getFilePermission() async {
    await Permission.storage.request();
    try {
      Directory whatsappDirAndroid11 = Directory(Config.whatsappPathAndroid11);

      if (whatsappDirAndroid11.existsSync()) {
        debugPrint('android 11');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
        print('object');
      }
    }
  }

  Future<Saf?> getAndroid11Permission() async {
    Directory(Config.whatsappAndroid11FullPath);
    Saf saf = Saf(Config.whatsappPathAndroid11);

    await saf.getDirectoryPermission(
      isDynamic: true,
    );
    
    return saf;
  }
}
