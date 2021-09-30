import 'dart:convert';

import 'package:floran_todo/screens/Homepage.dart';
import 'package:floran_todo/screens/Loginpage.dart';
import 'package:floran_todo/screens/RegisterPage.dart';
import 'package:floran_todo/screens/Splash.dart';
import 'package:floran_todo/utils/MyRouts.dart';
import 'package:floran_todo/widgets/Themes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  isAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('Token');
    final response = await http.get(
        Uri.parse("http://192.168.0.179:8000/api/auth/user"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token'
        });

    var data = json.decode(response.body);
    bool isauth = false;
    if (response.statusCode == 200) {
      isauth = true;
      await prefs.setInt('id', data['id']);
      await prefs.setString('username', data['username']);
      await prefs.setString('email', data['email']);
    } else {
      isauth = false;
      await prefs.setString('Token', '');
      await prefs.setInt('id', 0);
      await prefs.setString('username', '');
      await prefs.setString('email', '');
    }
    return isauth;
  }

  @override
  Widget build(BuildContext context) {
    var auth = isAuth();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: Mytheme.lightTheme(context),
        darkTheme: Mytheme.darkTheme(context),
        routes: {
          MyRoutes.loginRoute: (context) => Loginpage(),
          MyRoutes.homeinRoute: (context) => HomePage(),
          MyRoutes.registerRoute: (context) => RegisterPage(),
        },
        home: Splash());
  }
}
