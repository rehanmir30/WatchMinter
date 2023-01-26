import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Global/firebase_ref.dart';
import 'package:watchminter/Models/UserModel.dart';
import 'package:watchminter/Screens/ViewProfile.dart';

import '../../ExternalWidgets/MessageCard.dart';
import '../../Models/message.dart';

class MessageScreen extends StatefulWidget {
  UserModel receiverModel;
  UserModel senderModel;

  MessageScreen(this.senderModel, this.receiverModel, {Key? key})
      : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ScrollController controller = ScrollController();
  var _list =[];
  final TextEditingController message = new TextEditingController();

  _scrollListener() {
    // controller.jumpTo(controller.position.maxScrollExtent);
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print('bottom');
    }
    if (controller.offset <= controller.position.minScrollExtent &&
        !controller.position.outOfRange) {
      print('top');
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        //If emoji are shown and back button is been pressed hide does emoji's
        onWillPop: () {
            return Future.value(true);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.orange,
            toolbarHeight: 68,
            // flexibleSpace: _appBar(),
            title: InkWell(
                onTap:(){
                  Get.to(ViewProfile(widget.receiverModel),
                      transition: Transition.zoom);
                } ,
                child: Text(widget.receiverModel.name)),
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream:chatsRef
                      .where("receiverId", isEqualTo: widget.receiverModel.id)
                      .orderBy("time",descending: true)
                      .snapshots(),
                  builder: (context,AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                    //if is data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(child: SizedBox());
                    //if data is loaded
                      case ConnectionState.active:
                      case ConnectionState.done:
                        _list.clear();
                        final data = snapshot.data?.docs;
                        _list = data
                            ?.map((e) => Message.fromJson(e.data()))
                            .toList() ??
                            [];
                        if (_list.isNotEmpty) {
                          return ListView.builder(
                               reverse: true,
                              itemCount: _list.length,
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
                              itemBuilder: (context, index) {
                                return MessageCard(
                                  message: _list[index],
                                );
                              });
                        } else {
                          return Center(
                            child: Text(
                              "Say! Hii 😀👋",
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }
                    }
                  },
                ),
              ),
              //Image is Uploading
              _ChatInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ChatInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: AppColors.orange,
              elevation: 10,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                controller: message,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  hintText: 'Message',
                  enabled: true,
                  contentPadding: const EdgeInsets.only(
                      left: 14.0,
                      bottom: 8.0,
                      top: 8.0,
                      right: 14.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.orange),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.orange),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.orange),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.orange),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  return null;
                },
                onSaved: (value) {
                  //message.text = value!;
                },
              ),
            ).marginOnly(left: 14.0, top: 0, right: 14.0),
          ),
          IconButton(
            onPressed: () async{
              if(message.text.isEmpty){
                Get.snackbar("Error", "Message field is empty",
                    colorText: AppColors.white,
                    icon: Icon(Icons.error_outline, color: Colors.white),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: AppColors.orange);
              }else{
                await chatsRef.doc().set({
                  'message': message.text.toString(),
                  'time': DateTime.now().millisecondsSinceEpoch,
                  'senderId': widget.senderModel.id,
                  'receiverId': widget.receiverModel.id,
                  'username': widget.senderModel.name
                });
                message.clear();
              }

            },
            icon: const Icon(
              Icons.send_sharp,
              color: AppColors.orange,
            ),
          ),
        ],
      ).marginOnly(bottom: 30),
    );
  }
}
class MessageTile extends StatefulWidget {
  const MessageTile({Key? key}) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    child: Image.asset("assets/images/watch.png",
                        fit: BoxFit.fill),
                    radius: 20,
                    backgroundColor: Colors.orange,
                  )),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      "Hi saw your rolex submariner just posted. Would you consider selling",
                      style: TextStyle(
                          color: AppColors.background,
                          fontSize: 18,
                          fontFamily: "Gotham"),
                    ).marginOnly(left: 8, right: 18, top: 18),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "12:00 PM",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: "Gotham"),
                      ).marginOnly(right: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        )).marginOnly(top: 12, left: 20, right: 20);
  }
}
