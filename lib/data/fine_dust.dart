class FineDust {
  int? pm10;
  int? pm25;
  int? khai;
  String? dataTime;
  double? so;
  double? co;
  double? no;
  double? o3;

  FineDust({this.pm10, this.pm25, this.khai, this.dataTime, this.so, this.co, this.no, this.o3});

  factory FineDust.fromJson(Map<String, dynamic> data) {
    return FineDust(
      pm10: int.tryParse(data["pm10Value"] ?? "") ?? 0,
      pm25: int.tryParse(data["pm25Value"] ?? "") ?? 0,
      khai: int.tryParse(data["khaiValue"] ?? "") ?? 0,
      dataTime: data["dataTime"] ?? "",
      so: double.tryParse(data["so2Value"] ?? "") ?? 0.0,
      co: double.tryParse(data["coValue"] ?? "") ?? 0.0,
      no: double.tryParse(data["no2Value"] ?? "") ?? 0.0,
      o3: double.tryParse(data["o3Value"] ?? "") ?? 0.0,
    );
  }
}