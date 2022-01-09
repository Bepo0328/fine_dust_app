class FineDust {
  int? pm10;
  int? pm25;
  int? khai;
  String? dateTime;
  double? so;
  double? co;
  double? no;
  double? o3;

  FineDust({this.pm10, this.pm25, this.khai, this.dateTime, this.so, this.co, this.no, this.o3});

  factory FineDust.fromJson(Map<String, dynamic> data) {
    return FineDust(
      pm10: int.tryParse(data["pm10Value"] ?? "") ?? 0,
      pm25: int.tryParse(data["pm25Value"] ?? "") ?? 0,
      khai: int.tryParse(data["khaiValue"] ?? "") ?? 0,
      dateTime: data["dataTime"] ?? "",
      so: data["so2Value"] ?? "",
      co: data["coValue"] ?? "",
      no: data["no2Value"] ?? "",
      o3: data["o3Value"] ?? "",
    );
  }
}