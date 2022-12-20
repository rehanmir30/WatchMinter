import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Global/firebase_ref.dart';
import 'package:watchminter/Models/UserModel.dart';
import 'package:watchminter/Models/WatchHistoryModel.dart';
import 'package:watchminter/Models/WatchModel.dart';

import 'package:intl/intl.dart';

class DatabaseHelper {
  Future<UserModel> SignUp(UserModel model) async {
    UserModel userModel = UserModel();
    await Firebase.initializeApp();
    String currentTime = DateTime.now().toString();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model.email,
        password: model.id,
      );
      var userid = userCredential.user!.uid;
      userModel = model;
      userModel.id = userid;
      userModel.createdAt = currentTime;
      await usersRef.doc(userid).set(userModel.toMap());
      return userModel;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString(),
          colorText: AppColors.white,
          icon: Icon(Icons.error_outline, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.orange);
      return userModel;
    }
  }

  Future<UserModel> SignIn(var email, var password) async {
    UserModel userModel = UserModel();

    await Firebase.initializeApp();
    try {
      FirebaseAuth _auth = await FirebaseAuth.instance;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      var userId = userCredential.user!.uid;

      DocumentSnapshot userData = await usersRef.doc(userId).get();
      Map<String, dynamic> dataFromDB = {
        'id': userData["id"],
        'Name': userData["Name"],
        'Email': userData["Email"],
        'DOB': userData["DOB"],
        'House_name_number': userData["House_name_number"],
        'Street': userData["Street"],
        'Town': userData["Town"],
        'Province': userData["Province"],
        'Zip': userData["Zip"],
        'Country': userData["Country"],
        'About': userData["About"],
        'Business details': userData["Business details"],
        'Type': userData["Type"],
        'Created at': userData["Created at"],
        "Rating": userData['Rating'],
        "Verified": userData["Verified"]
      };

      userModel = UserModel.fromMap(dataFromDB);

      return userModel;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.toString(),
          colorText: AppColors.white,
          icon: Icon(Icons.error_outline, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.orange);
      return userModel;
    }
  }

  Future AddWatch(WatchModel watchModel) async {
    await Firebase.initializeApp();
    WatchHistoryModel watchHistoryModel = WatchHistoryModel(
        ownerId: watchModel.ownerId, time: watchModel.createdAt);

    watchModel.watchId = UniqueKey().toString();
    var docId = watchesRef.doc().id;

    watchModel.displayImage = await uploadfile(
      watchModel.images,
      docId,
    );
    await watchesRef.doc(docId).set(watchModel.toMap());
    await watchesRef
        .doc(docId)
        .collection("History")
        .doc()
        .set(watchHistoryModel.toMap());
  }

  Future<WatchModel> GetWatch(String watchId) async {
    WatchModel watchModel = WatchModel();
    var docId;
    await Firebase.initializeApp();
    //Getting watch details
    await watchesRef.where("watchId", isEqualTo: watchId).get().then((value) {
      value.docs.forEach((doc) {
        watchModel.brand = doc["brand"];
        watchModel.location = doc["location"];
        watchModel.price = doc["price"];
        watchModel.box = doc["box"];
        watchModel.condition = doc["condition"];
        watchModel.displayImage = doc["displayImage"];
        watchModel.forSale = doc["forSale"];
        watchModel.createdAt = doc["createdAt"];
        watchModel.model = doc["model"];
        watchModel.offeredBy = doc["offeredBy"];
        watchModel.ownerId = doc["ownerId"];
        watchModel.papers = doc["papers"];
        watchModel.serialNumber = doc["serialNumber"];
        watchModel.watchId = doc["watchId"];
        docId = doc.id;
      });
    }).catchError((onError) {
      Get.snackbar("Error", onError.toString(),
          colorText: AppColors.white,
          icon: Icon(Icons.error_outline, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.orange);
      return watchModel;
    });
    //Getting watch images
    List<String> images = [];
    await watchesRef.doc(docId).collection("Images").get().then((value) {
      value.docs.forEach((element) {
        images.add(element["Img"].toString());
      });
      watchModel.images = images;
    }).catchError((onError) {
      Get.snackbar("Error", onError.toString(),
          colorText: AppColors.white,
          icon: Icon(Icons.error_outline, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.orange);
      return watchModel;
    });
    //Getting watch history
    List<WatchHistoryModel> historyList = [];
    await watchesRef.doc(docId).collection("History").orderBy("time").get().then((value) {
      value.docs.forEach((element) {
        WatchHistoryModel watchHistoryModel =
            WatchHistoryModel.fromMap(element);
        historyList.add(watchHistoryModel);
      });
      watchModel.history = historyList;
    }).catchError((onError) {
      Get.snackbar("Error", onError.toString(),
          colorText: AppColors.white,
          icon: Icon(Icons.error_outline, color: Colors.white),
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.orange);
      return watchModel;
    });
    return watchModel;
  }

  Future<UserModel> GetSpecificUser(String userId)async{
    UserModel userModel=UserModel();

    DocumentSnapshot userData = await usersRef.doc(userId).get();
    Map<String, dynamic> dataFromDB = {
      'id': userData["id"],
      'Name': userData["Name"],
      'Email': userData["Email"],
      'DOB': userData["DOB"],
      'House_name_number': userData["House_name_number"],
      'Street': userData["Street"],
      'Town': userData["Town"],
      'Province': userData["Province"],
      'Zip': userData["Zip"],
      'Country': userData["Country"],
      'About': userData["About"],
      'Business details': userData["Business details"],
      'Type': userData["Type"],
      'Created at': userData["Created at"],
      "Rating": userData['Rating'],
      "Verified": userData["Verified"],
    };
    userModel = UserModel.fromMap(dataFromDB);
    return userModel;
  }

  Future UpdateWatch(WatchModel watchModel) async {
    await Firebase.initializeApp();
    var docID;
    watchesRef
        .where("watchId", isEqualTo: watchModel.watchId)
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        docID = element.id;
      });
      await watchesRef.doc(docID).set(watchModel.toMap());
      print(docID);
    });
  }

  Future uploadfile(images, docId) async {
    await Firebase.initializeApp();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    bool first_call = false;
    var displayImage;
    for (var image in images) {
      var imageUrl;
      String imgUniqueName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceDirImages = await referenceRoot
          .child('images/watch_images')
          .child("watch_" + imgUniqueName);
      try {
        await referenceDirImages.putFile(File(image.path));
        imageUrl = await referenceDirImages.getDownloadURL();
        if (!first_call) {
          displayImage = imageUrl;
          first_call = true;
        }
        await watchesRef
            .doc(docId)
            .collection("Images")
            .doc()
            .set({"Img": imageUrl});
      } catch (e) {
        print(e.toString());
        Get.snackbar("Error", e.toString(),
            colorText: AppColors.white,
            icon: Icon(Icons.error_outline, color: Colors.white),
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.orange);
      }
    }
    return displayImage;
  }

  Future<bool>SellWatch(WatchModel watchModel, buyerId) async{
    var docID;
    DateTime now = DateTime.now();
    String currentDate = DateFormat('d MMM y').format(now);
    DocumentSnapshot userData = await usersRef.doc(buyerId).get();
    if(userData.exists){
      watchModel.ownerId=buyerId;
      await UpdateWatch(watchModel);
      watchesRef
          .where("watchId", isEqualTo: watchModel.watchId)
          .get()
          .then((value) async {
        value.docs.forEach((element) {
          docID = element.id;
        });
        WatchHistoryModel watchHistoryModel=WatchHistoryModel(ownerId: buyerId,buyerId: buyerId,time: currentDate);
        await watchesRef.doc(docID).collection("History").doc().set(watchHistoryModel.toMap());
        print(docID);
        return true;
      });

      return true;
    }else{
      return false;
    }
  }
}
