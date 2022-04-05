import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieeespsu/helper/sharedprefhelper.dart';
import 'package:ieeespsu/main.dart';
import 'package:ieeespsu/screens/forgetpassword.dart';
import 'package:ieeespsu/screens/signup.dart';
import 'package:provider/provider.dart';

import '../services/provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  bool checkVal = true;

  submitform(String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      authResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      SharedPreferenceHelper().saveUserEmail(authResult.user!.email!);
      SharedPreferenceHelper().saveUserId(authResult.user!.uid);
      SharedPreferenceHelper()
          .saveUserName(authResult.user!.email!.replaceAll("@gmail.com", ""));
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect Email and Password')));
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
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
                height: 30,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: checkVal,
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
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: checkVal
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.password),
                      onPressed: () {
                        setState(() {
                          checkVal = !checkVal;
                        });
                      },
                    ),
                    hintText: "Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPassword()));
                      },
                      child: const Text(
                        "Forget password?",
                      )),
                ],
              ),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    final validitity = _formkey.currentState!.validate();

                    if (validitity) {
                      _formkey.currentState!.save();
                      submitform(_email, _password);
                    }
                  },
                  child: const Text(
                    "LOGIN",
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
              const Text("OR"),
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
              const SizedBox(
                height: 90,
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              const Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.cyan),
              ),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SingUp()));
                  },
                  child: const Text(
                    "Sign Up",
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
