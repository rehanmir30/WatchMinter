import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Models/UserModel.dart';
import 'package:watchminter/Screens/Home/MessageScreen.dart';

import '../../ChatScreens/CreateNewMessage.dart';

class Chat extends StatefulWidget {
  UserModel userModel;

  Chat(this.userModel, {Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.white),
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(color: AppColors.orange),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Messages",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Gotham"),
                          ).marginOnly(top: 30, left: 12)),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 30,
                          shrinkWrap: false,
                          padding: EdgeInsets.only(top: 0),
                          itemBuilder: (BuildContext context, int index) {
                            return ChatTile(index, widget.userModel);
                          }),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(CreateNewMessage());
          },
          label: Row(children: [
            Text("Create new message"),
            Icon(
              Icons.send,
              color: Colors.white,
            ).marginOnly(left: 5),
          ]),
          backgroundColor: AppColors.orange,
        ));
  }
}

class ChatTile extends StatefulWidget {
  final int index;
  UserModel userModel;

  ChatTile(this.index, this.userModel, {Key? key}) : super(key: key);

  @override
  State<ChatTile> createState() => _ChatTileState();
}

@override
void initState() {}

class _ChatTileState extends State<ChatTile> {
  bool isEven = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(MessageScreen(widget.userModel), transition: Transition.zoom);
      },
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  radius: 30, // Image radius
                  backgroundColor: isEven ? AppColors.orange : Colors.white,
                  backgroundImage: AssetImage("assets/images/watch.png"),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Doe",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.background,
                        fontFamily: "Gotham"),
                  ),
                  Text(
                    "Here is what i want to ...",
                    style: TextStyle(
                        color: AppColors.background, fontFamily: "Gotham"),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "12:00 PM",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ).marginOnly(left: 12, right: 12, top: 12),
    );
  }

  @override
  void initState() {
    if (widget.index.isEven) {
      setState(() {
        isEven = true;
      });
    } else {
      setState(() {
        isEven = false;
      });
    }
  }
}
