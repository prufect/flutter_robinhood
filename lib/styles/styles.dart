import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static const Color color_text = const Color(0xFFF1F2F4);
  static const Color color_textAlternate = const Color(0xFF7D7E80);
  static const Color color_background = const Color(0xFF040D16);
  static const Color color_positive = const Color(0xFF01C807);
  static const Color color_negative = const Color(0xFFFE4F04);
  static const Color color_positiveAccent = const Color(0xFF041F13);
  static const Color color_backgroundAccent = const Color(0xFF31373A);

  static const String fontFamily = "Avenir";

  // ignore: non_constant_identifier_names
  static final TextStyle textstyle_header = TextStyle(
    color: color_text,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 36.0,
  );

  // ignore: non_constant_identifier_names
  static final TextStyle textstyle_subheaderPositive = TextStyle(
    color: color_positive,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    fontSize: 16.0,
  );

  // ignore: non_constant_identifier_names
  static final TextStyle textstyle_appbar_title = TextStyle(
    color: color_text,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
  );

  // ignore: non_constant_identifier_names
  static final TextStyle textstyle_appbar_subtitle = TextStyle(
    color: color_textAlternate,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    fontSize: 16.0,
  );

  static final TextStyle textstyle_graphOption = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w900,
    fontSize: 16.0,
  );
}
