import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  static String id = 'landingPage';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
              Padding(
                padding: EdgeInsets.only(
                  left: 13.5.w,
                  right: 13.5.w,
                  top: 8.27.h,
                ),
                child: Image(
                    height: 34.4.h,
                    width: 72.8.w,
                    image: AssetImage('images/logo.png')),
              ),
              LargeButton(
                text: 'Register A Hospital',
                padding: 10.5.h,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              LargeButton(
                text: 'View Beds',
                padding: 5.74.h,
                onPressed: () {
                  // Navigator.pushNamed(context, SearchHospitals.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LargeButton extends StatelessWidget {
  LargeButton({this.text, this.padding, this.onPressed});
  final String text;
  final padding;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: TextButton(
        style: kButtonStyle,
        onPressed: onPressed,
        child: Container(
          width: 72.8.w,
          height: 10.3.h,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: kButtonText,
            ),
          ),
        ),
      ),
    );
  }
}
