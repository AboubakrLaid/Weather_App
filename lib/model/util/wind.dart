class Wind {
  final num? speed, gust,deg;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  Map<String, dynamic> toJson() {
    return {
      "spped": speed,
      "gust": gust,
      "deg": deg,
    };
  }

  factory Wind.fromJson(Map<String, dynamic> json) {
   
    return Wind(
      speed:json['speed'] as num? ,
      gust: json['gust'] as num? ,
      deg:json['deg'] as num?,
    );
  }
}
