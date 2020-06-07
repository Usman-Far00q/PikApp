import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/info.dart';
import 'Models/infoTile.dart';

class InfoList extends StatefulWidget {
  @override
  _InfoListState createState() => _InfoListState();
}

class _InfoListState extends State<InfoList> {

  @override
  Widget build(BuildContext context) {
      final list = Provider.of<List<Info>>(context) ?? [];
      if(list != null){
        list.forEach((info){
        print(info.wants);
        print(info.name);
      });
      }
    return ListView.builder(itemBuilder: (context,index){return InfoTile(info: list[index]);},
    itemCount: list.length,
    );
  }
}