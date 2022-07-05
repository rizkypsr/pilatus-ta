import 'package:flutter/material.dart';

const Color primaryColor = Color(0xffffa42c);
const Color primaryLightColor = Color(0xffffd55f);
const Color primaryDarkColor = Color(0xffc77500);
const Color secondaryColor = Color(0xff20263e);
const Color secondaryLightColor = Color(0xff494e69);
const Color secondaryDarkColor = Color(0xff000019);
const Color primaryTextColor = Color(0xff20263e);
const Color secondaryTextColor = Color(0xffffffff);
const Color redColor = Color(0xffb00020);

const colorScheme = ColorScheme(
  primaryContainer: primaryDarkColor,
  background: secondaryTextColor,
  brightness: Brightness.light,
  onPrimary: primaryTextColor,
  onSecondary: secondaryTextColor,
  primary: primaryColor,
  secondary: secondaryColor,
  onError: secondaryTextColor,
  error: redColor,
  onBackground: primaryTextColor,
  onSurface: primaryTextColor,
  surface: secondaryTextColor,
);
