class Weather {
  final int id;
  final String main, description, icon;

  Weather({
    required this.main,
    required this.description,
    required this.icon,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "main": main,
      "description": description,
      "icon": icon,
    };
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: json["main"] as String,
      description: json["description"] as String,
      icon: json["icon"] as String,
      id: json["id"] as int,
    );
  }
}
