import 'dart:convert';

import 'package:floran_todo/utils/MyRouts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final url = "http://192.168.0.179:8000/api/auth/";

  movetohome(BuildContext context, String username, String password) async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      final response = await http.post(
        Uri.parse(url + 'login'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      var data = json.decode(response.body);
      if (data['token'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('Token', data['token']);
        await prefs.setInt('id', data["user"]['id']);
        await prefs.setString('username', data["user"]['username']);
        await prefs.setString('email', data["user"]['email']);
      } 
      Navigator.pushNamedAndRemoveUntil(
          context, MyRoutes.homeinRoute, (route) => false);
    }
  }

  movetoregister(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, MyRoutes.registerRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 150),
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(isDarkMode
                        ? 'assets/images/logo_dark.png'
                        : 'assets/images/logo.png'),
                    SizedBox(height: 10),
                    Text(
                      "Log-in Page",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 10),
                    usernameField(),
                    SizedBox(height: 10),
                    passwordField(),
                    SizedBox(height: 10),
                    Material(
                      color: context.theme.buttonColor,
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () =>
                            movetohome(context, username.text, password.text),
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      child: Text("Dont have account register here"),
                      onTap: () => movetoregister(context),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget usernameField() {
    return TextFormField(
      controller: username,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter username';
        }
        return null;
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          hintText: "Enter Unique Username", labelText: "Username"),
      onChanged: (value) {
        String name = '';
        name = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: password,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      keyboardType: TextInputType.name,
      obscureText: true,
      decoration:
          InputDecoration(hintText: "Enter Password", labelText: "Password"),
    );
  }
}
