import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';

import '../../Models/UserModel.dart';

class UpdateProfileScreen extends StatefulWidget {
   UserModel userModel;
   UpdateProfileScreen(this.userModel,{Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
 // final formKey = GlobalKey<FormState>();
  var focusNodeEmail=FocusNode();
  var focusNodeName=FocusNode();
  var focusNodePassword=FocusNode();
  var focusNodeDob=FocusNode();
  var email_elevation=0.0;
  var name_elevation=0.0;
  var password_elevation=0.0;
  var dob_elevation=0.0;

  @override
  void initState() {
    focusNodeEmail.addListener(() {
      if (focusNodeEmail.hasFocus) {
        setState(() {
          email_elevation=10; //Check your conditions on text variable
        });
      }else{
        setState(() {
          email_elevation=0; //Check your conditions on text variable
        });
      }
    });
    focusNodeName.addListener(() {
      if (focusNodeName.hasFocus) {
        setState(() {
          name_elevation=10; //Check your conditions on text variable
        });
      }else{
        setState(() {
          name_elevation=0; //Check your conditions on text variable
        });
      }
    });
    focusNodePassword.addListener(() {
      if (focusNodePassword.hasFocus) {
        setState(() {
          password_elevation=10; //Check your conditions on text variable
        });
      }else{
        setState(() {
          password_elevation=0; //Check your conditions on text variable
        });
      }
    });
    focusNodeDob.addListener(() {
      if (focusNodeDob.hasFocus) {
        setState(() {
          dob_elevation=10; //Check your conditions on text variable
        });
      }else{
        setState(() {
          dob_elevation=0; //Check your conditions on text variable
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(color: AppColors.orange),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/back.png",
                        width: 20,
                        height: 20,
                      ).marginOnly(top: 30, left: 12).paddingAll(5),
                    ),
                    Text(
                      "Update Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: "Gotham"),
                    ).marginOnly(top: 30, left: 12),

                  ],
                ),
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50, // Image radius
                    backgroundColor: AppColors.orange,
                    backgroundImage: AssetImage("assets/images/watch.png"),
                  ).marginOnly(top: 12),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.edit, color: Colors.black),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 3,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              50,
                            ),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 4),
                              color: Colors.black.withOpacity(
                                0.3,
                              ),
                              blurRadius: 3,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              Material(
              borderRadius: BorderRadius.circular(10),
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: email_elevation,
                        shadowColor: AppColors.orange,
                        child: TextFormField(
                          focusNode: focusNodeEmail,
                          keyboardType: TextInputType.emailAddress,
                          initialValue: widget.userModel.email,
                          style: const TextStyle(color: AppColors.background),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Email",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.background, width: 1),
                            ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   borderSide: const BorderSide(
                            //       color: AppColors.background, width: 1),
                            //),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.orange, width: 1),
                            ),
                            // disabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(25.0),
                            //   borderSide: const BorderSide(
                            //       color: Colors.transparent, width: 0),
                            // ),
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12,top: 12),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: name_elevation,
                        shadowColor: AppColors.orange,
                        child: TextFormField(
                          focusNode: focusNodeName,
                          keyboardType: TextInputType.name,
                          initialValue: widget.userModel.name,
                          style: const TextStyle(color: AppColors.background),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Name",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.background, width: 1),
                            ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   borderSide: const BorderSide(
                            //       color: AppColors.background, width: 1),
                            //),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.orange, width: 1),
                            ),
                            // disabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(25.0),
                            //   borderSide: const BorderSide(
                            //       color: Colors.transparent, width: 0),
                            // ),
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12,top: 15),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: password_elevation,
                        shadowColor: AppColors.orange,
                        child: TextFormField(
                          obscureText: true,
                          focusNode: focusNodePassword,
                          keyboardType: TextInputType.name,
                          initialValue: "******",
                          style: const TextStyle(color: AppColors.background),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Password",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.background, width: 1),
                            ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   borderSide: const BorderSide(
                            //       color: AppColors.background, width: 1),
                            //),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.orange, width: 1),
                            ),
                            // disabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(25.0),
                            //   borderSide: const BorderSide(
                            //       color: Colors.transparent, width: 0),
                            // ),
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12,top: 15),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: dob_elevation,
                        shadowColor: AppColors.orange,
                        child: TextFormField(
                          focusNode: focusNodeDob,
                          keyboardType: TextInputType.name,
                          initialValue: "12/01/2022",
                          style: const TextStyle(color: AppColors.background),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "DOB (MM/DD/YYYY)",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.background, width: 1),
                            ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   borderSide: const BorderSide(
                            //       color: AppColors.background, width: 1),
                            //),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.orange, width: 1),
                            ),
                            // disabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(25.0),
                            //   borderSide: const BorderSide(
                            //       color: Colors.transparent, width: 0),
                            // ),
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12,top: 15),
                      InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Gotham",
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12, top: 30),
                    ],
                  ),
                ),
              ).marginOnly(left: 12,right: 12,top: 20)
            ],
          )
        ],
      ),
    );
  }
}
