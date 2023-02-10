import 'package:flutter/material.dart';

const kMessageTextStyle = TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300);

const kTempTextStyle = TextStyle(fontSize: 150.0);

const kButtonTextStyle = TextStyle(fontSize: 30.0, color: Colors.white);

const kConditionTextStyle = TextStyle(fontSize: 73);

const Widget kVerticalDivider = VerticalDivider(color: Colors.white, thickness: 1);

kErrorSnackBar(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        'Incorrect city name, please try again!',
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}
