import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/city_screen.dart';
import '../utilities/constants.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  final Map locationWeather;
  final Function() refresh;
  LocationScreen(this.locationWeather, this.refresh, {super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String? cityName;
  int? temperature;
  String? weatherIcon;
  int? humidity;
  int? visibility;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  updateUI(weatherData) {
    setState(() {
      cityName = weatherData['name'];
      // double temp = weatherData['main']['temp'];
      temperature = weatherData['main']['temp'].toInt();
      weatherIcon = weather.getWeatherIcon(weatherData['weather'][0]['id']);
      humidity = weatherData['main']['humidity'];
      visibility = (weatherData['visibility'] / 1000).round();
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SafeArea(
            child: isloading
                ? Center(child: SpinKitFadingCircle(color: Colors.white))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cityName!, textAlign: TextAlign.right, style: kMessageTextStyle),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Spacer(),
                          Text('$temperature°', style: kTempTextStyle),
                          Text(weatherIcon!, style: kConditionTextStyle),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: widget.refresh,
                            icon: Icon(FontAwesomeIcons.arrowRotateRight, size: 40, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () async {
                              var typedName = await Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) => CityScreen()));
                              if (typedName != null) {
                                setState(() => isloading = true);
                                var data = await weather.getCityWeather(typedName);
                                if (data == null) {
                                  if (mounted) {}
                                  kErrorSnackBar(context);
                                  setState(() => isloading = false);
                                } else {
                                  updateUI(data);
                                }
                              }
                            },
                            icon: Icon(FontAwesomeIcons.locationDot, size: 40, color: Colors.white),
                          ),
                        ],
                      ),
                      InfoRow(humidity: humidity, visibility: visibility),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  InfoRow({super.key, required this.humidity, required this.visibility});

  final int? humidity;
  final int? visibility;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InfoColumn(name: 'Humidity', value: '$humidity%'),
          kVerticalDivider,
          InfoColumn(name: 'Visibility', value: '$visibility km'),
        ],
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  InfoColumn({required this.name, required this.value, super.key});
  final String? name;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(value!, style: TextStyle(fontSize: 20)),
        Text(name!),
      ],
    );
  }
}
