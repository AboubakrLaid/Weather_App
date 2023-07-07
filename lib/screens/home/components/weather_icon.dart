import 'package:flutter/material.dart';
import 'package:weather/util/export.dart';
import 'package:weather/view_models/weather_data.dart';
import 'package:weather_icons/weather_icons.dart';

IconData? weatherIcon(BuildContext context, int id, {String? pod }) {
  final state = Provider.of<WeatherData>(context, listen: false);

  bool isDay =pod==null ? DateTime.now().isBefore(DateTime.fromMillisecondsSinceEpoch(
      state.currentWeatherData!.sys.sunset * 1000)) : (pod == "d" );

  switch (id) {
    case 800:
      return isDay ? WeatherIcons.day_sunny : WeatherIcons.night_clear;

    case 801:
      return isDay ? WeatherIcons.day_cloudy : WeatherIcons.night_cloudy;

    case 802:
      return WeatherIcons.cloud;

    case 803 || 804:
      return WeatherIcons.cloudy;

    case >= 200 && <= 232:
      return WeatherIcons.thunderstorm;

    case >= 300 && <= 321:
      return WeatherIcons.rain_mix;

    case != 511 && >= 500 && <= 531:
      return WeatherIcons.rain;

    case 511 || >= 600 && <= 622:
      return WeatherIcons.snowflake_cold;

    default:
      return WeatherIcons.windy;
  }
}
