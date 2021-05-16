import 'dart:convert';
import 'package:bed_tracker/all_hospitals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';

class SearchHospitals extends StatefulWidget {
  static String id = 'searchHospitals';
  @override
  _SearchHospitalsState createState() => _SearchHospitalsState();
}

class _SearchHospitalsState extends State<SearchHospitals> {
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
            Padding(
              padding: EdgeInsets.only(top: 8.11.h),
              child: DropdownButton(
                value: stateDropdownValue,
                icon: Icon(Icons.arrow_drop_down_outlined),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Color(0XFF4FC2B9),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    stateDropdownValue = newValue;
                    index = states.indexOf(newValue) - 1;
                  });
                },
                items: states.map<DropdownMenuItem<String>>((var value) {
                  readJson();
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Color(0XFF707070),
                        fontSize: 24.0,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: DropdownButton(
                value: districtDropdownValue,
                icon: Icon(Icons.arrow_drop_down_outlined),
                iconSize: 24,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Color(0XFF4FC2B9),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    districtDropdownValue = newValue;
                  });
                },
                items: dist.map<DropdownMenuItem<String>>((var value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: Color(0XFF707070),
                        fontSize: 24.0,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 9.0.w,
                right: 9.0.w,
                top: 10.11.h,
              ),
              child: TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5.0),
                  backgroundColor: MaterialStateProperty.all(Color(0XFF4FC2B9)),
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
                    MaterialPageRoute(
                      builder: (context) => AllHospitals(
                        state: stateDropdownValue,
                        district: districtDropdownValue,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 6.89.h,
                  child: Center(
                    child: Text(
                      'Search',
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
