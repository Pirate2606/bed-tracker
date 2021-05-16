import 'dart:convert';
import 'package:bed_tracker/register_hospital_beds.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_hospital_beds.dart';

class RegisterHospital extends StatefulWidget {
  static String id = 'registerHospital';
  @override
  _RegisterHospitalState createState() => _RegisterHospitalState();
}

class _RegisterHospitalState extends State<RegisterHospital> {
  final hospitalName = TextEditingController();
  String state;
  String district;
  var mobileNumber;

  void getMobileNumber() {
    var instance = FirebaseAuth.instance.authStateChanges();
    instance.listen((User user) {
      if (user != null) {
        setState(() {
          mobileNumber = user.phoneNumber;
        });
      }
    });
  }

  String stateDropdownValue = 'State';
  String districtDropdownValue = 'District';
  var data;
  int index = -1;
  List dist = ['District'];
  List states = [
    'State',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telengana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  @override
  void initState() {
    getMobileNumber();
    super.initState();
  }

  void readJson() async {
    String jsonFile = await DefaultAssetBundle.of(context)
        .loadString("assets/districts.json");
    data = json.decode(jsonFile);
    setState(() {
      if (index == -1) {
        dist = ['District'];
      } else {
        dist = ['District'];
        dist = dist + data['states'][index]['districts'];
      }
    });
  }

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
                  'Register Hospital',
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
                  text: 'Hospital Name',
                  controller: hospitalName,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 9.0.w,
                  right: 9.0.w,
                  top: 3.50.h,
                ),
                child: Container(
                  width: 84.95.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    border: Border.all(),
                  ),
                  child: Center(
                    child: DropdownButton(
                      value: stateDropdownValue,
                      icon: Icon(Icons.arrow_drop_down_outlined),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          stateDropdownValue = newValue;
                          index = states.indexOf(newValue) - 1;
                          state = newValue;
                        });
                      },
                      items: states.map<DropdownMenuItem<String>>((var value) {
                        readJson();
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        );
                      }).toList(),
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
                child: Container(
                  width: 84.95.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    border: Border.all(),
                  ),
                  child: Center(
                    child: DropdownButton(
                      value: districtDropdownValue,
                      icon: Icon(Icons.arrow_drop_down_outlined),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String newValue) {
                        setState(() {
                          districtDropdownValue = newValue;
                          district = newValue;
                        });
                      },
                      items: dist.map<DropdownMenuItem<String>>((var value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        );
                      }).toList(),
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
                          color: Color(0xFF707070),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterHospitalBed(
                                name: hospitalName.text,
                                state: state,
                                district: district,
                                number: mobileNumber,
                              )),
                    );
                  },
                  child: Container(
                    height: 6.89.h,
                    child: Center(
                      child: Text(
                        'Continue',
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
