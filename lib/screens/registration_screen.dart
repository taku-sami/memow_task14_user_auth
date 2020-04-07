import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_registration_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String mail;
  String password;
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
                '会員登録',
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
              SizedBox(
                height: 50.0,
              ),
              Text('$errorMessage'),
              FlatButton(
                child: Text('登録'),
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
                      ProfileRegistrationScreen(mail, password),
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
