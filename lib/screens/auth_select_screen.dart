import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'profile_registration_formail_screen.dart';
import 'join_farm_screen.dart';

class AuthSelectScreen extends StatefulWidget {
  @override
  _AuthSelectScreenState createState() => _AuthSelectScreenState();
}

class _AuthSelectScreenState extends State<AuthSelectScreen> {
  String userId = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool logined = false;

  void login() {
    setState(() {
      logined = true;
    });
  }

  void logout() {
    setState(() {
      logined = false;
    });
  }

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
    setState(() {
      userId = currentUser.uid;
    });
    login();
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    logout();
    print('User Sign Out Google');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会員'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(userId),
                Text(
                  '登録方法を選択してください',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 50.0,
                ),
                FlatButton(
                    child: Text('メールでサインアップ'),
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      _pushPage(
                        context,
                        ProfileRegistrationForMailScreen(),
                      );
                    }),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Text('Googleでサインアップ'),
                  onPressed: () async {
                    await signInWithGoogle();
                    _pushPage(
                      context,
                      JoinFarmScreen(),
                    );
                  },
                ),
//                FlatButton(
//                  color: Colors.red,
//                  textColor: Colors.white,
//                  child: Text('ログアウト'),
//                  onPressed: () {
//                    signOutGoogle();
//                  },
//                ),
              ],
            ),
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
