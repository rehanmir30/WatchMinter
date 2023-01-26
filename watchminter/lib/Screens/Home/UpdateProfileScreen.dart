import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Database/DatabaseHelper.dart';

import '../../Constants/my_date_utils.dart';
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

  var newPassword = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  var email;
  var name;
  var password;
  var createdAt;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    focusNodeEmail.addListener(() {
      if (focusNodeEmail.hasFocus) {
        setState(() {
          email_elevation = 10; //Check your conditions on text variable
        });
      } else {
        setState(() {
          email_elevation = 0; //Check your conditions on text variable
        });
      }
    });
    focusNodeName.addListener(() {
      if (focusNodeName.hasFocus) {
        setState(() {
          name_elevation = 10; //Check your conditions on text variable
        });
      } else {
        setState(() {
          name_elevation = 0; //Check your conditions on text variable
        });
      }
    });
    focusNodePassword.addListener(() {
      if (focusNodePassword.hasFocus) {
        setState(() {
          password_elevation = 10; //Check your conditions on text variable
        });
      } else {
        setState(() {
          password_elevation = 0; //Check your conditions on text variable
        });
      }
    });
    focusNodeDob.addListener(() {
      if (focusNodeDob.hasFocus) {
        setState(() {
          dob_elevation = 10; //Check your conditions on text variable
        });
      } else {
        setState(() {
          dob_elevation = 0; //Check your conditions on text variable
        });
      }
    });
    getDetails();
  }

  getDetails(){
    email = widget.userModel.email.toString();
    name = widget.userModel.name.toString();
    password = newPassword.text.toString();
    createdAt = widget.userModel.createdAt;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white
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
                    height: MediaQuery.of(context).size.height*0.49,
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
                            controller: emailController,
                            validator: (val){
                              if(val!.isNotEmpty){
                                setState(() {
                                  email = val;
                                  email;
                                });

                              }else{
                                return "Email Required";
                              }
                            },
                            style: const TextStyle(color: AppColors.background),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: widget.userModel.email,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColors.background, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColors.orange, width: 1),
                              ),
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
                            controller: nameController,
                            validator: (val){
                              if(val!.isNotEmpty){
                                setState(() {
                                  name = val;
                                  name;
                                });
                              }else{
                                return "Name Required";
                              }
                            },
                            style: const TextStyle(color: AppColors.background),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: widget.userModel.name,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColors.background, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColors.orange, width: 1),
                              ),
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
                            controller: newPassword,
                            validator: (val){
                              if(val!.isNotEmpty){
                                setState(() {
                                  password = val;
                                  password;
                                });
                              }else{
                                return "Required Password";
                              }
                            },
                            style: const TextStyle(color: AppColors.background),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Current Password",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColors.background, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColors.orange, width: 1),
                              ),
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
                            style: const TextStyle(color: AppColors.background),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: createdAt,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.all(12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColors.background, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: AppColors.orange, width: 1),
                              ),
                              hintStyle: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ).marginOnly(left: 12, right: 12,top: 15),
                        InkWell(
                          onTap: ()async{
                           if(_formKey.currentState!.validate()){
                             if(password!=null||password!=''){
                               EasyLoading.show();
                               await FirebaseAuth.instance.signInWithEmailAndPassword(email: widget.userModel.email.toString(), password: password.toString()).then((value) {
                                 Fluttertoast.showToast(msg: "Sign In Success");
                                 print("Sign In success");
                               });
                               await DatabaseHelper.UpdateAccount(email, name,password);
                             }
                             else{
                               Fluttertoast.showToast(msg: "Password Required");
                             }
                           }
                          },
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
      ),
    );
  }

  
}
