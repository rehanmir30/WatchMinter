import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Database/DatabaseHelper.dart';
import 'package:watchminter/Models/UserModel.dart';
import 'package:watchminter/Screens/Home/UpdateProfileScreen.dart';
import 'package:watchminter/Screens/ViewProfile.dart';

class MyProfile extends StatefulWidget {
  UserModel userModel;
  MyProfile(this.userModel,{Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}
@override
void initState() {

}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: AppColors.background,
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
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  elevation: 20,
                  borderRadius: BorderRadius.circular(50),
                  child: CircleAvatar(
                    radius: 50, // Image radius
                    backgroundColor: AppColors.orange,
                    backgroundImage: AssetImage("assets/images/watch.png"),
                  ),
                ),
                Text(
                  widget.userModel.name,
                  style: TextStyle(
                      color: AppColors.background,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Gotham",
                      fontSize: 22),
                ).marginOnly(top: 18),
                // Text(
                //   "Good Evening",
                //   style: TextStyle(color: AppColors.orange, letterSpacing: 2),
                // ).marginOnly(top: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: (){
                      Get.to(ViewProfile(widget.userModel),transition: Transition.leftToRight);
                    },
                    child: Text(
                      "View Profile",
                      style: TextStyle(
                          color: AppColors.background,
                          fontFamily: "Gotham",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ).marginOnly(top: 50,left: 20),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ).marginOnly(top: 12,left: 12,right: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: (){
                      Get.to(UpdateProfileScreen(widget.userModel),transition: Transition.leftToRight);
                    },
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                          color: AppColors.background,
                          fontFamily: "Gotham",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ).marginOnly(top: 30,left: 20),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ).marginOnly(top: 12,left: 12,right: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Verify Id",
                    style: TextStyle(
                        color: AppColors.background,
                        fontSize: 20,
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.bold),
                  ).marginOnly(top: 30,left: 20),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ).marginOnly(top: 12,left: 12,right: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Contact us",
                    style: TextStyle(
                        color: AppColors.background,
                        fontSize: 20,
                        fontFamily: "Gotham",
                        fontWeight: FontWeight.bold),
                  ).marginOnly(top: 30,left: 20),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ).marginOnly(top: 12,left: 12,right: 12),
                Row(
                  children: [
                    Icon(Icons.exit_to_app,color: AppColors.orange,).marginOnly(top: 30,left: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Log out",
                        style: TextStyle(
                            color: AppColors.background,
                            fontSize: 20,
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.bold),
                      ).marginOnly(top: 30,left: 20),
                    ),
                  ],
                ),
                Divider(
                  height: 1,
                  color: Colors.grey,
                ).marginOnly(top: 12,left: 12,right: 12),
                Row(
                  children: [
                    Icon(Icons.delete,color: AppColors.orange,).marginOnly(top: 30,left: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Delete my account",
                        style: TextStyle(
                            color: AppColors.background,
                            fontSize: 20,
                            fontFamily: 'Gotham',
                            fontWeight: FontWeight.bold),
                      ).marginOnly(top: 30,left: 20),
                    )
                  ],

                ),
                Divider(
                  height: 1,
                  color: Colors.white70,
                ).marginOnly(top: 12,left: 12,right: 12)
              ],
            ).marginOnly(top: 80),
          )
        ],
      ),
    );
  }
}
