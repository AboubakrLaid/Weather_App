class Sys2 {
  final String pod; // part of the day d or n : day or night
  Sys2(this.pod);

  factory Sys2.fromJson(Map<String, dynamic> json) => Sys2(json["pod"] as String);
}