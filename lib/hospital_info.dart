import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalInfo extends StatefulWidget {
  static String id = 'hospitalInfo';
  final name;
  HospitalInfo({this.name});
  @override
  _HospitalInfoState createState() => _HospitalInfoState(name);
}

class _HospitalInfoState extends State<HospitalInfo> {
  var name;
  _HospitalInfoState(this.name);

  var totalBeds;
  var normalBeds;
  var oxygenBeds;
  var hduBeds;
  var number;
  bool showLoader = false;

  final _firebase = FirebaseFirestore.instance;
  final _hospitals = FirebaseFirestore.instance.collection('hospitals');

  void getData() async {
    setState(() {
      showLoader = true;
    });
    String docId;
    print(number);
    try {
      docId = await _firebase
          .collection('hospitals')
          .where('hospitalName', isEqualTo: name)
          .get()
          .then((value) => value.docs[0].id);
      number = await _hospitals
          .doc(docId)
          .get()
          .then((value) => value.data()['mobileNumber'].toString());
      normalBeds = await _hospitals
          .doc(docId)
          .get()
          .then((value) => value.data()['normalBeds'].toString());
      oxygenBeds = await _hospitals
          .doc(docId)
          .get()
          .then((value) => value.data()['oxygenBeds'].toString());
      hduBeds = await _hospitals
          .doc(docId)
          .get()
          .then((value) => value.data()['hduBeds'].toString());
      setState(() {
        showLoader = false;
      });
    } catch (e) {
      print(e);
      docId = 'null';
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
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
                    padding: EdgeInsets.only(top: 60.0),
                    child: Text(
                      '$name',
                      textAlign: TextAlign.center,
                      style: kButtonText.copyWith(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '+91-${number.replaceFirst('+91', '')}',
                      style: kButtonText.copyWith(
                        color: Color(0XFF414041),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  BedCounter(
                    text: 'Normal Beds',
                    count: normalBeds,
                    color: Color(0XFF9DD7D3),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  BedCounter(
                    text: 'HDU Beds',
                    count: hduBeds,
                    color: Color(0XFF9DD7D3),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  BedCounter(
                    text: 'Oxygen Beds',
                    count: oxygenBeds,
                    color: Color(0XFF9DD7D3),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  BedCounter(
                    text: 'Total Beds',
                    count:
                        '${int.parse(normalBeds) + int.parse(oxygenBeds) + int.parse(hduBeds)}',
                    color: Colors.green[50],
                  ),
                ],
              ),
            ),
    );
  }
}

class BedCounter extends StatelessWidget {
  BedCounter({this.text, this.count, this.totalCount, this.color});
  final String text;
  final String count;
  final int totalCount;
  final color;

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
                  width: 20.07.w,
                  height: 3.67.h,
                  decoration: BoxDecoration(
                    color: color,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
