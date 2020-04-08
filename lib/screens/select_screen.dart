import 'package:flutter/material.dart';
import 'farm_registration_screen.dart';
import 'invited_screen.dart';

class SelectScreen extends StatelessWidget {
  String mail;
  String password;
  String firstName;
  String lastName;
  SelectScreen(this.mail, this.password, this.firstName, this.lastName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('選択画面'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('牧場を登録する'),
                onPressed: () {
                  _pushPage(
                    context,
                    FarmRegistrationScreen(mail, password, firstName, lastName),
                  );
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('招待された'),
                onPressed: () {
                  _pushPage(
                    context,
                    InvitedScreen(mail, password, firstName, lastName),
                  );
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
