// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:weather/util/export.dart';
import 'package:weather/view_models/weather_data.dart';

class FetchWeather extends ChangeNotifier {
  bool noError = true;
  String info = "Retrive your location";

  wait() async => await Future.delayed(const Duration(seconds: 3));

Future  fetchAllWeatherInfo(BuildContext context, {String? anotherLocation}) async {
      final state = Provider.of<WeatherData>(context, listen: false);

      state.favoriteLocation = (await localDB.getFavoriteLocation())!;
      state.otherLocations = await localDB.getLocations() ?? [];
    
    String? currentLocation =
        anotherLocation ?? state.favoriteLocation;

    await wait();
    if (noError) {
      info = "Retrive today weather status";
      notifyListeners();


      state.currentLocation = currentLocation;
      noError = await state.fetchCurrentWeatherData();

      if (noError) {
        if (appLanguage.isArabic) {
        state.favoriteLocation = state.currentWeatherData!.name;
        state.currentLocation = state.favoriteLocation;
          
        }
        info = "Retrive this weak weather status";
        notifyListeners();

        noError = await state.fetchDailyForeCastWeatherData();
        if (noError) {
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            context.pushReplacementNamed("Home");
          });
        } else {
          info = "Something went wrong";
          notifyListeners();
        }
      } else {
        info = "Something went wrong";
        notifyListeners();
      }
    } else {
      info = "Something went wrong";
      notifyListeners();
    }
  }
  

  

}
