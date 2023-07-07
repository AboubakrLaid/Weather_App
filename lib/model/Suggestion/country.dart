class Country {
  final String id, name, localizedName;
 // id is DZ PS
  Country({
    required this.name,
    required this.localizedName,
    required this.id,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"] as String,
      localizedName: json["localizedName"] as String,
      id: json["id"] as String,
    );
  }
}
