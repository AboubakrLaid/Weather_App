class Sys1 {
  final String country;
  final int sunrise, sunset;

  Sys1({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "sunrise": sunrise,
      'sunset': sunset,
    };
  }

  factory Sys1.fromJson(Map<String, dynamic> json) {
    return Sys1(
      country: json['country'] as String,
      sunrise: json['sunrise'] as int,
      sunset: json['sunset'] as int,
    );
  }
}
