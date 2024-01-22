import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageServices extends GetxController {
  final storage = GetStorage();

  saveCredentials({
    required String id,
    required String email,
    required String role,
  }) {
    storage.write("id", id);
    storage.write("email", email);
    storage.write("role", role);
  }

  removeStorageCredentials() {
    storage.remove("id");
    storage.remove("email");
    storage.remove("role");
  }

  saveRoute({required String screen}) {
    storage.write("screen", screen);
  }
}
