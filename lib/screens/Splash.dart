import 'dart:convert';

import 'package:floran_todo/utils/MyRouts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    isAuth();
    super.initState();
  }

  isAuth() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('Token');
    print(token);
    final response = await http.get(
        Uri.parse("http://192.168.2.101:8000/api/auth/user"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token'
        });

    print(response.body);
    var data = json.decode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(data['id']);
      await prefs.setInt('id', data['id']);
      await prefs.setString('username', data['username']);
      await prefs.setString('email', data['email']);
      Navigator.pushReplacementNamed(context, MyRoutes.homeinRoute);
    } else {
      await prefs.setString('Token', '');
      await prefs.setInt('id', 0);
      await prefs.setString('username', '');
      await prefs.setString('email', '');
      Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(isDarkMode
                ? 'assets/images/logo_dark.png'
                : 'assets/images/logo.png'),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
