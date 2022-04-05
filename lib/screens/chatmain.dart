// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ieeespsu/helper/sharedprefhelper.dart';
import 'package:ieeespsu/screens/chatscreen.dart';
import 'package:ieeespsu/services/database.dart';

class ChatMain extends StatefulWidget {
  const ChatMain({Key? key}) : super(key: key);

  @override
  State<ChatMain> createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> {
  bool isSearching = false;
  TextEditingController searchUsername = TextEditingController();
  Stream? usersStream, chatRoomsStream;
  String myUserName = "", myEmail = "";

  getMyInfoFromSharedPreference() async {
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = (await SharedPreferenceHelper().getUserEmail())!;
    // print("hello1");
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream =
        await DatabaseMethods().getUserByUserName(searchUsername.text);

    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Text(
                      ds.id.replaceAll(myUserName, "").replaceAll("_", ""));
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget searchUsersList() {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return searchUserListTile(ds["username"], ds["email"]);
                },
              )
            : CircularProgressIndicator();
      },
    );
  }

  Widget searchUserListTile(String username, email) {
    return GestureDetector(
      onTap: () {
        //checking if chat room exists or not.
        print("this is usernames ${myUserName} and ${username}");
        var chatRoomId = getChatRoomIdByUsernames(myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        // navigating to the chat screen.
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ChatScreen(name: username, email: email);
        }));
      },
      child: Row(
        children: [
          Container(
            child: Icon(
              Icons.person,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(username), Text(email)],
          )
        ],
      ),
    );
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chats",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  isSearching
                      ? Padding(
                          padding: EdgeInsets.all(8),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchUsername.text = "";
                                  isSearching = false;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_back,
                              )),
                        )
                      : Container(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchUsername,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username"),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (searchUsername.text != "") {
                                onSearchBtnClick();
                              }
                            },
                            icon: Icon(Icons.search),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "To chat search the username you want to chat with :",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              isSearching ? searchUsersList() : chatRoomsList()
            ],
          ),
        ),
      ),
    );
  }
}
