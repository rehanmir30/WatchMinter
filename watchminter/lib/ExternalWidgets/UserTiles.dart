import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Screens/GetUserDetail.dart';

import '../Screens/ViewProfile.dart';

class UserTiles extends StatefulWidget {
  final data;
   UserTiles(this.data,{Key? key}) : super(key: key);

  @override
  State<UserTiles> createState() => _UserTilesState();
}

class _UserTilesState extends State<UserTiles> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          Get.to(GetUserDetail(widget.data),
              transition: Transition.zoom);
        },
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent),
          child: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Container(child: Icon(Icons.person,color: Colors.grey,size: 100,),),
                    // child: FadeInImage.assetNetwork(
                    //   image: "assets/images/watch.png",
                    //   placeholder: "assets/images/watch.png",
                    // ),
                    // Image.asset("assets/images/watch.png"),
                  )),
              Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                    ),
                    child: Center(
                        child: Text(
                          widget.data["Name"],
                          style: TextStyle(
                              fontFamily: "Gotham", fontWeight: FontWeight.bold),
                        )),
                  ))
            ],
          ),
        ),
      ),
    ).marginAll(12);
  }
}
