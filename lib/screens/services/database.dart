import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tea_app/models/teatype.dart';
import 'package:tea_app/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference teaCollection =  FirebaseFirestore.instance.collection('teaMix');

Future updateUserData(String sugar,String name,int strength) async {
  return await teaCollection.doc(uid).set(
    {
      'sugar':sugar,
      'name' : name,
      'strength':strength,
    }
  );
}


//Brew list from snapshot
  List<Teatype> _teaListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.docs.map((doc){
    return Teatype(
      name: doc.data()['name'] ?? '',
      strength: doc.data()['strength'] ?? 0,
        sugar: doc.data()['sugar'] ?? 0
    );
  }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  return UserData(
    uid: uid,
    name: snapshot.data()['name'],
    sugar: snapshot.data()['sugar'],
    strength: snapshot.data()['strength']
  );
  }
//QuerySnapshot
Stream<List<Teatype>> get teas{
  return teaCollection.snapshots().map(_teaListFromSnapshot);


}


//get user doc Stream
Stream<UserData> get userData {
  return teaCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
}
}