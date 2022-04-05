import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieeespsu/forms/signupform.dart';
import 'package:ieeespsu/screens/home.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomeScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      // overflow: Overflow.visible,
                      clipBehavior: Clip.none,
                      children: [
                        Opacity(
                          opacity: 1,
                          child: ClipPath(
                            clipper: Clipper(),
                            child: Container(
                              color: Colors.cyan,
                              height: 320,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 450,
                          left: 105,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.cyan[600],
                            child: CircleAvatar(
                              radius: 95,
                              backgroundColor: Colors.white,
                              //backgroundImage:  AssetImage("assets/images/logo.png"),
                              child: SizedBox(
                                height: 100,
                                width: 160,
                                child: Image.asset(
                                  "assets/images/logo.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SignUpForm()
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

//CLIPPER class for the wave design

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 3, size.height - 170, size.width / 1.001, size.height);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}
