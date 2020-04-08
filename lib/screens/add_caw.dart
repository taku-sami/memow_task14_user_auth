import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class AddCawScreen extends StatelessWidget {
  final farmId;
  AddCawScreen(this.farmId);

  @override
  Widget build(BuildContext context) {
    String name;
    return Scaffold(
      appBar: AppBar(
        title: Text('牛の追加'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Text(farmId),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: '牛の名前',
              ),
              onChanged: (newValue) {
                name = newValue;
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('登録'),
              onPressed: () async {
                _firestore
                    .collection('farms')
                    .document('$farmId')
                    .collection('caw')
                    .add({'name': '$name'});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
