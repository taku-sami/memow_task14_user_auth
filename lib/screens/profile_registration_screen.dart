import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memowtask14userauth/screens/home_screen.dart';

final _firestore = Firestore.instance;

class ProfileRegistrationScreen extends StatefulWidget {
  String mail;
  String password;
  ProfileRegistrationScreen(this.mail, this.password);

  @override
  _ProfileRegistrationScreenState createState() =>
      _ProfileRegistrationScreenState();
}

class _ProfileRegistrationScreenState extends State<ProfileRegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String firstName = '';
  String lastName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール情報の登録'),
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
                labelText: '姓',
              ),
              onChanged: (newValue) {
                firstName = newValue;
                print(firstName);
              },
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: '名',
              ),
              onChanged: (newValue) {
                lastName = newValue;
                print(lastName);
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
                    'firstName': '$firstName',
                    'lastName': '$lastName',
                  });

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
