class Main {
  final num temp, feelsLike, tempMin, tempMax,pressure, humidity;
  

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  Map<String, dynamic> toJson() {
    return {
      "temp": temp,
      "feels_like": feelsLike,
      "temp_min": tempMin,
      "temp_max": tempMax,
      "pressure": pressure,
      "humidity": humidity,
    };
  }

  factory Main.fromJson(Map<String, dynamic> json) {
    // print("${json['temp']} ${json['feels_like']} ${json['pressure']}   ${json['temp'].runtimeType} ");
    return Main(
      temp: json['temp'],
      feelsLike: json['feels_like'] ,
      tempMin: json['temp_min'] ,
      tempMax: json['temp_max'] ,
      pressure: json['pressure'] ,
      humidity: json['humidity'] ,
    );
  }
}
// }"temp": 298.48,
//                                         "feels_like": 298.74,
//                                         "temp_min": 297.56,
//                                         "temp_max": 300.05,
//                                         "pressure": 1015,
//                                         "humidity": 64,