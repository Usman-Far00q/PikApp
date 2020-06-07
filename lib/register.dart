import 'package:flutter/material.dart';
import 'Services/LoadingWidget.dart';
import 'Services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
 final _formkey = GlobalKey<FormState>();
 AuthServices _auth = AuthServices();
 bool loading = false;
 String userName = '';
 String email ='';
 String password = '';
 String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Register'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person,color: Colors.white,), label: Text('Sign In',style: TextStyle(color:Colors.white),)),
        ],
      ),
      body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12.0),
                child: Form(
                  key: _formkey,
                child: Column(
          children: <Widget>[
            TextFormField(
                  decoration: InputDecoration(
                    hintText: 'User Name',
                    focusedBorder: OutlineInputBorder(borderSide:BorderSide(width:2.0,color:Colors.green)),
                    enabledBorder: OutlineInputBorder(borderSide:BorderSide(color:Colors.grey)),
                    filled: true,
                  ),
                  validator: (val)=> val.isEmpty ? 'You Can Not Leave This Field Empty' : null,
                  onChanged: (val){setState(() => userName = val);},
            ),
            SizedBox(height:10),
            TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    focusedBorder: OutlineInputBorder(borderSide:BorderSide(width:2.0,color:Colors.green)),
                    enabledBorder: OutlineInputBorder(borderSide:BorderSide(color:Colors.grey)),
                    filled: true
                  ),
                  validator: (val) => val.isEmpty ? 'You Can Not Leave This Field Empty' : null,
                  onChanged: (val){setState(() => email = val);},
            ),
            SizedBox(height:10),
             TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    focusedBorder: OutlineInputBorder(borderSide:BorderSide(width:2.0,color:Colors.green)),
                    enabledBorder: OutlineInputBorder(borderSide:BorderSide(color:Colors.grey)),
                    filled: true,
                  ),
                  obscureText: true,
                  validator: (val)=> val.length < 6  ? 'Password Must Be Of 6+ Characters' : null,
                  onChanged: (val){setState(() => password = val);},
            ),
            SizedBox(height:10),
            RaisedButton(color:Colors.green,onPressed: ()async{
              if(_formkey.currentState.validate())
              {
                setState(() {
                  loading = true;
                });
                dynamic result = await _auth.registerWithEmailAndPassword(email:email,password:password,username:userName);
                 if(result == null)
                  {
                    setState((){
                      error = 'Failed to Register (maybe email is invalid)';
                      loading = false;
                      });
                  }else{
                     print('annon signed upped');
                      print(result.uid);
                  }
              }
              else{
                print('form info not validated properly');
              }
            },
            child: Text('Register',style: TextStyle(color: Colors.white))
            ),
            SizedBox(height:10),
            Text(error,style: TextStyle(color: Colors.red),)
          ]
        ),
                ),
              ),
      ),
    );
  }
  }