import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'select_screen.dart';

class ProfileRegistrationScreen extends StatefulWidget {
  @override
  _ProfileRegistrationScreenState createState() =>
      _ProfileRegistrationScreenState();
}

class _ProfileRegistrationScreenState extends State<ProfileRegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String mail;
  String password;
  String firstName;
  String lastName;
  String errorMessage = '';

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
