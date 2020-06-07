import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pik_app/Services/LoadingWidget.dart';
import 'package:pik_app/Services/auth.dart';
import 'package:pik_app/Services/database.dart';
import 'package:provider/provider.dart';
import 'Models/User.dart';

class Settings extends StatefulWidget {
  final String uid;
  @override
  _SettingsState createState() => _SettingsState();
  Settings({this.uid});
}

class _SettingsState extends State<Settings> {
  String name;
  bool loading = false;
  String _currentwants;
  String _currentName;
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    // final user = Provider.of<User>(context);
    print(widget.uid);
    return loading ? Loading() : StreamBuilder<Userdata>(
      stream: DatabaseService(uid:widget.uid).userdata,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Userdata userdata = snapshot.data;
          return Form(
          key: _key,
          child: Container(
            padding:
                  EdgeInsets.only(left:30.0,right:30.0,bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                            SizedBox(height:30.0),
                Center(child: Text('Update Your Personal Data')),
                SizedBox(height:20.0),
                Text('Name:'),
                TextFormField(
                  initialValue: userdata.name,
                  validator: (val) => val.isEmpty ? 'you must have a valid name' : null,
                  onChanged: (val){
                    setState(() {
                      _currentName = val ?? userdata.name;
                      _currentwants =  _currentwants ?? userdata.wants;
                    });
                  },
                  decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(borderSide:BorderSide(width:2.0,color:Colors.green)),
                          enabledBorder: OutlineInputBorder(borderSide:BorderSide(color:Colors.grey)),
                          filled: true,
                        ),
                ),
                SizedBox(height:20.0),
                TextFormField(
                        initialValue: userdata.wants,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (val){
                    setState(() {
                      _currentwants = val ?? userdata.wants;
                      _currentName = _currentName ?? userdata.name;
                    });
                  },
                      ),
                SizedBox(height:20.0),
                Center(child: RaisedButton(
                  onPressed: ()async {
                        if(_key.currentState.validate())
                        {
                          setState(() {
                            loading = true;
                          });
                             await DatabaseService(uid:widget.uid).updateUserData(name: _currentName,wants:_currentwants);
                             print(_currentName);
                             print(_currentwants);
                             setState(() {
                            loading = false;
                          });
                        }
                        
                },child: Text('Update',style: TextStyle(color: Colors.white),),
                color: Colors.green
                )
                
                )
              ],
            ),
          ),
        );
        }else{
          return Loading();
        }
      }
    );
  }
}