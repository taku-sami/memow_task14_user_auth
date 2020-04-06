import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memowtask14userauth/screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String mail;
  String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('registration screen'),
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
              Text('$error'),
              FlatButton(
                child: Text('登録'),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: mail, password: password);
                    print('$newUserです');
                    if (newUser != null) {
                      setState(() {
                        error = 'このメールアドレスは既に登録されています';
                        print('here');
                      });
                    } else {
                      setState(() {
                        print('testtest');
                        error = '';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ),
                      );
                    }
                  } catch (e) {
                    print(e);
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
