import 'package:geolocator/geolocator.dart';

double distanceCalculate(
    double mylat, double mylng, double targetlat, double targetlng) {
  //print("$mylat, $mylng,\n $targetlat $targetlng");
  //print(
  //   "distance${Geolocator.distanceBetween(mylat, mylng, targetlat, targetlng) / 1000}");
  return Geolocator.distanceBetween(mylat, mylng, targetlat, targetlng) / 1000;
}
