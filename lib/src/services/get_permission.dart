import 'package:permission_handler/permission_handler.dart';

class DevicePermission {
  checkFilePermissionStatus() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      getFilePermission();
    } else {
      return false;
    }
  }

  getFilePermission() async => await Permission.storage.request();
}
