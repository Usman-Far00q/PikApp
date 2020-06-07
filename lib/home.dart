import 'package:flutter/material.dart';
import 'package:pik_app/Services/auth.dart';
import 'package:pik_app/Services/database.dart';
import 'package:pik_app/setting.dart';
import 'package:provider/provider.dart';
import 'Models/User.dart';
import 'Models/info.dart';
import 'infoList.dart';

class Home extends StatelessWidget {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    
    _showBottomSheet(){
      showModalBottomSheet(
        //important
          isScrollControlled: true,
        context: context, builder: (context){
        return SingleChildScrollView(
          child: Container(
            child: Settings(uid:user.uid),
          ),
        );
      });

    }
    return StreamProvider<List<Info> >.value(
      value: DatabaseService().info,
          child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(onPressed: (){
                _showBottomSheet();
              }
              , icon: Icon(Icons.settings,color: Colors.white,)),

            FlatButton.icon(onPressed: ()async{
              await _auth.signOut();
              }
              , icon: Icon(Icons.exit_to_app,color: Colors.white,), label: Text('logout',style: TextStyle(color: Colors.white),)),
          ],
        ),
        body: InfoList(),
      ),
    );
  }
}