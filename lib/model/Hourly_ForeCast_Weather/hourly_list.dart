

class HourlyForeCastList {
  final int dt;
  final num feelsLike;
  final int humidity;
  

  HourlyForeCastList({
    required this.dt,
    required this.feelsLike,
    required this.humidity,
   
  });

  factory HourlyForeCastList.fromJson(Map<String, dynamic> json) {
    return HourlyForeCastList(
      dt: json["dt"] as int, // this is utc
    feelsLike: json["feels_like"] as num,
    humidity: json["humidity"] as int,
    );
  }
}