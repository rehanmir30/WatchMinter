import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Global/firebase_ref.dart';
import 'package:watchminter/Models/UserModel.dart';
import 'package:watchminter/Screens/ViewProfile.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: AppColors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(color: AppColors.orange),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        Get.to(ViewProfile(widget.receiverModel),
                            transition: Transition.zoom);
                      },
                      child: Text(
                        widget.receiverModel.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Gotham"),
                      ).marginOnly(top: 30, left: 12),
                    )),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: chatsRef
                      .where("receiverId", isEqualTo: widget.receiverModel.id)
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Text("Something is wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      controller: controller,
                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                      physics: const ScrollPhysics(),
                      primary: false,
                      itemBuilder: (_, index) {
                        QueryDocumentSnapshot qs = snapshot.data!.docs[index];
                        Timestamp t = qs['time'];
                        DateTime d = t.toDate();
                        String hour = d.hour.toString();
                        String mint = d.minute.toString();
                        String date =
                            d.day.toString() + "/" + d.month.toString();
                        if (hour.length == 1) hour = "0" + hour;
                        if (mint.length == 1) mint = "0" + mint;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Align(
                            child: SizedBox(
                              width: 300,
                              child: Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  // side: const BorderSide(color: Colors.purple),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: const Radius.circular(10),
                                    bottomRight: const Radius.circular(10),
                                  ),
                                ),
                                child: ListTile(
                                  title: Text(
                                    qs["username"],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          qs['message'],
                                          softWrap: true,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        child: Column(
                                          children: [
                                            Text(hour + ":" + mint),
                                            Text(date),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            controller: message,
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
                              'time': DateTime.now(),
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
                ),
              ),
            ],
          )
        ],
      ),
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
