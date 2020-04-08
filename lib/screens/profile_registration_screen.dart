import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'select_screen.dart';

class ProfileRegistrationScreen extends StatefulWidget {
  @override
  _ProfileRegistrationScreenState createState() =>
      _ProfileRegistrationScreenState();
}

class _ProfileRegistrationScreenState extends State<ProfileRegistrationScreen> {
  String mail;
  String password;
  String firstName;
  String lastName;
  String userId = '';
  String errorMessage = '';

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
        title: Text('会員登録'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Text(userId),
              Text(
                'ユーザー情報登録',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Mail',
                ),
                onChanged: (newValue) {
                  mail = newValue;
                  print(mail);
                },
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (newValue) {
                  password = newValue;
                  print(password);
                },
              ),
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
              Text('$errorMessage'),
              FlatButton(
                child: Text('次へ'),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    final mailCheck =
                        await _auth.fetchSignInMethodsForEmail(email: mail);

                    print(mailCheck);
                    if (mailCheck[0] == 'password') {
                      setState(() {
                        errorMessage = 'このメールアドレスは既に登録されています';
                      });
                    }
                  } catch (error) {
                    setState(() {
                      errorMessage = '';
                    });
                    _pushPage(
                      context,
                      SelectScreen(mail, password, firstName, lastName),
                    );
                  }
                },
              ),
              FlatButton(
                color: Colors.grey,
                textColor: Colors.white,
                child: Text('Googleでサインアップ'),
                onPressed: () {
                  signInWithGoogle();
                },
              ),
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('ログアウト'),
                onPressed: () {
                  signOutGoogle();
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
