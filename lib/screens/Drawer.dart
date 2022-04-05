import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieeespsu/screens/FacultyScreen.dart';
import 'package:ieeespsu/screens/About.dart';
import 'package:ieeespsu/screens/StudentScreen.dart';
import 'package:ieeespsu/screens/profile.dart';

import 'Events.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  var username = '';
  final firebaseUser = FirebaseAuth.instance.currentUser;
  _fetch() async {
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser!.uid)
          .get()
          .then((ds) {
        username = ds.data()!['username'];
        print(username);
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: Colors.lightBlue[50],
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Stack(alignment: Alignment.center, children: [
                Opacity(
                  opacity: 1,
                  child: ClipPath(
                    clipper: Clipper(),
                    child: Container(
                      // color: Colors.cyan,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.greenAccent,
                            Colors.cyan,
                            Colors.cyan
                          ])),
                      height: 250,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 15),
                    const CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: _fetch(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Text(
                                "Loading . . . ",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[900]),
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    firebaseUser!.displayName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[700]),
                                  ),
                                  Text(
                                    "Student",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[700]),
                                  ),
                                ],
                              );
                            }
                          }),
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Hello avneet",
                    //       style: TextStyle(
                    //           fontSize: 22,
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.grey[700]),
                    //     ),
                    //     Text(
                    //       "Student",
                    //       style: TextStyle(
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.normal,
                    //           color: Colors.grey[700]),
                    //     ),
                    //   ],
                    // ),
                  ],
                )
              ]),
              Container(
                padding: const EdgeInsets.only(top: 15, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const About(),
                          ),
                        );
                      },
                      child: const Text(
                        "About",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FacultyScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Faculty Committee",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StudentScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Student Committee",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SeeBlogsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Events",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "My Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProfilePage()));
                      },
                      child: const Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Gallery Media",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Contact Us",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text(
                    //     "Contact Us",
                    //     style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.normal,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Divider(thickness: 2, color: Colors.lightBlue[200]),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.facebookF,
                      size: 40,
                      color: Colors.lightBlue[200],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      size: 40,
                      color: Colors.lightBlue[200],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                      size: 40,
                      color: Colors.lightBlue[200],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.youtube,
                      size: 40,
                      color: Colors.lightBlue[200],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "All rights reserved to MIKHVISION DIGI LLP.",
                style: TextStyle(fontSize: 10, color: Colors.lightBlue[300]),
              ),
              Text(
                "All rights reserved to IEEE SB SPSU.",
                style: TextStyle(fontSize: 10, color: Colors.lightBlue[300]),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "www.spsu.ac.in",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Text(
                    "www.ieee.org",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 3, size.height - 100, size.width / 1.001, size.height);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}
