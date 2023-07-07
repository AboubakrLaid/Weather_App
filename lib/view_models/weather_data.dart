import 'package:flutter/material.dart';
import 'package:weather/model/Current_Weather/current_weather.dart';
import 'package:weather/model/Daily_ForeCast_weather/daily_forecast_weather.dart';
import 'package:weather/model/Daily_ForeCast_weather/daily_list.dart';
import 'package:weather/model/Hourly_ForeCast_Weather/hourly_forecast_weather.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/util/globale_variables.dart';

class WeatherData extends ChangeNotifier {
  TextEditingController locationController = TextEditingController();
  String favoriteLocation = ""; // favorite location
  String currentLocation = ""; // that is displayed in the home page
  String countryIsoCode = '';

  List<String> otherLocations = [];

  CurrentWeather? currentWeatherData;
  DailyForeCastWeather? dailyCastWeatherData;
  HourlyForeCastWeather? hourlyCastWeatherData;

  List<List<DailyForeCastList>> weekDaysWeather = [[], [], [], [], [], []];

  // to know when to display circular progress indicator
  bool manualGettingLocation = false;
  bool autoGettingLocation = false;
  // whether to diplay continue button or not
  bool showContinue = false;

  gettingLocManually() {
    manualGettingLocation = !manualGettingLocation;
    notifyListeners();
  }

  gettingLocAuto() {
    autoGettingLocation = !autoGettingLocation;
    notifyListeners();
  }

  hideContinue() {
    showContinue = false;
    notifyListeners();
  }

  setData(String loc, String country,
      {CurrentWeather? currentWeatherData,
      DailyForeCastWeather? foreDailyCastWeatherData}) {
    favoriteLocation = loc;
    currentLocation = loc;

    countryIsoCode = country.isNotEmpty ? ", $country" : "";
    this.currentWeatherData = currentWeatherData;
    dailyCastWeatherData = foreDailyCastWeatherData;
    showContinue = true;
    notifyListeners();
  }

  Future<bool> fetchCurrentWeatherData({String? otherLocation}) async {
    WeatherServices weatherService = WeatherServices();
    currentWeatherData = await weatherService.getCurrentWeatherData(
      otherLocation ?? favoriteLocation,
      appLanguage.currentLocale.languageCode,
    );

    notifyListeners();

    return currentWeatherData != null;
  }

  Future<bool> fetchDailyForeCastWeatherData({String? otherLocation}) async {
    WeatherServices weatherService = WeatherServices();
    dailyCastWeatherData = await weatherService
        .getDailyForeCastWeatherData(otherLocation ?? favoriteLocation, appLanguage.currentLocale.languageCode,);
    bool isValid = dailyCastWeatherData != null;
    weekDaysWeather = [[], [], [], [], [], []];
    if (isValid) {
      int j = 0;
      for (var i = 0; i < dailyCastWeatherData!.list.length; i++) {
        final element = dailyCastWeatherData!.list[i];
        if (weekDaysWeather[0].isEmpty) {
          weekDaysWeather[0].add(element);
        } else {
          int x = DateTime.parse(element.dtTxt).weekday;
          int y = DateTime.parse(weekDaysWeather[j][0].dtTxt).weekday;
          if (x == y) {
            weekDaysWeather[j].add(element);
          } else {
            j++;
            weekDaysWeather[j].add(element);
          }
        }
      }

      notifyListeners();
    }

    return isValid;
  }
}
