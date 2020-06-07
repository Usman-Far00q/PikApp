import 'package:flutter/material.dart';
import 'package:pik_app/register.dart';
import 'package:pik_app/signIn.dart';
class AuthOptions extends StatefulWidget {
  @override
  _AuthOptionsState createState() => _AuthOptionsState();
}

class _AuthOptionsState extends State<AuthOptions> {
   bool showSignIn= true;
    void toggleView()
    {
      setState(() {
        showSignIn =!showSignIn;
      });
    }
  @override
  Widget build(BuildContext context) {
    // if else statement that will return ither reg or signin widget
      if(showSignIn)
      {
        return SignIn(toggleView:toggleView);
      }else{
        return Register(toggleView:toggleView);
      }
  }
}