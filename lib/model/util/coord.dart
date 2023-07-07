class Coord {
  final num lon;
  final num lat;

  Coord({required this.lon, required this.lat});

  Map<String, dynamic> toJson() {
    return {"lon": lon, "lat": lat};
  }

  factory Coord.fromJson(Map<String, dynamic> json) {
 
    return Coord(
      lon: json["lon"] as num,
      lat: json["lat"] as num,
    );
  }

  
}
