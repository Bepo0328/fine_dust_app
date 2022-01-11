import 'package:fine_dust_app/data/api.dart';
import 'package:fine_dust_app/data/fine_dust.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fine Dust App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = const [
    Color(0xFF32A1FF),
    Color(0xFF00C73C),
    Color(0xFFFD9B5A),
    Color(0xFFFF5959),
  ];
  List<String> icon = const [
    'assets/img/happy.png',
    'assets/img/sad.png',
    'assets/img/bad.png',
    'assets/img/angry.png',
  ];
  List<String> status = const [
    '좋음',
    '보통',
    '나쁨',
    '매우나쁨',
  ];
  String stationName = "종로구";
  List<FineDust> data = [];

  int getStatus(FineDust findDust) {
    if (findDust.pm10! > 150) {
      return 3;
    } else if (findDust.pm10! >= 80) {
      return 2;
    } else if (findDust.pm10! >= 30) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    getFineDustData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? location = await Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => const LocationPage()));
          if (location != null) {
            stationName = location;
            getFineDustData();
          }
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.location_on),
      ),
    );
  }

  Widget getPage() {
    if (data.isEmpty) {
      return Container();
    }

    int _status = getStatus(data.first);

    return Container(
      color: colors[_status],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 60.0),
          const Text(
            '현재 위치',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            '[$stationName]',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 60.0),
          Container(
            width: 220.0,
            height: 220.0,
            child: Image.asset(
              icon[_status],
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40.0),
          Text(
            status[_status],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            '통합 환경 대기 지수 : ${data.first.khai}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(data.length, (idx) {
                  FineDust fineDust = data[idx];
                  int _status = getStatus(fineDust);

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          fineDust.dataTime!.replaceAll(' ', '\n'),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          height: 40.0,
                          width: 40.0,
                          child:
                              Image.asset(icon[_status], fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          '${fineDust.pm10}ug/m2',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getFineDustData() async {
    FineDustApi api = FineDustApi();
    data = await api.getFineDustData(stationName);
    data.removeWhere((element) => element.pm10 == 0);
    setState(() {});
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List<String> locations = [
    "강남구",
    "강동구",
    "강북구",
    "강서구",
    "관악구",
    "광진구",
    "구로구",
    "금천구",
    "노원구",
    "도봉구",
    "동대문구",
    "동작구",
    "마포구",
    "서대문구",
    "서초구",
    "성동구",
    "성북구",
    "송파구",
    "양천구",
    "영등포구",
    "용산구",
    "은평구",
    "종로구",
    "중구",
    "중랑구",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: List.generate(locations.length, (idx) {
          return ListTile(
            onTap: () {
              Navigator.pop(context, locations[idx]);
            },
            title: Text(locations[idx]),
            trailing: const Icon(Icons.arrow_forward),
          );
        }),
      ),
    );
  }
}
