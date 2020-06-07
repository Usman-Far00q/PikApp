import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pik_app/Models/User.dart';
import 'package:pik_app/Models/info.dart';

class DatabaseService{


  final String uid;

  DatabaseService({this.uid});

  //collection reference

  final CollectionReference reference = Firestore.instance.collection('info');

  Future updateUserData({String name , String wants})async{

    return await reference.document(uid).setData({
      'name':name,
      'wants':wants
    });
  }

//info list from a snapshot
List<Info> _infoListFromSnapshot(QuerySnapshot snapshot){

  return snapshot.documents.map((doc){
        return Info(
          name: doc.data['name'] ?? 'Generic User',
          wants: doc.data['wants'] ?? 'I want nothing',
        );
  }).toList();
}
//
Userdata _userdataFromSnapshot(DocumentSnapshot snapshot){
  return Userdata(
    name: snapshot.data['name'],
    uid:uid,
    wants: snapshot.data['wants']
  );

}

// info stream

Stream<List<Info> > get info {
  return reference.snapshots().map((val){
    return _infoListFromSnapshot(val);
  });
}

Stream<Userdata> get userdata{
  return reference.document(uid).snapshots().map(_userdataFromSnapshot);
}


}