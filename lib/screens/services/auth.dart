import 'package:firebase_auth/firebase_auth.dart';
import 'package:tea_app/models/user.dart';
import 'package:tea_app/screens/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase 'user'

  TheUser _userFromFirebaseUser(User user){
    return user != null ? TheUser(uid: user.uid): null;
  }

  //auth change user stream
  Stream<TheUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon
Future signInAnon() async {
  try{
    UserCredential result = await _auth.signInAnonymously();
    User user=result.user;
    return _userFromFirebaseUser(user);
  } catch(e) {
print(e.toString);
return null;
  }
}

  //sign in email & password

  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user= result.user;
      return _userFromFirebaseUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }

//register with email & password
Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user= result.user;

    //create a new document for the user
      await DatabaseService(uid: user.uid).updateUserData('0','new crew member',100);
    return _userFromFirebaseUser(user);
    } catch (e){
return null;
    }
}
//sign out
Future signOut() async {
    try{
      return await _auth.signOut();
    }catch (e){
print(e.toString());
return null;    }
}
}