import 'package:get/get.dart';

class LocationData {
  double targetLat;
  double targetLng;
  String address;
  var distance = 0.0.obs;
  String name;
  double range;
  var status = false.obs;

  LocationData(this.targetLat, this.targetLng, this.address, this.distance,
      this.name, this.range, this.status);
}
