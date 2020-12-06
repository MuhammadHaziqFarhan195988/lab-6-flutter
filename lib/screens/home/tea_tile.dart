import 'package:flutter/material.dart';
import 'package:tea_app/models/teatype.dart';

class TeaTile extends StatelessWidget {
  final Teatype teacup;
  TeaTile({this.teacup});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[teacup.strength],
              backgroundImage: AssetImage('assets/coffee_icon.png'),
            ),
            title: Text(teacup.name),
            subtitle: Text('Takes ${teacup.sugar} sugar(s)'),
          ),
        )
    );
  }
}
