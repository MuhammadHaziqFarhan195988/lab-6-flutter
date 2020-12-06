import 'package:flutter/material.dart';
import 'package:tea_app/Shared/constants.dart';
import 'package:tea_app/Shared/loading.dart';
import 'package:tea_app/models/user.dart';
import 'package:tea_app/screens/services/database.dart';
import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey= GlobalKey<FormState>();
  final List <String> sugar = ['0','1','2','3','4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData userData =snapshot.data;

          return Form(
                key: _formKey,
                child: Column(
                    children: <Widget>[
                      Text(
                        'Update your tea settings.',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        initialValue: userData.name,
                        decoration: textInputDecoration,
                        validator: (val)=>val.isEmpty?'Please enter a name' : null,
                        onChanged: (val) => setState(()=> _currentName=val),
                      ),
                      SizedBox(height: 20.0),
                      //dropdown
                      DropdownButtonFormField(
                        decoration: textInputDecoration,
                        value: _currentSugar ?? userData.sugar,
                        items: sugar.map((sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          );
                        }
                        ).toList(),
                        onChanged: (val) => setState(() => _currentSugar = val),
                      ),
                      Slider(
                        value: (_currentStrength?? userData.strength).toDouble(),
                        activeColor: Colors.brown[_currentStrength??userData.strength],
                        inactiveColor: Colors.brown[_currentStrength??userData.strength],
                        min: 100.0,
                        max: 900.0,
                        divisions: 8,
                        onChanged: (val) => setState(()=> _currentStrength = val.round()),
                      ),
                      //slider
                      RaisedButton(
                          color: Colors.pink[400],
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                           if(_formKey.currentState.validate()){
                             await DatabaseService(uid: user.uid).updateUserData(_currentSugar ?? userData.sugar
                                 , _currentName ?? userData.name,
                                 _currentStrength ?? userData.strength);
                             Navigator.pop(context);
                           }
                          }
                      )
                    ]
                )
            );
          } else {
            return Loading();
          }

      }
    );
  }
}
