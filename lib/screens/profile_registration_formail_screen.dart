import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'join_farm_screen.dart';

class ProfileRegistrationForMailScreen extends StatefulWidget {
  @override
  _ProfileRegistrationForMailScreenState createState() =>
      _ProfileRegistrationForMailScreenState();
}

class _ProfileRegistrationForMailScreenState
    extends State<ProfileRegistrationForMailScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String mail;
    String password;
    String name;
    var errorMessage = 'テスト';

    return Scaffold(
      appBar: AppBar(
        title: Text('メールで会員登録'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
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
                  labelText: '氏名',
                ),
                onChanged: (newValue) {
                  name = newValue;
                  print(name);
                },
              ),
              Text('$errorMessage'),
              FlatButton(
                child: Text('登録'),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () async {
                  try {
//                    final mailCheck =
//                        await _auth.fetchSignInMethodsForEmail(email: mail);
//                    print(mailCheck);
                    await _auth.createUserWithEmailAndPassword(
                        email: mail, password: password);
                    await _auth.signInWithEmailAndPassword(
                        email: mail, password: password);
                    final user = await _auth.currentUser();
                    UserUpdateInfo updateInfo = UserUpdateInfo();
                    updateInfo.displayName = name.toString();
                    await user.reload();
                    await user.updateProfile(updateInfo);
                    _pushPage(
                      context,
                      JoinFarmScreen(),
                    );
//                    if (mailCheck[0] == 'password') {
//                      setState(() {
//                        errorMessage = 'このメールアドレスは既に登録されています';
//                      });
//                      print('登録済');
//                    } else {
//                    }
                  } catch (error) {
                    setState(() {
                      errorMessage = '';
                    });
                  }
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
