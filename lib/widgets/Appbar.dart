import 'package:floran_todo/utils/Constants.dart';
import 'package:floran_todo/utils/MyRouts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class Appbar extends StatelessWidget {
  const Appbar({Key? key}) : super(key: key);

  logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('Token');
    final response = await http.post(
        Uri.parse(Constants.baseUrl + "auth/logout"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token'
        },
        body: null
      );
    if(response.statusCode == 204){
      await prefs.setString('Token', '');
      await prefs.setInt('id', 0);
      await prefs.setString('username', '');
      await prefs.setString('email', '');

      Navigator.pushNamedAndRemoveUntil(
            context, MyRoutes.loginRoute, (route) => false);
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error Occur Please try again !")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        "Floran Todo".text.xl3.bold.color(context.theme.accentColor).make(),
        Spacer(),
        ElevatedButton(
          child: Text("Logout"),
          onPressed: () => logout(context),
          style: ButtonStyle(
            // shape: MaterialStateProperty.all(StadiumBorder()),
            backgroundColor:
                MaterialStateProperty.all(context.theme.buttonColor),
          ),
        )
      ],
    );
  }
}
