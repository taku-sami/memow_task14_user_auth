import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

final _firestore = Firestore.instance;

class InvitedScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String mail;
  String password;
  String firstName;
  String lastName;
  InvitedScreen(this.mail, this.password, this.firstName, this.lastName);
  String inviteCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('招待されたページ'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: '招待コード',
              ),
              onChanged: (newValue) {
                inviteCode = newValue;
                print(inviteCode);
              },
            ),
            SizedBox(height: 40.0),
            FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text('送信'),
              onPressed: () async {
                try {
                  await _auth.createUserWithEmailAndPassword(
                      email: mail, password: password);
                  await _auth.signInWithEmailAndPassword(
                      email: mail, password: password);
                  final user = await _auth.currentUser();

                  _firestore.collection('users').document(user.uid).setData({
                    'firstName': '$firstName',
                    'lastName': '$lastName',
                    'farmID': '$inviteCode',
                  });

//                  _firestore.collection('farms').document(user.uid).setData(
//                    {
//                      'orner': '${user.uid}',
//                      'member': '${user.uid}',
//                    },
//                  );

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