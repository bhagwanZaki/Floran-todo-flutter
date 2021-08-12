import 'package:floran_todo/screens/Homepage.dart';
import 'package:floran_todo/screens/Loginpage.dart';
import 'package:floran_todo/screens/RegisterPage.dart';
import 'package:floran_todo/utils/MyRouts.dart';
import 'package:floran_todo/widgets/Themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Mytheme.lightTheme(context),
      darkTheme: Mytheme.darkTheme(context),
      initialRoute: MyRoutes.loginRoute,
      routes: {
        "/": (context) => Loginpage(),
        MyRoutes.loginRoute: (context) => Loginpage(),
        MyRoutes.homeinRoute: (context) => HomePage(),
        MyRoutes.registerRoute: (context) => RegisterPage(),
      },
    );
  }
}

