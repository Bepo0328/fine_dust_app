import 'package:fine_dust_app/data/fine_dust.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FineDustApi {
  final BASE_URL = "http://apis.data.go.kr";

  final String key = "your api key";

  Future<List<FineDust>> getFineDustData(String stationName) async {
    Uri url = Uri.parse("$BASE_URL/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?"
        "serviceKey=$key&"
        "returnType=json&"
        "numOfRows=100&"
        "pageNo=1&"
        "stationName=${Uri.encodeQueryComponent(stationName)}&"
        "dataTerm=DAILY&"
        "ver=1.0");

    final response = await http.get(url);

    print(utf8.decode(response.bodyBytes));


    List<FineDust> data = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      var res = json.decode(body) as Map<String, dynamic>;

      for (final _res in res["response"]["body"]["items"]) {
        final fineDust = FineDust.fromJson(_res as Map<String, dynamic>);
        data.add(fineDust);
      }

      return data;
    } else {
      return [];
    }
  }

}