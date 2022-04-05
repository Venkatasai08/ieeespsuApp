import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ieeespsu/screens/Drawer.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String aboutIEEE =
      "IEEE,or the Indtitude of Electrical and Electronic Engineers,is an organization composed of engineers that issues and manages Standards for electronic and electrical devices. This includes networking devices, network interfaces ,cabling and connectors ";
  String aboutSPSU =
      "IEEE id the worlds largest technical professional organization that is working constantly towards the advancements of technology and to promote research ,mostly in the feilds of engineering with a special emphasis on helping the society .We are the student About of 'SIR PADAMPAT SINGHANAYA UNIVERSITY ' university";
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: const DrawerScreen(),
      appBar: AppBar(
        leading: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 27,
                child: Icon(
                  Icons.person_add,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
        title: const Text(""),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ClipPath(
            clipper: Clipper(),
            child: Container(
              height: 300,
              color: Colors.cyan,
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    "IEEE SPSU Student About",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    width: 270,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.black,
                      elevation: 20,
                      // shadowColor: Colors.white,

                      child: Carousel(
                        borderRadius: true,
                        boxFit: BoxFit.cover,
                        showIndicator: true,
                        autoplay: false,
                        overlayShadowSize: 0.5,
                        overlayShadow: false,
                        dotSize: 5,
                        dotIncreaseSize: 2,
                        indicatorBgPadding: 2,
                        images: [
                          Image.network(
                              "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&w=1000&q=80"),
                          Image.asset("assets/carrot.jpg"),
                          Image.asset("assets/BloodPoolLogo.png"),
                          Image.asset("assets/nativebg.jpg"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "About IEEE",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  aboutIEEE,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("About SPSU",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 150,
                    width: 300,
                    child: Image.network(
                      "https://images.unsplash.com/photo-1494500764479-0c8f2919a3d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&w=1000&q=80",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  aboutSPSU,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    Path path = Path();
    path.lineTo(0, h - 100);
    path.quadraticBezierTo(w / 2, h, w, h - 100);

    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}
