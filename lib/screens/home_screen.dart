import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          height: 50,
          child: RaisedButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            color: Colors.pinkAccent,
            child: Text("Sair"),
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
