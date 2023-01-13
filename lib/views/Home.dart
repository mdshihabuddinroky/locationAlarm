import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_alarm/views/mapset.dart';
import 'package:lottie/lottie.dart';

import '../controller/alarm_controller.dart';
import '../controller/location_controller.dart';
import '../models/alarms_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    AlarmController alarmcontroller = Get.put(AlarmController());
    LocationController controller = Get.put(LocationController());
    controller.getCurrentLocation();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Location Alarm",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => (alarmcontroller.locations.isEmpty)
            ? (controller.isLoading.value)
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ))
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          "assets/Nodata.json",
                          width: 300.0,
                          height: 300.0,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "No Alarm Available",
                          style: GoogleFonts.aBeeZee(fontSize: 20),
                        )
                      ],
                    ),
                  )
            : ListView.builder(
                itemCount: alarmcontroller.locations.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    alarmcontroller.start();
                  }
                  LocationData location = alarmcontroller.locations[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(alarmcontroller.locations[index].name,
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * 0.70,
                                    child: Text(
                                        alarmcontroller
                                            .locations[index].address,
                                        maxLines: 1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                        textAlign: TextAlign.justify,
                                        style:
                                            GoogleFonts.roboto(fontSize: 14)),
                                  ),
                                  Obx(() => Text(
                                      "Distance: ${alarmcontroller.locations[index].distance.toStringAsFixed(2)} km",
                                      style: GoogleFonts.roboto(fontSize: 14))),
                                ],
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Obx(() => Switch(
                                    activeColor: Colors.redAccent,
                                    value: alarmcontroller
                                        .locations[index].status.value,
                                    onChanged: (value) {
                                      // setState(() {
                                      alarmcontroller.locations[index]
                                          .status(value);
                                      //  });
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: GestureDetector(
          onTap: () {
            Get.to(() => LocationPage());
          },
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.redAccent,
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
