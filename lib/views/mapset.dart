import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../controller/alarm_controller.dart';
import '../controller/location_controller.dart';
import '../service/distance_calculate.dart';
import '../widgets/alarmdialouge.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  LocationController controller = Get.put(LocationController());
  AlarmController alarmcontroller = Get.put(AlarmController());
  late GoogleMapController mapController;
  late Position currentPosition;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Obx(
        () => (controller.isLoading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FlutterLocationPicker(
                initPosition: LatLong(controller.currentPosition.latitude,
                    controller.currentPosition.longitude),
                selectLocationButtonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                selectLocationButtonText: 'Set Current Location',
                initZoom: 11,
                minZoomLevel: 5,
                maxZoomLevel: 16,
                trackMyPosition: true,
                onError: (e) => print(e),
                onPicked: (pickedData) {
                  print(pickedData.addressData.keys);
                  print(pickedData.addressData["road"]);

                  print(pickedData.addressData["city"]);
                  var distance = distanceCalculate(
                    controller.currentPosition.latitude,
                    controller.currentPosition.longitude,
                    pickedData.latLong.latitude,
                    pickedData.latLong.longitude,
                  );
                  finalDialouge(
                    pickedData.address,
                    distance,
                    pickedData.latLong.latitude,
                    pickedData.latLong.longitude,
                  );
                }),
      ),
    ));
  }
}
