import 'package:flutter/material.dart';
import 'package:pik_app/Models/info.dart';
import 'package:pik_app/infoList.dart';

class InfoTile extends StatelessWidget {

  final Info info;
  InfoTile({this.info});  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(radius:25,backgroundColor:Colors.transparent,backgroundImage: AssetImage('lib/Assets/download.png'),),
          title: Text(info.name),
          subtitle: Text(info.wants),
        ),
      ),
    );
  }
}