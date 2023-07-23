import 'package:get/get.dart';
import 'package:tabibi/services/users.dart';

class DoctorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }
}
