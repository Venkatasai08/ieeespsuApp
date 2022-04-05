import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieeespsu/screens/Drawer.dart';
import 'package:image_picker/image_picker.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController referencecontroller = TextEditingController();

  File? image1;
  var imagepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Container(
            width: 100,
            height: 10,
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Post"),
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.white),
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.bars,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              _textField(titlecontroller, 1),
              const Text(
                "Description:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              _textField(descriptioncontroller, 10),
              GestureDetector(
                onTap: () {
                  void pickimg() async {
                    try {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image1 =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image1 == null) return;
                      imagepath = image1.path;
                      final imagetemparory = File(imagepath);

                      setState(() {
                        this.image1 = imagetemparory;
                      });
                    } on PlatformException {
                      print("object");
                    }
                  }

                  pickimg();
                },
                child: SizedBox(
                  height: 60,
                  width: 130,
                  child: Card(
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Upload",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          FontAwesomeIcons.camera,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  height: 200,
                  width: 240,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      border: Border.all(width: 2)),
                  child: Stack(
                    children: [
                      image1 != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image1!,
                                width: 240,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
                      image1 == null
                          ? Positioned(
                              bottom: 0,
                              child: Container(
                                height: 20,
                                width: 240,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue),
                                child: const Center(
                                  child: Text("Image preview will appear here",
                                      style: TextStyle(
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Reference:",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              _textField(referencecontroller, 1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(var name, final lines) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: name,
        readOnly: false,
        maxLines: lines,
        style: const TextStyle(
          fontSize: 15,
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.black),
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
