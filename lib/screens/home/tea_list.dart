import 'package:flutter/material.dart';
import 'package:tea_app/models/teatype.dart';
import 'package:provider/provider.dart';
import 'package:tea_app/screens/home/tea_tile.dart';

class TeaList extends StatefulWidget {
  @override
  _TeaListState createState() => _TeaListState();
}

class _TeaListState extends State<TeaList> {
  @override
  Widget build(BuildContext context) {
    final teas = Provider.of<List<Teatype>>(context) ?? [];



    return ListView.builder(
      itemCount: teas.length,
      itemBuilder: (context, index) {
        return TeaTile(teacup: teas[index]);
      },
    );
  }
}
