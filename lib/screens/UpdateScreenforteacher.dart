import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieeespsu/screens/Drawer.dart';
import 'package:image_picker/image_picker.dart';

class UpdateScreenforteacher extends StatefulWidget {
  const UpdateScreenforteacher({Key? key}) : super(key: key);

  @override
  State<UpdateScreenforteacher> createState() => _UpdateScreenforteacherState();
}

class _UpdateScreenforteacherState extends State<UpdateScreenforteacher> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController displaynamecontroller = TextEditingController();
  TextEditingController designationcontroller = TextEditingController();
  @override
  void dispose() {
    namecontroller.dispose();
    displaynamecontroller.dispose();
    designationcontroller.dispose();
    super.dispose();
  }

  File? image;
  var imagepath;
  Widget _textField(var name, final lines, String validationtext) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationtext;
          }
          return null;
        },
        controller: name,
        readOnly: false,
        maxLines: lines,
        style: const TextStyle(
          fontSize: 15,
        ),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          counter: const Offstage(),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.red),
              borderRadius: BorderRadius.circular(5)),
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerScreen(),
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Add Faculty"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openEndDrawer();
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
                FontAwesomeIcons.bars,
                size: 20,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey[200],
                        ),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  image!,
                                  width: 240,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 100,
                              )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          void pickimg() async {
                            try {
                              final ImagePicker _picker = ImagePicker();
                              final XFile? image1 = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image1 == null) return;
                              imagepath = image1.path;
                              final imagetemparory = File(imagepath);

                              setState(() {
                                image = imagetemparory;
                              });
                            } on PlatformException {
                              print("object");
                            }
                          }

                          pickimg();
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.blueAccent,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.photoVideo,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Full Name:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                _textField(namecontroller, 1, "Enter Full Name"),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Display Name:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                _textField(displaynamecontroller, 1, "Enter Display Name"),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Designation:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                _textField(designationcontroller, 1, "Enter Designation"),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
