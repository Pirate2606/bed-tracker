import 'register_hospital_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum MobileVerificationState {
  SHOW_LOGIN_SCREEN_STATE,
  SHOW_OTP_SCREEN_STATE,
}

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_LOGIN_SCREEN_STATE;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  String verificationId;
  bool showLoader = false;
  String nextScreen;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoader = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoader = false;
      });

      if (authCredential?.user != null) {
        Navigator.popAndPushNamed(context, RegisterHospital.id);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoader = false;
      });
      print(e.message);
    }
  }

  getMobileFormWidget(context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: Color(0XFFF6FFFE),
      ),
      child: Column(
        children: [
          SmallLogo(),
          LoginScreenText(
            text: 'Let\'s Get Started',
            sizeFont: 30.0,
            topPadding: 4.4.h,
            bottomPadding: 5.0,
          ),
          LoginScreenText(
            text: 'We will send an OTP to your mobile number',
            sizeFont: 16.0,
            topPadding: 4.0,
            bottomPadding: 0.0,
          ),
          LoginTextField(
            text: 'Enter Mobile Number',
            controller: phoneController,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 9.33.w,
              right: 9.33.w,
              top: 6.5.h,
            ),
            child: TextButton(
              style: kLoginButtonStyle,
              onPressed: () async {
                setState(() {
                  showLoader = true;
                });
                await _auth.verifyPhoneNumber(
                  timeout: Duration(milliseconds: 10000),
                  phoneNumber: '+91${phoneController.text}',
                  verificationCompleted: (verificationCompleted) {
                    setState(() {
                      showLoader = false;
                    });
                  },
                  verificationFailed: (verificationFailed) {
                    setState(() {
                      showLoader = false;
                    });
                    print(verificationFailed.message);
                  },
                  codeSent: (verificationId, resendToken) {
                    setState(() {
                      showLoader = false;
                      currentState =
                          MobileVerificationState.SHOW_OTP_SCREEN_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) {},
                );
              },
              child: Text(
                'Get OTP',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFFF6FFFE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getOtpFormWidget(context) {
    return Container(
      height: 300,
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: Color(0XFFF6FFFE),
      ),
      child: Column(
        children: [
          SmallLogo(),
          LoginScreenText(
            text: 'Let\'s Get Started',
            sizeFont: 30.0,
            topPadding: 4.4.h,
            bottomPadding: 5.0,
          ),
          LoginScreenText(
            text: 'Enter the OTP sent to you',
            sizeFont: 16.0,
            topPadding: 4.0,
            bottomPadding: 0.0,
          ),
          LoginTextField(
            text: 'Enter OTP',
            controller: otpController,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 9.33.w,
              right: 9.33.w,
              top: 6.5.h,
            ),
            child: TextButton(
              style: kLoginButtonStyle,
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: otpController.text);
                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFFF6FFFE),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: showLoader
            ? Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.SHOW_LOGIN_SCREEN_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  const LoginTextField({@required this.controller, this.text});

  final text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 9.0.w,
        right: 9.0.w,
        top: 6.1.h,
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        decoration: kTextFieldDecoration.copyWith(
          hintText: text,
          suffixIcon: Icon(
            Icons.arrow_right_alt_outlined,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class SmallLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
          padding: EdgeInsets.only(
            // right: 68.0.w,
            // left: 9.06.w,
            top: 10.4.h,
          ),
          child: Container(
            height: 25.4.h,
            width: 55.8.w,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/logo.png'),
              fit: BoxFit.fill,
            )),
          )),
    );
  }
}

class LoginScreenText extends StatelessWidget {
  LoginScreenText(
      {this.text, this.sizeFont, this.topPadding, this.bottomPadding});

  final text;
  final sizeFont;
  final topPadding;
  final bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
          left: 10.6.w,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: sizeFont,
            fontWeight: FontWeight.w400,
            color: Color(0XFF000000),
          ),
        ),
      ),
    );
  }
}
