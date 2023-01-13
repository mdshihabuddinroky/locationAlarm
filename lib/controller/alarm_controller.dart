import 'dart:async';
import 'package:get/get.dart';
import '../models/alarms_model.dart';
import '../service/distance_calculate.dart';
import '../service/location_service.dart';
import 'package:alarm/alarm.dart';

import '../views/alarmRinging.dart';

class AlarmController extends GetxController {
  var alarmt = Alarm.init();

  RxList<LocationData> locations = RxList<LocationData>();
  void offAlarm() {
    Alarm.stop();
  }

  void onAlarm(String name) {
    Alarm.set(
      alarmDateTime: DateTime.now(),
      loopAudio: true,
      assetAudio: "assets/woohoo.mp3",
      onRing: () {},
      notifTitle: name,
      notifBody: 'Your are at your location',
    );
    Get.to(() => const AlarmRinging());
  }

  void start() {
    Timer.periodic(const Duration(minutes: 1), (timer) async {
      for (var location in locations.asMap().entries) {
        int index = location.key;
        LocationData values = location.value;
        print('$index: ${values.name}');
        if (values.status.value) {
          final position = await determinePosition();
          print("lat: ${position.latitude} lng: ${position.longitude}");
          double distance = distanceCalculate(position.latitude,
              position.longitude, values.targetLat, values.targetLng);
          // ...
          final updatedLocation = LocationData(
              values.targetLat,
              values.targetLng,
              values.address,
              RxDouble(distance),
              values.name,
              values.range,
              values.status);
          locations[index] = updatedLocation;

          locations[index].distance(distance);
          //print("current distance: ${locations[index].distance}");

          // locations.insert(
          //     index,
          //     LocationData(
          //         values.targetLat, values.targetLng, values.address,distance,values.name,values.range,values.status));

          if (distance <= values.range) {
            onAlarm(values.name);
            print("Alarm on for $index");
            locations[index].status(false);
            // Distance is within range, do something
          }
        }
      }
    });
  }
}
