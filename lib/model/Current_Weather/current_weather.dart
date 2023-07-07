import 'package:weather/model/Current_Weather/sys1.dart';
import 'package:weather/model/util/clouds.dart';
import 'package:weather/model/util/coord.dart';
import 'package:weather/model/util/main.dart';
import 'package:weather/model/util/rain.dart';
import 'package:weather/model/util/weather.dart';
import 'package:weather/model/util/wind.dart';

class CurrentWeather {
  final Coord coord; //
  final List<Weather>? weather; //
  final String basee; //
  final Main main; //
  final int visibilty;//
  final Wind? wind; //
  final Rain? rain;
  final Clouds? clouds; //
  final int dt; // time of data calculation
  final Sys1 sys;
  final int timeZone;
  final String name;
  final int cod;

  CurrentWeather({
    required this.coord,
    required this.weather,
    required this.basee,
    required this.main,
    required this.visibilty,
    required this.wind,
    required this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timeZone,
    required this.name,
    required this.cod,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final weatherList = json['weather'] as List<dynamic>;
    final weatherData =
        weatherList.map((item) => Weather.fromJson(item)).toList();
    return CurrentWeather(
      coord: Coord.fromJson(json["coord"]),
      weather: weatherData,
      basee: json["base"] as String,
      main: Main.fromJson(json["main"]),
      visibilty: json["visibility"] as int,
      wind: json["wind"] != null ? Wind.fromJson(json["wind"]) : null,
      rain: json["rain"] != null ? Rain.fromJson(json["rain"], true) : null,
      clouds: json["clouds"] != null ? Clouds.fromJson(json["clouds"]) : null,
      dt: json["dt"] as int,
      sys: Sys1.fromJson(json["sys"]),
      timeZone: json["timezone"] as int,
      name: json["name"] as String,
      cod: json["cod"] as int,
    );
  }
}
