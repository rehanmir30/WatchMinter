import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:watchminter/Models/WatchModel.dart';
import 'package:watchminter/Screens/Home/SubScreens/Collections.dart';

import '../../Constants/AppColors.dart';
import '../../Database/DatabaseHelper.dart';
import '../../Models/UserModel.dart';

class SellWatch extends StatefulWidget {
  WatchModel watchId;
  SellWatch({Key? key, required this.watchId}) : super(key: key);

  @override
  State<SellWatch> createState() => _SellWatchState();
}

class _SellWatchState extends State<SellWatch> {
  var buyerId;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: AppColors.white),
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(color: AppColors.orange),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sell Watch",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "Gotham"),
                        ).marginOnly(top: 30, left: 12)),
                  ),

                  SizedBox(height: 15),
                  Text(
                    "Please Enter Buyer Id",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  SizedBox(height: 5),

                  //TextField to sell watch to the buyer
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    child: TextFormField(
                      validator: (BuyerId) {
                        if (BuyerId == null || BuyerId.isEmpty) {
                          return "Buyer ID is required";
                        } else {
                          buyerId = BuyerId;
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      style: const TextStyle(color: AppColors.background),
                      decoration: InputDecoration(
                        suffixIcon: Icon(CupertinoIcons.person,
                            color: Colors.orangeAccent),
                        isDense: true,
                        hintText: "Buyer Id",
                        fillColor: Colors.white,
                        filled: true,
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
              Positioned(
                bottom: 10,
                right: 10,
                left: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Sell Watch Directly
                    InkWell(
                      onTap: () async {
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {
                          EasyLoading.show(status: "Loading");
                          widget.watchId.escrow = true;
                          bool result = await DatabaseHelper()
                              .SellWatch(widget.watchId, buyerId);
                          EasyLoading.dismiss();
                          if (result == true) {
                            // Get.snackbar(
                            //     "Successful", "Watch sold successfully",
                            //     colorText: AppColors.white,
                            //     icon: Icon(Icons.error_outline,
                            //         color: Colors.white),
                            //     snackPosition: SnackPosition.TOP,
                            //     backgroundColor: AppColors.orange);

                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                width: 300,
                                text: "Congratulation the watch is sold",
                                barrierDismissible: false,
                                backgroundColor: AppColors.orange,
                                onConfirmBtnTap: (() async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }),
                                confirmBtnColor: AppColors.orange,
                                confirmBtnText: "Done");
                          } else {
                            Get.snackbar("Error", "Buyer id was not found",
                                colorText: AppColors.white,
                                icon: Icon(Icons.error_outline,
                                    color: Colors.white),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: AppColors.orange);
                          }
                          //buyerId
                          //history
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
                            "Sell Watch Now",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Gotham",
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Sell Watch through escrow
                    InkWell(
                      onTap: () async {
                        if (formKey.currentState != null &&
                            formKey.currentState!.validate()) {
                          widget.watchId.escrow = false;
                          EasyLoading.show(status: "Loading");
                          bool result = await DatabaseHelper()
                              .SellWatch(widget.watchId, buyerId);
                          EasyLoading.dismiss();
                          if (result == true) {
                            // Get.snackbar(
                            //     "Successful", "Watch sold successfully",
                            //     colorText: AppColors.white,
                            //     icon: Icon(Icons.error_outline,
                            //         color: Colors.white),
                            //     snackPosition: SnackPosition.TOP,
                            //     backgroundColor: AppColors.orange);

                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                backgroundColor: AppColors.orange,
                                width: 300,
                                text: "The watch has been send to Escrow ",
                                barrierDismissible: false,
                                onConfirmBtnTap: (() async {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }),
                                confirmBtnColor: AppColors.orange,
                                confirmBtnText: "Done");
                          } else {
                            Get.snackbar("Error", "Buyer id was not found",
                                colorText: AppColors.white,
                                icon: Icon(Icons.error_outline,
                                    color: Colors.white),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: AppColors.orange);
                          }
                          //buyerId
                          //history
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
                            "Send to Escrow",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Gotham",
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
