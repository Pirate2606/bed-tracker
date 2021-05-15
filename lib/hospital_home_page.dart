import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HospitalHomeScreen extends StatefulWidget {
  static String id = 'hospitalHomeScreen';
  @override
  _HospitalHomeScreenState createState() => _HospitalHomeScreenState();
}

class _HospitalHomeScreenState extends State<HospitalHomeScreen> {
  bool showLoader = false;
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
      body: showLoader == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Color(0XFFF6FFFE),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.75.h),
                    child: Text(
                      'name',
                      style: kButtonText.copyWith(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.75.h),
                    child: Text(
                      'number',
                      style: kButtonText.copyWith(
                        color: Color(0XFF414041),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  BedCounter(
                    text: 'Total Beds',
                    count: '100',
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  BedCounter(
                    text: 'Normal Beds',
                    count: '100',
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  BedCounter(
                    text: 'Oxygen Beds',
                    count: '100',
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  BedCounter(
                    text: 'HDU Beds',
                    count: '100',
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 9.0.w,
                      right: 9.0.w,
                      top: 3.50.h,
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5.0),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0XFF4FC2B9)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xFF0BA296),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Container(
                        height: 6.89.h,
                        child: Center(
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: kButtonText.copyWith(
                              color: Color(0XFFF6FFFE),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 9.0.w,
                      right: 9.0.w,
                      top: 3.50.h,
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(5.0),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0XFF4FC2B9)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xFF0BA296),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: Container(
                        height: 4.89.h,
                        child: Center(
                          child: Text(
                            'Log Out',
                            textAlign: TextAlign.center,
                            style: kButtonText.copyWith(
                              color: Color(0XFFF6FFFE),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class BedCounter extends StatelessWidget {
  BedCounter({this.text, this.count});
  final String text;
  final String count;

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
                GestureDetector(
                  child: Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                  onTap: () {
                  },
                ),
                Container(
                  width: 14.07.w,
                  height: 3.67.h,
                  decoration: BoxDecoration(
                    color: Color(0XFF9DD7D3),
                    borderRadius: BorderRadius.all(Radius.circular(22.0)),
                  ),
                  child: Center(
                    child: Text(
                      count,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.add_rounded,
                  color: Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
