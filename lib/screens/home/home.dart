import 'package:flutter/material.dart';
import 'package:tea_app/screens/home/setting_form.dart';
import 'package:tea_app/screens/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/screens/services/database.dart';
import 'package:tea_app/screens/home/tea_list.dart';
import 'package:tea_app/models/teatype.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context,builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Teatype>>.value(
      initialData: List(),
    value: DatabaseService().teas,
    child: Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
      title: Text('Team Tea Time'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.person),
          label: Text('logout'),
          onPressed: () async{
          await _auth.signOut();
          },
        ),
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('settings'),
            onPressed:() => _showSettingsPanel()
          )
    ],
    )
        ,body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: TeaList()),
    ),
    );
  }
}
