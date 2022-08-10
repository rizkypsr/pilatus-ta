import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilatus/styles/colors.dart';

final TextStyle heading1 =
    GoogleFonts.ubuntu(fontSize: 40, fontWeight: FontWeight.bold, height: 1.2);

final TextStyle heading2 = GoogleFonts.ubuntu(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: primaryTextColor);

final TextStyle heading3 = GoogleFonts.ubuntu(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: primaryTextColor);

final TextStyle heading4 = GoogleFonts.ubuntu(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.2,
    color: primaryTextColor);

final TextStyle heading5 = GoogleFonts.ubuntu(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.2,
    color: primaryTextColor);

final TextStyle heading6 = GoogleFonts.ubuntu(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
    color: primaryTextColor);

final TextStyle paragraph1 = GoogleFonts.ubuntu(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    height: 1.2,
    color: primaryTextColor);

final TextStyle paragraph2 = GoogleFonts.ubuntu(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.2,
    color: primaryTextColor);

final textTheme = TextTheme(
    headline1: heading1,
    headline2: heading2,
    headline3: heading3,
    headline4: heading4,
    headline5: heading5,
    headline6: heading6,
    bodyText2: paragraph1,
    subtitle1: paragraph2);
