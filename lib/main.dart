import 'package:flutter/material.dart';
import 'package:memowtask14userauth/screens/login_screen.dart';
import 'package:memowtask14userauth/screens/auth_select_screen.dart';
import 'package:memowtask14userauth/screens/login_select_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン / 会員登録'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(10.0),
              child: Text('ログイン'),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginSelectScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(10.0),
              child: Text('会員登録'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AuthSelectScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
