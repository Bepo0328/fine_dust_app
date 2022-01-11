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
        onPressed: () {},
        child: const Icon(Icons.add),
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
            width: 250.0,
            height: 250.0,
            child: Image.asset(
              icon[_status],
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 60.0),
          Text(
            status[_status],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            '통합 환경 대기 지수 : ${data.first.khai}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
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
