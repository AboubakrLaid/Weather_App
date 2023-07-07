import 'package:weather/model/Daily_ForeCast_weather/city.dart';
import 'package:weather/model/Daily_ForeCast_weather/daily_list.dart';

class DailyForeCastWeather {
  final String cod;
  final List<DailyForeCastList> list;
  final City city;

  DailyForeCastWeather({
    required this.cod,
    required this.list,
    required this.city,
  });

  factory DailyForeCastWeather.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['list'];
    final foreCastData = list.map<DailyForeCastList>((json) => DailyForeCastList.fromJson(json)).toList();
   

    
    return DailyForeCastWeather(
      cod: json['cod'] as String,
      list: foreCastData,
      city: City.fromJson(json['city']),
    );
  }
}
