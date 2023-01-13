import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controller/alarm_controller.dart';
import 'Home.dart';

class AlarmRinging extends StatelessWidget {
  const AlarmRinging({super.key});

  @override
  Widget build(BuildContext context) {
    var isFinished = true.obs;
    AlarmController alarmcontroller = Get.put(AlarmController());
    return Scaffold(
        body: Column(
      children: [
        const Spacer(),
        Lottie.asset("assets/ringing.json"),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: SwipeButton.expand(
            thumb: const Icon(
              Icons.double_arrow_rounded,
              color: Colors.white,
            ),
            activeThumbColor: Colors.red,
            activeTrackColor: Colors.grey.shade300,
            onSwipe: () {
              print("onfinish");
              isFinished(false);
              alarmcontroller.offAlarm();
              Get.offAll(() => const Home(),
                  transition: Transition.circularReveal);
            },
            child: const Text(
              "Swipe to off Alarm",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )),
        ),
      ],
    ));
  }
}
