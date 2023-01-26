import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Database/DatabaseHelper.dart';
import 'package:watchminter/Models/UserModel.dart';
import 'package:watchminter/Models/WatchModel.dart';

import '../../../ExternalWidgets/UserTiles.dart';
import '../../../Global/firebase_ref.dart';
import '../../../main.dart';
import 'Collections.dart';

class Search extends StatefulWidget {
  UserModel userModel;
  Search(this.userModel, {Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  var searhing;
  var search;
  bool _isSearching = true;
  var list = [];
  var userList =[];
  var  _searched = [];
  var _userSearched=[];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_isSearching) {
          setState(() {
           if(_isSearching){
             _isSearching = !_isSearching;
             FocusScope.of(context).unfocus();
           }
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },

      child: GestureDetector(
        onTap: () =>
        {FocusScope.of(context).unfocus(),
          _isSearching=!_isSearching,
                  },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(color: AppColors.white),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: const BoxDecoration(color: AppColors.orange),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Gotham"),
                          ).marginOnly(top: 30, left: 12)),
                    ),
                    const SizedBox(height: 15),
                    //TextField for searching
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              onTap: ()=>setState(() {if(!_isSearching){_isSearching=!_isSearching;}}),
                              onChanged: ((val) {
                                //searching logic.
                                _searched.clear();
                                _userSearched.clear();
                                for (var i in list) {
                                  if (i["brand"]
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                      i["location"]
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["condition"]
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["createdAt"]
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["watchId"]
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["model"]
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["serialNumber"]
                                          .toLowerCase()
                                          .contains(val.toLowerCase())
                                  ) {
                                    _searched.add(i);
                                  }
                                  if(val==''||val.isEmpty||val==null){
                                    setState(() {
                                      _searched.clear();
                                    });

                                  }
                                  setState(() {
                                    _searched;
                                    print("Searched: "+_searched.length.toString());
                                  });

                                }
                                for (var i in userList) {
                                  if (i["id"].toString()
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                      i["Name"].toString()
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["Email"].toString()
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["Country"].toString()
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["Province"].toString()
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["Business details"].toString()
                                          .toLowerCase()
                                          .contains(val.toLowerCase())||
                                      i["Verified"].toString()
                                          .toLowerCase()
                                          .contains(val.toLowerCase())
                                  ) {
                                    _userSearched.add(i);
                                  }
                                  if(val==''||val.isEmpty||val==null){
                                    setState(() {
                                      _searched.clear();
                                      _userSearched.clear();
                                    });
                                  }
                                  setState(() {
                                    _searched;
                                    _userSearched;
                                    print("Searched: "+_searched.length.toString());
                                    print("User Searched: "+_userSearched.length.toString());
                                  });
                                }
                              }),
                                keyboardType: TextInputType.text,
                                style: const TextStyle(color: AppColors.background),
                                autofocus: true,
                                decoration: InputDecoration(

                                  isDense: true,
                                  hintText: "Search",
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if(_isSearching){
                                            _isSearching = !_isSearching;
                                            FocusScope.of(context).unfocus();
                                          }
                                        });
                                      },
                                      icon: Icon(_isSearching
                                          ? CupertinoIcons.clear_circled_solid
                                          : Icons.search,color: AppColors.orange,)),
                                  contentPadding: const EdgeInsets.all(12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.background, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.background, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.background, width: 1),
                                  ),
                                  hintStyle: const TextStyle(color: Colors.grey),
                                ),
                              ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      height: 20,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: const Text(
                        "Watches",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                    //For Getting All The Searhed Watches
                    StreamBuilder(
                        stream: watchesRef
                            .where("ownerId", isNotEqualTo: widget.userModel.id).snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                          //if is data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Center(child: Text("No Watch Found"));
                          //if data is loaded
                            case ConnectionState.active:
                            case ConnectionState.done:
                              list.clear();
                              final data = snapshot.data?.docs;
                              list = data ?? [];
                              if (_searched.isNotEmpty) {
                                print(list.length);
                                return GridView.builder(
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount:  _searched.length,
                                    itemBuilder: (context, index) {
                                      return CollectionTiles(_searched[index]
                                          );
                                    });
                              } else {
                                return Center(
                                  child: Text("No Watch Found"),
                                );
                              }
                          }


                        }),
                    Container(
                      height: 30,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: const Text(
                        "Users",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),

                    // //For Getting All The Searhed Users
                    StreamBuilder(
                        stream: usersRef
                            .where("id", isNotEqualTo: widget.userModel.id).snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                          //if is data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Center(child: Text("No User Found"));
                          //if data is loaded
                            case ConnectionState.active:
                            case ConnectionState.done:
                              userList.clear();
                              final data = snapshot.data?.docs;
                              userList = data ?? [];
                              if (_userSearched.isNotEmpty) {
                                return GridView.builder(
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                    physics: const ScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: true,
                                    itemCount:  _userSearched.length,
                                    itemBuilder: (context, index) {
                                      return UserTiles(_userSearched[index]);
                                    });
                              } else {
                                return const Center(
                                  child: Text("No User Found"),
                                );
                              }
                          }
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
EasyLoading.dismiss();
  }
}