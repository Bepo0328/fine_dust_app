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
    'assets/img/angry.png',
    'assets/img/bad.png',
    'assets/img/happy.png',
    'assets/img/sad.png',
  ];
  List<String> status = const [
    '좋음',
    '보통',
    '나쁨',
    '매우나쁨',
  ];
  String stationName = "종로구";
  List<FineDust> data = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FineDustApi api = FineDustApi();
          data = await api.getFineDustData("종로구");
          data.removeWhere((element) =>  element.pm10 == 0);
          for (final d in data) {
            print("${d.dataTime} ${d.pm10}");
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
