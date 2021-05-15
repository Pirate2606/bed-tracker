import 'package:flutter/material.dart';

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


