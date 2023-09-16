import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/Screens/auth/LoginScreen.dart';
import 'package:practice/Screens/auth/verify_code.dart';
import 'package:practice/utils/utilities.dart';

import '../../widgets/RoundButton.dart';
import '../HomeScreen.dart';

class NumSignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NumSignupScreenState();
}

class NumSignupScreenState extends State<NumSignupScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final _phoneNumController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void NumLogin() {
    if (_formkey.currentState!.validate()) {
      _auth.verifyPhoneNumber(
          phoneNumber: "+1" + _phoneNumController.text,
          verificationCompleted: (_) {},
          verificationFailed: (error) {
            setState(() {
              loading = false;
            });
            utils().toastmessage(error.toString());
          },
          codeSent: (String VerificationID, int? token) {
            setState(() {
              loading = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        verifyCode(verificationID: VerificationID)));
          },
          codeAutoRetrievalTimeout: (error) {
            setState(() {
              loading = false;
            });
            utils().toastmessage(error.toString());
          });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.purple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          controller: _phoneNumController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: '234 567 2142',
                              prefixIcon: Icon(Icons.phone)),
                          validator: (value) {
                            if (value!.isEmpty) return "Phone number Required";
                            return null;
                          },
                        ),
                      ),
                    ],
                  )),
              RoundButton(
                onPressed: () {
                  NumLogin();
                  setState(() {
                    loading = true;
                  });
                },
                loading: loading,
                title: "Sign in",
              ),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Text('Already have an account?'),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.purple),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
