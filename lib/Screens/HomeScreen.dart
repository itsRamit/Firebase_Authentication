import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/Screens/auth/SignupScreen.dart';
import 'package:practice/utils/utilities.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _auth.signOut().then((value) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }).onError((error, stackTrace) {
                utils().toastmessage("Logout Successfully!");
              });
            },
            child: Text("Logout")),
      ),
    );
  }
}
