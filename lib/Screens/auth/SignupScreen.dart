import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/Screens/auth/LoginScreen.dart';
import 'package:practice/utils/utilities.dart';

import '../../widgets/RoundButton.dart';
import '../HomeScreen.dart';
import 'LoginUsingNum.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void SignIn() {
    if (_formkey.currentState!.validate()) {
      _auth
          .createUserWithEmailAndPassword(
              email: _emailController.text.toString(),
              password: _passController.text.toString())
          .then((value) {
        setState(() {
          loading = false;
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
        utils().toastmessage("Successfully signed up!");
      }).onError((error, stackTrace) {
        utils().toastmessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
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
                          controller: _emailController,
                          decoration: const InputDecoration(
                              hintText: 'Enter Email',
                              prefixIcon: Icon(Icons.email_outlined)),
                          validator: (value) {
                            if (value!.isEmpty) return "Email Required";
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          controller: _passController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'Enter Password',
                              prefixIcon: Icon(Icons.key)),
                          validator: (value) {
                            if (value!.isEmpty) return "Password Required";
                            return null;
                          },
                        ),
                      ),
                    ],
                  )),
              RoundButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  SignIn();
                },
                loading: loading,
                title: "Sign up",
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
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                  title: 'Login with Phone',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NumSignupScreen()));
                  })
            ],
          ),
        ));
  }
}
