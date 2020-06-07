import 'package:flutter/material.dart';
import 'package:pik_app/Models/User.dart';
import 'package:pik_app/Services/auth.dart';
import 'package:pik_app/switcher.dart';
import 'package:provider/provider.dart';
void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: Switcher());
  }
}