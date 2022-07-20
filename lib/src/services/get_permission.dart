import 'package:get/route_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import '../screens/homepage/screen.homepage.dart';

class DevicePermission {
  checkFilePermissionStatus() async {
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.manageExternalStorage] == PermissionStatus.granted) {
      
    }
  }

  getFilePermission() async => await Permission.storage.request();
}
