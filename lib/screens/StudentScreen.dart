import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'UpdateScreenforStudent.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  var isAdmin = false;
  _fetchadmin() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        isAdmin = ds.data()!['isAdmin'];
        setState(() {
          isAdmin = isAdmin;
        });
        print(isAdmin);
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  void initState() {
    _fetchadmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Student members"),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.cyan,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          isAdmin == true
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) =>
                              const UpdatescreenforStudent()),
                        ));
                  },
                  child: Container(
                    width: 50,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.cyan),
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container()
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/image.png",
              fit: BoxFit.cover,
              height: height,
              width: width,
              color: Colors.black45,
              colorBlendMode: BlendMode.darken,
            ),
          ),
          SingleChildScrollView(
            child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(5),
                child: Wrap(spacing: 5, runSpacing: 10, children: [
                  for (var i = 0; i < 5; i++)
                    Stack(
                      children: [
                        Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width / 2.2,
                          color: Colors.transparent,
                        ),
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                            height: 140,
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Card(
                              color: i.isEven
                                  ? Colors.cyan
                                  : const Color.fromARGB(195, 3, 241, 241),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(10),
                              //   color: Colors.blue,
                              // ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 3,
                          left: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Dr.Mukesh kalla",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "ChairPerson & SMIEE $i",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: SizedBox(
                            width: 80,
                            height: 100,
                            // color: Colors.black,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                "https://www.architectureartdesigns.com/wp-content/uploads/2013/04/tumblr_m7oynl386H1qa7gx5o1_500.jpg",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ])),
          ),
        ],
      ),
    );
  }
}
