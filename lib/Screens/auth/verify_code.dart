import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/Screens/HomeScreen.dart';
import 'package:practice/utils/utilities.dart';

import '../../widgets/RoundButton.dart';

class verifyCode extends StatefulWidget {
  final String verificationID;
  const verifyCode({super.key, required this.verificationID});

  @override
  State<verifyCode> createState() => _verifyCodeState();
}

class _verifyCodeState extends State<verifyCode> {
  @override
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                          controller: _codeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: '6 Digit', prefixIcon: Icon(Icons.key)),
                          validator: (value) {
                            if (value!.isEmpty) return "Enter code";
                            return null;
                          },
                        ),
                      ),
                    ],
                  )),
              RoundButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationID,
                    smsCode: _codeController.text.toString(),
                  );
                  try{
                    await _auth.signInWithCredential(credential);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    setState(() {
                    loading = false;
                    });
                  } catch (error) {
                    utils().toastmessage(error.toString());
                    setState(() {
                    loading = false;
                  });
                  }
                },
                loading: loading,
                title: "Verify",
              ),
            ],
          ),
        ));
  }
}
