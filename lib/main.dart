import 'package:bed_tracker/login_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'landing_page.dart';
import 'loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';


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
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bed Tracker',
          initialRoute: LandingPage.id,
          routes: {
            LoadingScreen.id: (context) => LoadingScreen(),
            LandingPage.id: (context) => LandingPage(),
            LoginScreen.id: (context) => LoginScreen(),
          },
        );
      },
    );
  }
}
