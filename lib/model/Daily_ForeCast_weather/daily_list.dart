import 'package:weather/model/Daily_ForeCast_weather/sys2.dart';
import 'package:weather/model/util/clouds.dart';
import 'package:weather/model/util/main.dart';
import 'package:weather/model/util/rain.dart';
import 'package:weather/model/util/weather.dart';
import 'package:weather/model/util/wind.dart';

class DailyForeCastList {
  final String dtTxt;
  final Main main;
  final List<Weather> weather;
  final Clouds? clouds;
  final Wind? wind;
  final Rain? rain;
  final Sys2 sys;

  DailyForeCastList({
    required this.dtTxt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.rain,
    required this.sys,
  });

  factory DailyForeCastList.fromJson(Map<String, dynamic> json) {


    var weatherList = json['weather'] as List<dynamic>;
  var weatherData = weatherList.map((item) => Weather.fromJson(item)).toList();


    return DailyForeCastList(
      dtTxt: json["dt_txt"] as String, // this is utc
      main: Main.fromJson(json['main']),
      weather: weatherData,
      clouds:json['clouds']!=null? Clouds.fromJson(json['clouds']):null,
      wind:json['wind']!=null? Wind.fromJson(json['wind']):null,
      rain:json['rain']!=null? Rain.fromJson(json['rain'], false): null,
      sys: Sys2.fromJson(json['sys']),
    );
  }
}
