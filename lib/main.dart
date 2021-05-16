import 'package:bed_tracker/all_hospitals.dart';
import 'package:bed_tracker/hospital_info.dart';
import 'package:bed_tracker/login_page.dart';
import 'package:bed_tracker/register_hospital_beds.dart';
import 'hospital_home_page.dart';
import 'hospital_search_page.dart';
import 'loading_screen.dart';
import 'register_hospital_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget nextScreen = LoadingScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _firebase = FirebaseFirestore.instance;
  final _users = FirebaseFirestore.instance.collection('hospitals');

  void checkLogin() {
    var instance = FirebaseAuth.instance.authStateChanges();
    instance.listen((User user) async {
      if (user == null) {
        setState(() {
          nextScreen = LandingPage();
        });
      } else {
        String docId;
        String hospitalName;
        try {
          docId = await _firebase
              .collection('hospitals')
              .where('mobileNumber', isEqualTo: user.phoneNumber)
              .get()
              .then((value) => value.docs[0].id);
          hospitalName = await _users
              .doc(docId)
              .get()
              .then((value) => value.data()['hospitalName'].toString());
        } catch (e) {
          docId = 'null';
        }
        if (hospitalName != null) {
          setState(() {
            nextScreen = HospitalHomeScreen();
          });
        } else {
          setState(() {
            nextScreen = RegisterHospital();
          });
        }
      }
    });
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bed Tracker',
          initialRoute: LoadingScreen.id,
          routes: {
            LoadingScreen.id: (context) => nextScreen,
            LandingPage.id: (context) => LandingPage(),
            RegisterHospital.id: (context) => RegisterHospital(),
            RegisterHospitalBed.id: (context) => RegisterHospitalBed(),
            HospitalHomeScreen.id: (context) => HospitalHomeScreen(),
            SearchHospitals.id: (context) => SearchHospitals(),
            AllHospitals.id: (context) => AllHospitals(),
            HospitalInfo.id: (context) => HospitalInfo(),
            LoginScreen.id: (context) => LoginScreen(),
          },
        );
      },
    );
  }
}
