import 'package:weather/model/Hourly_ForeCast_Weather/hourly_list.dart';

class HourlyForeCastWeather {
  final List<HourlyForeCastList> hourly;

  HourlyForeCastWeather({required this.hourly});

  factory HourlyForeCastWeather.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['hourly'];
    final hourlyForeCastData =
        list.map((json) => HourlyForeCastList.fromJson(json)).toList();

    return HourlyForeCastWeather(
      hourly: hourlyForeCastData,
    );
  }
}
