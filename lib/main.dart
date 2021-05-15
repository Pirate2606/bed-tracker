import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'landing_page.dart';
import 'loading_screen.dart';


void main() async {
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
          initialRoute: LoadingScreen.id,
          routes: {
            LoadingScreen.id: (context) => LoadingScreen(),
            LandingPage.id: (context) => LandingPage(),
          },
        );
      },
    );
  }
}
