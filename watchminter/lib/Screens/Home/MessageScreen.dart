import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Models/UserModel.dart';
import 'package:watchminter/Screens/ViewProfile.dart';

class MessageScreen extends StatefulWidget {
  UserModel userModel;
   MessageScreen(this.userModel,{Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
     // backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white
            //     image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: new AssetImage("assets/images/blacknwhite_bg.jpg"),
            // )
            ),
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
                      onTap: (){
                        Get.to(ViewProfile(widget.userModel),transition: Transition.zoom);
                      },
                      child: Text(
                        "John Doe",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "Gotham"),
                      ).marginOnly(top: 30, left: 12),
                    )),
              ),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),

                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: CircleAvatar(child: Image.asset("assets/images/watch.png",fit: BoxFit.fill),radius: 20,backgroundColor: Colors.orange,)),
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
                )
              ).marginOnly(top: 12, left: 20, right: 20),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                          child: CircleAvatar(child: Image.asset("assets/images/watch.png",fit: BoxFit.fill),radius: 20,backgroundColor: Colors.orange,)),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Text(
                              "Might do, do you want to make an offer",
                              style: TextStyle(
                                  color: AppColors.background,
                                  fontSize: 18,
                                  fontFamily: "Gotham"),
                            ).marginOnly(left: 8, right: 18, top: 18),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "12:01 PM",
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
                )
              ).marginOnly(top: 12, left: 20, right: 20),
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
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.white,
                              hintText: 'message',
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0, right: 14.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.orange),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.orange),
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
                        ).marginOnly(left: 14.0, top:0, right: 14.0),
                      ),
                      IconButton(
                        onPressed: () {},
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
