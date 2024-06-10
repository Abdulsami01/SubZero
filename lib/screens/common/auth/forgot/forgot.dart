import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login_screen.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({Key? key}) : super(key: key);

  @override
  _ForgotpassState createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  // bool showProgress = false;
  bool visible = false;
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    "Don't Worry ...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your email',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        borderRadius: new BorderRadius.circular(20),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        borderRadius: new BorderRadius.circular(20),
                      ),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.length == 0) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please enter a valid email");
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      // emailController.text = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 40,
                        onPressed: () {
                          Forgotpassss(emailController.text);
                          setState(() {
                            visible = true;
                          });
                        },
                        child: Text(
                          "Retrieve my password",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.redAccent,
                      ),
                      // Padding(
                      //     padding: EdgeInsets.symmetric(
                      //         vertical:
                      //             MediaQuery.sizeOf(context).height * 0.05)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: visible,
                      child: Container(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void Forgotpassss(String email) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .sendPasswordResetEmail(email: email)
          .then((uid) => {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()))
              })
          .catchError((e) {});
    }
  }
}
