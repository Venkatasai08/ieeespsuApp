import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieeespsu/screens/UpdateScreenforteacher.dart';

class FacultyScreen extends StatefulWidget {
  const FacultyScreen({Key? key}) : super(key: key);

  @override
  State<FacultyScreen> createState() => _FacultyScreenState();
}

class _FacultyScreenState extends State<FacultyScreen> {
  bool? isAdmin = false;
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
    // TODO: implement initState
    super.initState();
    _fetchadmin();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Faculty members"),
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const UpdateScreenforteacher()),
                    ),
                  ),
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
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "ChairPerson & SMIEE $i",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
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
