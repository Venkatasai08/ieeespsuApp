import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ieeespsu/main.dart';
import 'package:provider/provider.dart';

import '../services/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  final _isAdmin = false;

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      String uid = authResult.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'uid': uid,
        "isAdmin": _isAdmin
      });
    } catch (err) {
      print(err);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // final bool _isloggedin = false;
  late GoogleSignInAccount _userobj;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 400,
        width: 400,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.white,
              ],
              stops: [0.1, 1],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: const ValueKey('username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Add username";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.person_add_outlined),
                    hintText: "Username",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Incorrect Email.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Email",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Incorrect Password.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final validity = _formkey.currentState!.validate();

                      if (validity) {
                        _formkey.currentState!.save();

                        submitform(_email, _password, _username);
                      }
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const AccCreated()));
                    });
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(child: Text("OR")),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text(
                    "Google",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 2),
              const Text("Already have an account?"),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
