class Rain {
  final num h1, h3;
  Rain({this.h1 = 0.0, this.h3 = 0.0});

  Map<String, dynamic> toJson(bool isOneH) => isOneH ? {"1h": h1} : {"3h": h3};

  factory Rain.fromJson(Map<String, dynamic> json, bool isOneH) => isOneH
        ? Rain(h1: json["1h"] as num)
        : Rain(h3: json["3h"] as num);
}
