import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pik_app/Models/User.dart';
import 'package:pik_app/Services/database.dart';

class AuthServices{
  
  User userFromFrebaseUser(FirebaseUser user){
    if(user == null)
    {
      return null;
    }else{
       return User(uid:user.uid);
    }
   
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  
  Stream<User> get user
  {
    return _auth.onAuthStateChanged.map((val)=>userFromFrebaseUser(val));
  }
  
  Future signInAnon() async {
    try{
        AuthResult result = await _auth.signInAnonymously();
        FirebaseUser user  = result.user;
        return  userFromFrebaseUser(user);
    }catch(e){
        print(e.toString());
        return null;
    }

  }

  Future signOut() async {

    try{
      return await _auth.signOut();
    }catch(e){
        print('e');
        return null;
    }
  }

Future registerWithEmailAndPassword({String email,String password,String username})async {

    try{
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        await DatabaseService(uid: user.uid).updateUserData(name: username, wants: 'I want nothing');
        return userFromFrebaseUser(user);
    }catch(e){
          print(e.toString());
          return null;
    }
}
Future signInWithEmailAndPassword({String email,String password})async {

    try{
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return userFromFrebaseUser(user);
    }catch(e){
          print(e.toString());
          return null;
    }
}

}

