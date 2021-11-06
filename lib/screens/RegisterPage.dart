import 'dart:convert';

import 'package:floran_todo/utils/Constants.dart';
import 'package:floran_todo/utils/MyRouts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  register(BuildContext context, String username, String email, String password,
      String confirmpassword) async {
    if (_formKey.currentState!.validate()) {
      final response =
          await http.post(Uri.parse(Constants.baseUrl + "auth/register"),
              headers: <String, String>{'Content-Type': 'application/json'},
              body: jsonEncode(<String, String>{
                'username': username,
                'email': email,
                'password': password,
                'password2': confirmpassword
              }));

      if (response.statusCode == 200) {
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
      } else {
        var data = json.decode(response.body);

        if (data.containsKey('username')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Username already exists")));
        } else if (data.containsKey('email')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email already exists")));
        }
      }
    }
  }

  movetologin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, MyRoutes.loginRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(isDarkMode
                          ? 'assets/images/logo_dark.png'
                          : 'assets/images/logo.png'),
                      SizedBox(height: 10),
                      Text(
                        "Register Page",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      usernameField(),
                      SizedBox(height: 10),
                      emailField(),
                      SizedBox(height: 10),
                      passwordField(),
                      SizedBox(height: 10),
                      password2Field(),
                      SizedBox(height: 10),
                      Material(
                        color: context.theme.buttonColor,
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () => register(context, username.text,
                              email.text, password.text, confirmpassword.text),
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            height: 50,
                            width: 150,
                            alignment: Alignment.center,
                            child: Text(
                              "Register",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        child: Text("Already have account"),
                        onTap: () => movetologin(context),
                      )
                    ],
                  )),
            ),
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

  Widget emailField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        String pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';

        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(value!)) {
          return 'Enter a valid email address';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(hintText: "Enter email address", labelText: "Email"),
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

  Widget password2Field() {
    return TextFormField(
      controller: confirmpassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter matching password';
        }
        if (password.text != confirmpassword.text) {
          return "Password does not match";
        }
        return null;
      },
      keyboardType: TextInputType.name,
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Enter Password Again", labelText: "Confirm Password"),
    );
  }
}
