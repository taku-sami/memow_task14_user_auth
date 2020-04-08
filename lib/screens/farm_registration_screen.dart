import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memowtask14userauth/screens/home_screen.dart';

final _firestore = Firestore.instance;

class FarmRegistrationScreen extends StatefulWidget {
  String mail;
  String password;
  String firstName;
  String lastName;
  FarmRegistrationScreen(
      this.mail, this.password, this.firstName, this.lastName);

  @override
  _FarmRegistrationScreenState createState() => _FarmRegistrationScreenState();
}

class _FarmRegistrationScreenState extends State<FarmRegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String farmName;
  String farmAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('牧場を登録する'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
        child: Column(
          children: <Widget>[
            Text(widget.mail),
            Text(widget.password),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: '牧場名',
              ),
              onChanged: (newValue) {
                farmName = newValue;
              },
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: '住所',
              ),
              onChanged: (newValue) {
                farmAddress = newValue;
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
                try {
                  await _auth.createUserWithEmailAndPassword(
                      email: widget.mail, password: widget.password);
                  await _auth.signInWithEmailAndPassword(
                      email: widget.mail, password: widget.password);
                  final user = await _auth.currentUser();

                  _firestore.collection('users').document(user.uid).setData({
                    'firstName': '${widget.firstName}',
                    'lastName': '${widget.lastName}',
                    'farmID': '${user.uid}',
                  });
                  _firestore.collection('farms').document(user.uid).setData(
                    {
                      'name': '$farmName',
                      'address': '$farmAddress',
                      'orner': '${user.uid}',
                      'member': '${user.uid}',
                    },
                  );

                  if (user != null) {
                    _pushPage(context, HomeScreen());
                  }
                } catch (error) {
                  print(error);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _pushPage(BuildContext context, Widget page) {
  Navigator.push(
    context,
    MaterialPageRoute<void>(builder: (_) => page),
  );
}
