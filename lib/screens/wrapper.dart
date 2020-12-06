import 'package:flutter/material.dart';
import 'package:tea_app/models/user.dart';
import 'package:tea_app/screens/home/home.dart';
import 'package:tea_app/screens/authenticate/authenticate.dart';
import 'package:tea_app/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user=Provider.of<TheUser>(context);
    print(user);

    //return either home or authenticate widget
    if(user == null){
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}
