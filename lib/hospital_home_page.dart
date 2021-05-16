import 'package:bed_tracker/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HospitalHomeScreen extends StatefulWidget {
  static String id = 'hospitalHomeScreen';
  @override
  _HospitalHomeScreenState createState() => _HospitalHomeScreenState();
}

class _HospitalHomeScreenState extends State<HospitalHomeScreen> {
  var totalBeds;
  var normalBeds;
  var oxygenBeds;
  var hduBeds;
  var name;
  var number;
  bool showLoader = false;

  final _firebase = FirebaseFirestore.instance;
  final _hospitals = FirebaseFirestore.instance.collection('hospitals');
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        number = loggedInUser.phoneNumber;
      }
    } catch (e) {
      print(e);
    }
  }

  void getData() async {
    getCurrentUser();
    setState(() {
      showLoader = true;
    });
    String docId;
    print(number);
    try {
      docId = await _firebase
          .collection('hospitals')
          .where('mobileNumber', isEqualTo: number)
          .get()
          .then((value) => value.docs[0].id);
      name = await _hospitals
          .doc(docId)
          .get()
          .then((value) => value.data()['hospitalName'].toString());
      totalBeds = await _hospitals
          .doc(docId)
          .get()
          .then((value) => value.data()['totalBeds'].toString());
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
                    padding: EdgeInsets.only(top: 2.75.h),
                    child: Text(
                      '$name',
                      style: kButtonText.copyWith(
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.75.h),
                    child: Text(
                      '$number',
                      style: kButtonText.copyWith(
                        color: Color(0XFF414041),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.85.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 46.11.w,
                          height: 5.74.h,
                          decoration: BoxDecoration(
                            color: Color(0XFF0BA296),
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
                          ),
                          child: Center(
                            child: Text(
                              'Total Beds',
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
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
                                  int updatedCount = int.parse(totalBeds) - 1;
                                  setState(() {
                                    totalBeds = updatedCount.toString();
                                  });
                                },
                              ),
                              Container(
                                width: 14.07.w,
                                height: 3.67.h,
                                decoration: BoxDecoration(
                                  color: Color(0XFF9DD7D3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    totalBeds,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  int updatedCount = int.parse(totalBeds) + 1;
                                  setState(() {
                                    totalBeds = updatedCount.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.85.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 46.11.w,
                          height: 5.74.h,
                          decoration: BoxDecoration(
                            color: Color(0XFF0BA296),
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
                          ),
                          child: Center(
                            child: Text(
                              'Normal Beds',
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
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
                                  int updatedCount = int.parse(normalBeds) - 1;
                                  setState(() {
                                    normalBeds = updatedCount.toString();
                                  });
                                },
                              ),
                              Container(
                                width: 14.07.w,
                                height: 3.67.h,
                                decoration: BoxDecoration(
                                  color: Color(0XFF9DD7D3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    normalBeds,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  int updatedCount = int.parse(normalBeds) + 1;
                                  setState(() {
                                    normalBeds = updatedCount.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.85.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 46.11.w,
                          height: 5.74.h,
                          decoration: BoxDecoration(
                            color: Color(0XFF0BA296),
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
                          ),
                          child: Center(
                            child: Text(
                              'Oxygen Beds',
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
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
                                  int updatedCount = int.parse(oxygenBeds) - 1;
                                  setState(() {
                                    oxygenBeds = updatedCount.toString();
                                  });
                                },
                              ),
                              Container(
                                width: 14.07.w,
                                height: 3.67.h,
                                decoration: BoxDecoration(
                                  color: Color(0XFF9DD7D3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    oxygenBeds,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  int updatedCount = int.parse(oxygenBeds) + 1;
                                  setState(() {
                                    oxygenBeds = updatedCount.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.85.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 46.11.w,
                          height: 5.74.h,
                          decoration: BoxDecoration(
                            color: Color(0XFF0BA296),
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
                          ),
                          child: Center(
                            child: Text(
                              'HDU Beds',
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.0)),
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
                                  int updatedCount = int.parse(hduBeds) - 1;
                                  setState(() {
                                    hduBeds = updatedCount.toString();
                                  });
                                },
                              ),
                              Container(
                                width: 14.07.w,
                                height: 3.67.h,
                                decoration: BoxDecoration(
                                  color: Color(0XFF9DD7D3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    hduBeds,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  int updatedCount = int.parse(hduBeds) + 1;
                                  setState(() {
                                    hduBeds = updatedCount.toString();
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4.6.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 9.0.w,
                      right: 9.0.w,
                      top: 2.50.h,
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
                        setState(() {
                          showLoader = true;
                        });
                        String docId = await _hospitals
                            .where('mobileNumber', isEqualTo: number)
                            .get()
                            .then((value) => value.docs[0].id);
                        print(docId);
                        _hospitals.doc(docId).update({
                          'totalBeds': totalBeds,
                          'normalBeds': normalBeds,
                          'oxygenBeds': oxygenBeds,
                          'hduBeds': hduBeds,
                        });
                        setState(() {
                          showLoader = false;
                        });
                      },
                      child: Container(
                        height: 5.89.h,
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
                      top: 2.50.h,
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
                        Navigator.popAndPushNamed(context, LandingPage.id);
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
