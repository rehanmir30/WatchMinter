import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Models/UserModel.dart';

class Search extends StatefulWidget {
  UserModel userModel;
   Search(this.userModel,{Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: AppColors.orange,
      //   title: Text("Search"),
      // ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white
                // image: DecorationImage(
                //   fit: BoxFit.cover,
                //   image: new AssetImage("assets/images/blacknwhite_bg.jpg"),
                // )
            ),
          ),
          Column(children: [

            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(color: AppColors.orange),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Search",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "Gotham"),
                  ).marginOnly(top: 30, left: 12)),
            ),

          ],)
        ],
      ),
    );
  }
}
