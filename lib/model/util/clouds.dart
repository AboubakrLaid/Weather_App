class Clouds {
  final int all;
  Clouds(this.all);

  Map<String, dynamic> toJson() => {"all": all};

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(json['all'] as int);
}
