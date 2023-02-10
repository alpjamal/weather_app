import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final dynamic snapshotError;
  ErrorScreen(this.snapshotError, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 300),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$snapshotError', style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
              SizedBox(height: 20, width: double.infinity),
              Text('Oops, an error has occured!'),
            ],
          ),
        ],
      ),
    );
  }
}
