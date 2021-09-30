import 'package:floran_todo/utils/MyRouts.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  movetohome(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
     Navigator.pushNamedAndRemoveUntil(
          context, MyRoutes.homeinRoute, (route) => false);
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
                        onTap: () => movetohome(context),
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          height: 50,
                          width: 150,
                          alignment: Alignment.center,
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
    );
  }

  Widget usernameField() {
    return TextFormField(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email';
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
          return 'Please enter username';
        } 
        if(password.text!=confirmpassword.text){
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
