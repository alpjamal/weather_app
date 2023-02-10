import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/screens/error_screen.dart';

import './screens/location_screen.dart';
import './services/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Josefin Sans', colorScheme: ColorScheme.dark()),
      home: InitialScreen(),
    );
  }
}

class InitialScreen extends StatefulWidget {
  InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  Future _refreshHandler() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WeatherModel().getLocationData(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: SpinKitFadingCircle(color: Colors.white)));
        }
        return RefreshIndicator(
          color: Colors.white,
          onRefresh: _refreshHandler,
          child: snapshot.data == null ? ErrorScreen(snapshot.error) : LocationScreen(snapshot.data, _refreshHandler),
        );
      },
    );
  }
}
