import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../service/location_service.dart';
import 'alarm_controller.dart';

class LocationController extends GetxController {
  AlarmController alarmcontroller = Get.put(AlarmController());
  late Position currentPosition;
  var isLoading = true.obs;
  void getCurrentLocation() async {
    try {
      final position = await determinePosition();

      currentPosition = position;
      isLoading(false);
    } catch (e) {
      Get.snackbar("Facing Problem", e.toString());
    }
  }
}
