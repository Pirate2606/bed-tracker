import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


const kButtonText = TextStyle(
  color: Color(0XFF4FC2B9),
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

var kButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xFF707070),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(22.0),
    ),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter the value',
  hintStyle: TextStyle(
    color: Colors.black,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(22.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(22.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0XFF9DD7D3), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(22.0)),
  ),
);

var kLoginButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22.0),
    ),
  ),
  backgroundColor: MaterialStateProperty.all(
    Color(0XFF4FC2B9),
  ),
  padding: MaterialStateProperty.all(
    EdgeInsets.symmetric(
      vertical: 1.35.h,
      horizontal: 25.6.w,
    ),
  ),
);
