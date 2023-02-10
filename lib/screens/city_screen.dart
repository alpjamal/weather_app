import 'dart:ui';

import 'package:flutter/material.dart';
import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/back.jpg'),
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    cursorColor: Colors.white,
                    cursorWidth: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter a city name',
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.5),
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                    ),
                    onChanged: (value) => cityName = value,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 70),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(cityName),
                    child: Text('Get Weather', style: kButtonTextStyle),
                  ),
                ),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
