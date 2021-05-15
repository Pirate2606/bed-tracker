import 'package:bed_tracker/hospital_home_page.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:sizer/sizer.dart';

import 'hospital_home_page.dart';

class RegisterHospitalBed extends StatefulWidget {
  @override
  _RegisterHospitalBedState createState() =>
      _RegisterHospitalBedState();
}

class _RegisterHospitalBedState extends State<RegisterHospitalBed> {
  final totalBeds = TextEditingController();
  final normalBeds = TextEditingController();
  final oxygenBeds = TextEditingController();
  final hduBeds = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color(0XFFF6FFFE),
          ),
          child: Column(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 27.18.w,
                    right: 27.18.w,
                    top: 5.17.h,
                  ),
                  child: Image(
                      height: 19.5.h,
                      width: 45.63.w,
                      image: AssetImage('images/logo_small.png')),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.75.h),
                child: Text(
                  'name',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Color(0XFF0BA296),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: LoginTextField(
                  text: 'Total Beds',
                  controller: totalBeds,
                  keyboardType: TextInputType.number,
                ),
              ),
              LoginTextField(
                text: 'Normal Beds',
                controller: normalBeds,
                keyboardType: TextInputType.number,
              ),
              LoginTextField(
                text: 'Oxygen Beds',
                controller: oxygenBeds,
                keyboardType: TextInputType.number,
              ),
              LoginTextField(
                text: 'HDU Beds',
                controller: hduBeds,
                keyboardType: TextInputType.number,
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
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute
                      (builder: (context) => HospitalHomeScreen())
                    );
                  },
                  child: Container(
                    height: 6.89.h,
                    child: Center(
                      child: Text(
                        'Register',
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
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField({this.controller, this.text, this.keyboardType});

  final text;
  final TextEditingController controller;
  final keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 9.0.w,
        right: 9.0.w,
        top: 3.50.h,
      ),
      child: TextField(
        keyboardType: keyboardType,
        showCursor: false,
        textAlign: TextAlign.center,
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: kTextFieldDecoration.copyWith(
          hintText: text,
        ),
      ),
    );
  }
}
