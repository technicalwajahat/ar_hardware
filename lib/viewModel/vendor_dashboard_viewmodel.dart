import 'package:ar_hardware/repository/auth_repository.dart';
import 'package:get/get.dart';

class VendorDashboardViewModel extends GetxController {
  var screenIndex = 0.obs;
  final _authRepo = Get.put(AuthRepository());

  void handleScreenChanged(int selectedScreen) {
    if (selectedScreen == 0) {
      Get.back();
    } else {
      _authRepo.logout();
    }
  }
}
