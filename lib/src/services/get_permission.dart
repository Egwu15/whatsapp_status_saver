import 'package:permission_handler/permission_handler.dart';

class DevicePermission {
  checkFilePermissionStatus() async {
    Map<Permission, PermissionStatus> result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    //if permission is granted only then show home screen else permission error screen is already shown
    if (result[Permission.storage] == PermissionStatus.granted &&
        result[Permission.manageExternalStorage] == PermissionStatus.granted) {
      // todo:set no permission error screen
    }
  }

  getFilePermission() async => await Permission.storage.request();
}
