import 'package:flutter/material.dart';
import 'package:tea_app/models/user.dart';
import 'package:tea_app/screens/services/auth.dart';
import 'package:tea_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
      value: AuthService().user,
      child: MaterialApp(
       home: Wrapper(),
      ),
    );
  }
}


