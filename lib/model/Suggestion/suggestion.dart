
class Suggestion {
  final String name;
  // final String? localizedName;
  // final Country country;

  Suggestion({
    required this.name,
    // required this.localizedName,
    // required this.country,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      name: json["display_name"] as String,
      // localizedName: json["localizedName"] as String?,
      // country: Country.fromJson(json["country"]),
    );
  }
}
