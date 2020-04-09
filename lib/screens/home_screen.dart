import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memowtask14userauth/main.dart';
import 'add_caw.dart';

final _firestore = Firestore.instance;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseUser loggedInUser;

  final _auth = FirebaseAuth.instance;
  String userName;
  String userFirstName;
  String userLastName;
  String userId;
  String mail;
  String farmId;
  String farmName;
  String farmAddress;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        userId = loggedInUser.uid;
        userName = loggedInUser.displayName;
        mail = loggedInUser.email;

        DocumentSnapshot userData =
            await _firestore.collection("users").document(userId).get();
        setState(() {
          userFirstName = userData['firstName'].toString();
          userLastName = userData['lastName'].toString();
          farmId = userData['farmID'].toString();
        });
        DocumentSnapshot farmData =
            await _firestore.collection("farms").document(farmId).get();

        setState(() {
          farmName = farmData['name'].toString();
          farmAddress = farmData['address'].toString();
        });
        print(farmId);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム画面'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            '牧場名:$farmName',
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            'FarmID:$farmId',
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            '牧場名:$farmAddress',
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            '氏名:$userName',
            style: TextStyle(fontSize: 20.0),
          ),
          Text(
            'メール:$mail',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 40.0,
          ),
          FlatButton(
            color: Colors.green,
            textColor: Colors.white,
            child: Text('牛の登録'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddCawScreen(farmId);
                  },
                ),
              );
            },
          ),
          FlatButton(
            color: Colors.red,
            textColor: Colors.white,
            child: Text('ログアウト'),
            onPressed: () {
              _auth.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  new MaterialPageRoute(builder: (context) => new MyApp()),
                  (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
