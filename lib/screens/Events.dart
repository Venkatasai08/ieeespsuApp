// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ieeespsu/screens/Blog%20screen.dart';

class SeeBlogsScreen extends StatefulWidget {
  const SeeBlogsScreen({Key? key}) : super(key: key);

  @override
  State<SeeBlogsScreen> createState() => _SeeBlogsScreenState();
}

class _SeeBlogsScreenState extends State<SeeBlogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Blogs"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const BlogScreen())));
            },
            child: Container(
              width: 40,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.cyan,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const ClipOval(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Image(
                                image: AssetImage(
                                  "assets/images/Hulk.jpg",
                                ),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(msg: "$index");
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
                      title: const Text("Harsh Sahu",
                          style: TextStyle(fontSize: 15)),
                      subtitle: const Text(
                        "3 min read",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text('Facts about "Inteligent Internet of Things"',
                          style: TextStyle(fontSize: 22)),
                    ),
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(width: 1)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Image(
                                      image: AssetImage(
                                        "assets/images/ajay.png",
                                      ),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue),
                              child: const Center(
                                child: Text("data",
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
