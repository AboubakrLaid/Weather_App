// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/util/export.dart';

import '../view_models/weather_data.dart';

class LocationService {
  static showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  // check if the user is enabling service location or not
  static Future<bool> checkLocationServices(BuildContext context) async {
    bool serviceEnabled = false;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(
        context,
        "enable your location services",
      );
    }
    return serviceEnabled;
  }

  static Future<bool> askForLocationPermission(BuildContext context) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    // await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      }
      showSnackBar(
        context,
        "give the permission to get your location",
      );
      return false;
    }
    return true;
  }

  static Future<bool> getCurrentLocation(BuildContext context) async {
    final position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    final location = placemarks[0].administrativeArea;
    final x = WeatherServices();

    if (location != null) {
      final currentWeatherData = await x.getCurrentWeatherData(location, appLanguage.currentLocale.languageCode);
      final foreCastWeatherData = await x.getDailyForeCastWeatherData(location, appLanguage.currentLocale.languageCode,);

      if (currentWeatherData != null && foreCastWeatherData != null) {
        final country = currentWeatherData.sys.country;
        Provider.of<WeatherData>(context, listen: false).setData(
          currentWeatherData.name,
          country,
          currentWeatherData: currentWeatherData,
          foreDailyCastWeatherData: foreCastWeatherData,
        );
        return true;
      } else {
        Provider.of<WeatherData>(context, listen: false)
          ..setData("", "")
          ..hideContinue();
        return false;
      }
    }
    return false;
  }
}
