import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:sizer/sizer.dart';

class HospitalInfo extends StatefulWidget {
  static String id = 'hospitalInfo';
  @override
  _HospitalInfoState createState() => _HospitalInfoState();
}

class _HospitalInfoState extends State<HospitalInfo> {
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
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hospital Name',
                style: kButtonText.copyWith(
                  fontSize: 40.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '+91-1234569875',
                style: kButtonText.copyWith(
                  color: Color(0XFF414041),
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            BedCounter(
              text: 'Total Beds',
              count: 45,
              totalCount: 100,
            ),
            SizedBox(
              height: 32.0,
            ),
            BedCounter(
              text: 'Normal Beds',
              count: 45,
              totalCount: 100,
            ),
            SizedBox(
              height: 32.0,
            ),
            BedCounter(
              text: 'Oxygen Beds',
              count: 45,
              totalCount: 100,
            ),
            SizedBox(
              height: 32.0,
            ),
            BedCounter(
              text: 'HDU Beds',
              count: 45,
              totalCount: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class BedCounter extends StatelessWidget {
  BedCounter({this.text, this.count, this.totalCount});
  final String text;
  final int count;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.85.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 46.11.w,
            height: 5.74.h,
            decoration: BoxDecoration(
              color: Color(0XFF0BA296),
              borderRadius: BorderRadius.all(Radius.circular(22.0)),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            width: 32.7.w,
            height: 5.74.h,
            decoration: BoxDecoration(
              color: Color(0XFF4FC2B9),
              borderRadius: BorderRadius.all(Radius.circular(22.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10.07.w,
                  height: 3.67.h,
                  decoration: BoxDecoration(
                    color: Color(0XFF9DD7D3),
                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  ),
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    '/',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  width: 10.07.w,
                  height: 3.67.h,
                  decoration: BoxDecoration(
                    color: Color(0XFF9DD7D3),
                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  ),
                  child: Center(
                    child: Text(
                      totalCount.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
