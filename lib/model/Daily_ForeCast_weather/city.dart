import 'package:weather/model/util/coord.dart';

class City {
  final String name;
  final Coord coord;
  final String country;
  final int sunrise, sunset, id;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json["name"] as String,
      coord: Coord.fromJson(json["coord"]),
      country: json["country"] as String,
      sunrise: json["sunrise"] as int,
      sunset: json["sunset"] as int,
      id: json["id"] as int,
    );
  }
}
