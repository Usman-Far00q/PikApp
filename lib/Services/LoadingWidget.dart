import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

const spinkit = SpinKitRing(
  color: Colors.green,
  size: 50.0,
);
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: spinkit,color:Colors.white);
  }
}