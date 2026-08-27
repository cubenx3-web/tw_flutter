import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tw_flutter/ground/RoomA.dart';
// import 'package:tw_flutter/tank/tankBody.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanky WarFare',
      debugShowCheckedModeBanner: false,
      home: RoomA(),
    );
  }
}
