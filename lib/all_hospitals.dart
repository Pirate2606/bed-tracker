import 'package:bed_tracker/hospital_info.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllHospitals extends StatefulWidget {
  static String id = 'allHospitals';
  final state;
  final district;
  AllHospitals({this.state, this.district});
  @override
  _AllHospitalsState createState() => _AllHospitalsState(state, district);
}

class _AllHospitalsState extends State<AllHospitals> {
  var state;
  var district;
  _AllHospitalsState(this.state, this.district);

  var snapshot;
  CollectionReference hospitals =
      FirebaseFirestore.instance.collection('hospitals');

  @override
  void initState() {
    testing();
    super.initState();
  }

  void testing() {
    snapshot = FirebaseFirestore.instance
        .collection('hospitals')
        .where('state', isEqualTo: state)
        .get()
        .then((value) => value);
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
              padding: EdgeInsets.only(top: 3.5.h),
              child: Text(
                'Available Hospitals',
                textAlign: TextAlign.center,
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
            StreamBuilder<QuerySnapshot>(
              stream: hospitals.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      print(district);
                      print(document.data()['district']);
                      return document.data()['district'] != district
                          ? SizedBox(
                              height: 1.0,
                            )
                          : ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HospitalInfo(
                                      name: document.data()['hospitalName'],
                                    ),
                                  ),
                                );
                              },
                              title: Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: Container(
                                  height: 15.09.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(22.0),
                                    color: Color(0XFF9DD7D3),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        document.data()['hospitalName'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        width: 65.5.w,
                                        height: 5.74.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius:
                                              BorderRadius.circular(22.0),
                                          color: Color(0XFF48CCC3),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Total Beds Available',
                                            ),
                                            Text(
                                              "${int.parse(document.data()['oxygenBeds']) + int.parse(document.data()['hduBeds']) + int.parse(document.data()['normalBeds'])}",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
