import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef ShaderCallback = Shader Function(Rect);

const Map<String, Icon> map = {
  "home": Icon(Icons.home, size: 30),
  "account": Icon(Icons.account_circle, size: 30),
  "search": Icon(Icons.search, size: 30),
  "chat": Icon(Icons.chat_bubble, size: 30)
};

ShaderCallback shaderCallback = (bounds) =>
    const RadialGradient(colors: [Colors.blue, Colors.red], tileMode: TileMode.mirror, radius: 1, center: Alignment.topLeft).createShader(bounds);

const secondaryColor = Colors.white;
const secondaryVariantColor = Color(0xFFc29017);
const onsecondaryColor = Colors.black;
const primaryColor = Colors.white;
const primaryVariantColor = Color(0xff6C6C6C);
const onPrimaryColor = Color(0xffdedede);
const backgroundColor = Color.fromRGBO(211, 211, 211, 1);
const onBackgroundColor = Color(0xffdedede);
const surfaceColor = Colors.black;
const onSurfacesColor = Color(0xffdedede);
const textColor = Color(0xffdedede);
const errorColor = Color(0xfff44336);
const onErrorColor = Color(0xFF2a2a2a);
const boxShadowColor = Color.fromRGBO(114, 114, 109, 0.8);

final ThemeData theme = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
        focusColor: backgroundColor,
        focusedBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        disabledBorder: OutlineInputBorder(),
        labelStyle: TextStyle(color: primaryColor)),
    colorScheme: const ColorScheme(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: onPrimaryColor,
        onSecondary: onsecondaryColor,
        onSurface: onSurfacesColor,
        onBackground: onBackgroundColor,
        onError: onErrorColor,
        brightness: Brightness.dark),
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: const Color.fromRGBO(211, 211, 211, 1),
    splashColor: Colors.black,
    shadowColor: const Color.fromRGBO(30, 30, 30, 1),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
        headline1: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        headline6: GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        bodyText1: GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontSize: 15)),
        button: const TextStyle(fontFamily: 'OpenSans'),
        subtitle1: GoogleFonts.robotoCondensed(),
        bodyText2: GoogleFonts.robotoCondensed(),
        headline5:
            GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontFamily: '', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        headline4: GoogleFonts.robotoCondensed(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24))));

const String urlDrapeauBreton = 'https://m.media-amazon.com/images/I/41Llb8l-kXL._AC_SX425_.jpg';
