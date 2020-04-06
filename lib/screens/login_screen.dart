import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Text(
                'ログイン',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Mail',
                ),
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              FlatButton(
                child: Text('ログイン'),
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
