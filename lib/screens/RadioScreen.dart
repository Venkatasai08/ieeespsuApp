import 'package:flutter/material.dart';
import 'package:ieeespsu/screens/Loading.dart';
import 'package:page_transition/page_transition.dart';


class RadioScreen extends StatefulWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Radio"),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 100,
                child: Card(
                  child: ListTile(
                    onTap: () {
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => const Center(
                      //           child: SizedBox(
                      //             child: CircularProgressIndicator(),
                      //             height: 40,
                      //             width: 40,
                      //           ),
                      //         ));
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const Loading(),
                          type: PageTransitionType.fade,
                          childCurrent: widget,
                          duration: const Duration(milliseconds: 600),
                          reverseDuration: const Duration(milliseconds: 600),
                        ),
                      );
                      // navigatorKey.currentState!
                      //     .popUntil((route) => route.isFirst);
                    },
                    leading: CircleAvatar(
                      child: SizedBox(
                        child: Image.asset("assets/images/ieee.png"),
                        height: 30,
                        width: 30,
                      ),
                    ),
                    title: const Text("Zeno fm"),
                  ),
                ),
              );
            },
          )),
    );
  }
}
