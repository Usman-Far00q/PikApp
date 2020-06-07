import 'package:flutter/material.dart';
import 'package:pik_app/Services/auth.dart';
import 'Services/LoadingWidget.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  AuthServices _auth = AuthServices();
 final _formkey = GlobalKey<FormState>();
 String email ='';
 String password = '';
 String error = '';
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Sign In'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person,color: Colors.white,), label: Text('Register',style: TextStyle(color:Colors.white),)),
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
                  validator: (val) => val.isEmpty ? 'You Can Not Leave This Field Empty' : null,
                  onChanged: (val){setState(() => password = val);},
            ),
            SizedBox(height:10),
            RaisedButton(color:Colors.green,onPressed: ()async{
              if(_formkey.currentState.validate())
              {
                setState(() {
                  loading = true;
                });
                dynamic result = await _auth.signInWithEmailAndPassword(email: email, password: password);
                 if(result == null)
                  {
                     setState((){
                      error = 'Failed to Sign In (maybe email or password is invalid)';
                      loading = false;
                     });
                  }else{
                     print('annon signed in');
                      print(result.uid);
                  }
              }
              else{
                print('form info not validated properly');
              }
            },child: Text('Sign In',style: TextStyle(color: Colors.white))),
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