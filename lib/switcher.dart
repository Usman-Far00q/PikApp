import 'package:pik_app/authOptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pik_app/Models/User.dart';
import 'package:pik_app/home.dart';
class Switcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //will contain if else satement to retun either authoptions or home
    final user = Provider.of<User>(context);
    if(user == null)
    {
      return AuthOptions();
    }else{
      return Home();
    }
  }
}