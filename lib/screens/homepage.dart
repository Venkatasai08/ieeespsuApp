import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ieeespsu/screens/Drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchItem = '';
  final imgList = [
    Image.asset("assets/images/image1.jpg"),
    Image.asset("assets/images/image2.jpg"),
    Image.asset("assets/images/ajay.png"),
  ];
  final imgList1 = [
    const Text("image1"),
    const Text("image2"),
    const Text("image3"),
  ];

  //------fetch data method for username
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hello there . . .",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 23,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
          ),
          backgroundColor: Colors.cyan,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            // padding: EdgeInsets.all(10),

            color: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  top: -250,
                  child: CircleAvatar(
                    backgroundColor: Colors.cyan,
                    radius: 210,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                      ),
                      padding: const EdgeInsets.all(10),
                      height: 60,
                      child: TextFormField(
                        key: const ValueKey('blog'),
                        onSaved: (value) {
                          _searchItem = value!;
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          suffixIcon:
                              const Icon(Icons.add_box, color: Colors.black),
                          filled: true,
                          hintStyle: const TextStyle(color: Colors.black),
                          hintText: "Post your blog",
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40),
                      child: const Text(
                        "Upcoming Events",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 400,
                      child: CarouselSlider(
                          items: imgList
                              .map((item) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      // child: Text("${item}",
                                      // style: TextStyle(
                                      //   color: Colors.white,
                                      // ),
                                      // ),
                                      child: ClipRRect(
                                        child: item,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      // padding: const EdgeInsets.only(
                      //   left: 35,
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "Trending Blogs",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Discover>",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                    SizedBox(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return TrendingBLog(index: index);
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Event Alert",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Discover>",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return EventAlerts(
                            index: index,
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Podcasts",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Discover>",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return Podcasts(
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        endDrawer: const DrawerScreen());
  }
}

//CLIPPER class for the wave design

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

class TrendingBLog extends StatefulWidget {
  int index;
  TrendingBLog({Key? key, required this.index}) : super(key: key);

  @override
  State<TrendingBLog> createState() => _TrendingBLogState();
}

class _TrendingBLogState extends State<TrendingBLog> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
          child: Stack(children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://content.instructables.com/ORIG/FG6/NSYJ/IM5WPGD9/FG6NSYJIM5WPGD9.png?auto=webp&frame=1&width=320&md=1981a6e18e4a6c27d6bb905208d8f911",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: SizedBox(
                height: 25,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "new",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        Text(
                          "What is Python?",
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                        Text(
                          "Dr.Anand Kumar",
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: const [
                              Icon(
                                FontAwesomeIcons.thumbsUp,
                                color: Colors.black,
                                size: 16,
                              ),
                              Text(
                                "Like",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                          Column(
                            children: const [
                              Icon(
                                FontAwesomeIcons.facebookMessenger,
                                color: Colors.black,
                                size: 16,
                              ),
                              Text(
                                "Message",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }
}

class EventAlerts extends StatefulWidget {
  final index;
  const EventAlerts({Key? key, this.index}) : super(key: key);

  @override
  State<EventAlerts> createState() => _EventAlertsState();
}

class _EventAlertsState extends State<EventAlerts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: widget.index % 2 != 0
            ? const Color.fromARGB(255, 213, 233, 250)
            : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 3,
              height: 80,
              color: Colors.cyan,
            ),
            // const SizedBox(width: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Workshop",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Topic :Data Science and its real-time Application",
                      style: TextStyle(fontSize: 13, color: Colors.blue),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Date:20/01/2000",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        Text(
                          "Time:01:11 pm",
                          style: TextStyle(fontSize: 13, color: Colors.blue),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Podcasts extends StatefulWidget {
  final index;
  const Podcasts({Key? key, this.index}) : super(key: key);

  @override
  State<Podcasts> createState() => _PodcastsState();
}

class _PodcastsState extends State<Podcasts> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
          child: Stack(children: [
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.index % 2 == 0 ? Colors.orange : Colors.pink,
              ),
            ),
            Positioned(
              top: 15,
              right: 0,
              child: SizedBox(
                height: 25,
                width: 60,
                child: GestureDetector(
                  onTap: () {
                    print("${widget.index}");
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: SizedBox(
                height: 25,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "new",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: 180,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: const [
                        FittedBox(
                          child: Text(
                            "What is Python?",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            "Dr.Anand Kumar",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(
                          FontAwesomeIcons.thumbsUp,
                          color: Colors.black,
                          size: 16,
                        ),
                        Text(
                          "Like",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
