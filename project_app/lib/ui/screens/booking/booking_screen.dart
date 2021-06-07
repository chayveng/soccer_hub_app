import 'package:flutter/material.dart';
import 'package:project_app/constants.dart';

import 'body.dart';

class BookingScreen extends StatelessWidget {
  static String routeName = '/booking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyPrimaryColor,
      appBar: AppBar(
        title: Text(
          'Booking Screen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: navyPrimaryColor,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
