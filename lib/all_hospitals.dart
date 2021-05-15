import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:sizer/sizer.dart';

class AllHospitals extends StatefulWidget {
  static String id = 'allHospitals';
  @override
  _AllHospitalsState createState() => _AllHospitalsState();
}

class _AllHospitalsState extends State<AllHospitals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Bed Tracker',
            style: TextStyle(
              color: Color(0XFF4FC2B9),
            ),
          ),
        ),
        backgroundColor: Color(0XFF323131),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color(0XFFF6FFFE),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 3.5.h),
              child: Text(
                'Available Hospitals',
                style: TextStyle(
                  fontSize: 42.0,
                  color: Color(0XFF414041),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                color: Colors.black,
                thickness: 3.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
