import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Mytheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: GoogleFonts.poppins().fontFamily,
      primaryTextTheme: GoogleFonts.poppinsTextTheme(),
      cardColor: Colors.white,
      accentColor: darkBluishColor,
      buttonColor: darkBluishColor,
      iconTheme:  IconThemeData(color: Colors.white),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: darkFloatAction),
      canvasColor: creamColor,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: Theme.of(context).textTheme));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.orange,
      fontFamily: GoogleFonts.poppins().fontFamily,
      primaryTextTheme: GoogleFonts.poppinsTextTheme(),
      cardColor: Colors.black38,
      iconTheme:  IconThemeData(color: Colors.white),
      buttonColor: Colors.orange,
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: darkFloatAction),
      canvasColor: darkcreamColor,
      accentColor: Colors.white,
      appBarTheme: AppBarTheme(
          color: Colors.black,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: Theme.of(context).textTheme
          )
    );

  static Color creamColor = Color(0xfff5f5f5);
  static Color darkFloatAction = Color(0xff005aba);
  static Color darkcreamColor =Vx.gray900;
  static Color darkBluishColor = Color(0xff403b58);
  static Color lightBluishColor = Vx.indigo500;
}