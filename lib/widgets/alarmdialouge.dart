import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_alarm/views/Home.dart';

import '../controller/alarm_controller.dart';
import '../models/alarms_model.dart';

void finalDialouge(
    String address, double distance, double targetlat, double targetlng) {
  final nameController = TextEditingController();
  final rangeController = TextEditingController();
  AlarmController alarmcontroller = Get.put(AlarmController());

  Get.dialog(
    AlertDialog(
      title: const Text('Set Alarm'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: rangeController,
            decoration: const InputDecoration(labelText: 'Range (km)'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          onPressed: () {
            alarmcontroller.locations.add(LocationData(
                targetlat,
                targetlng,
                address,
                RxDouble(distance),
                nameController.text,
                double.parse(rangeController.text),
                RxBool(true)));
            Get.offAll(() => const Home());
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
