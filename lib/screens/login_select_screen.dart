import 'package:flutter/material.dart';
import 'package:memowtask14userauth/screens/home_screen.dart';
import 'package:memowtask14userauth/screens/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSelectScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Text(
                'ログイン方法を選択してください',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50.0,
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('メールでログイン'),
                onPressed: () {
                  _pushPage(
                    context,
                    LoginScreen(),
                  );
                },
              ),
              SizedBox(height: 20.0),
              FlatButton(
                color: Colors.grey,
                textColor: Colors.white,
                child: Text('Googleでログイン'),
                onPressed: () async {
                  await signInWithGoogle();
                  _pushPage(context, HomeScreen());
                },
              ),
            ],
          ),
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
