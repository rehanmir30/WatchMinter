import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Database/DatabaseHelper.dart';
import 'package:watchminter/Models/UserModel.dart';
import 'package:watchminter/Models/WatchModel.dart';

import '../EditWatchDetails.dart';

class WatchDetailScreen extends StatefulWidget {
  final watchId;

  WatchDetailScreen(this.watchId, {Key? key}) : super(key: key);

  @override
  State<WatchDetailScreen> createState() => _WatchDetailScreenState();
}

class _WatchDetailScreenState extends State<WatchDetailScreen> {
  bool value = false;
  WatchModel watchModel = WatchModel();
  List images = [];
  var history = "";
  var buyer_elevation = 0.0;
  final formKey = GlobalKey<FormState>();
  var focusNodeBuyerId = FocusNode();
  var buyerId;

  @override
  void initState() {
    focusNodeBuyerId.addListener(() {
      if (focusNodeBuyerId.hasFocus) {
        setState(() {
          buyer_elevation = 10; //Check your conditions on text variable
        });
      } else {
        setState(() {
          buyer_elevation = 0; //Check your conditions on text variable
        });
      }
    });
    getWatchDetails();
  }

  getWatchDetails() async {
    EasyLoading.show(status: "Loading....");
    watchModel = await DatabaseHelper().GetWatch(widget.watchId);

    history = "This watch was created by ";
    for (int i = 0; i < watchModel.history.length; i++) {
      UserModel user = await DatabaseHelper()
          .GetSpecificUser(watchModel.history[i].ownerId.toString());
      history = history +
          user.name +
          " on " +
          watchModel.history[i].time.toString() +
          ".";
      if (i + 1 < watchModel.history.length) {
        history = history + "Then it was passed to ";
      }
    }
    setState(() {
      watchModel;
      images = watchModel.images;
      history;
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return value
        ? Center(child: Container())
        : Scaffold(
            //backgroundColor: AppColors.background,
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: AppColors.white),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(color: AppColors.orange),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              watchModel.brand ?? "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Gotham"),
                            ).marginOnly(top: 30, left: 12)),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(height: 200.0),
                        items: watchModel.images != null
                            ? images.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                        child: Image.network(i));
                                  },
                                );
                              }).toList()
                            : [1].map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                        child: Image.asset(
                                            "assets/images/watch.png")
                                        // child: Image.asset(
                                        //   "assets/images/watch.png",
                                        // )
                                        );
                                  },
                                );
                              }).toList(),
                      ).marginOnly(top: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Add image",
                            style: TextStyle(
                                color: AppColors.background,
                                fontFamily: 'Gotham',
                                fontSize: 16),
                          ),
                          Icon(
                            Icons.add,
                            color: AppColors.background,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Details",
                            style: TextStyle(
                                color: AppColors.background,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Gotham"),
                          ),
                          InkWell(
                              onTap: () async {
                                watchModel = await Get.to(
                                    EditWatchDetails(watchModel),
                                    transition: Transition.downToUp);
                                setState(() {
                                  watchModel;
                                });
                              },
                              child: Icon(Icons.edit))
                        ],
                      ).marginOnly(left: 12, top: 12, right: 12),
                      Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              // Get.to(EditWatchDetails(),transition: Transition.downToUp);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Watch Id",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.watchId ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginAll(10),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Brand",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.brand ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Model",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.model ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Serial number",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.serialNumber ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Condition",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.condition ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Original Papers",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.papers ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Original Box",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.box ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Location",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.location ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Offered by",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.offeredBy ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Id verified",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      "No",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Joined in",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      watchModel.createdAt ?? "",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginOnly(left: 10, right: 10, top: 5),
                                  Row(children: [
                                    Expanded(
                                        child: Text(
                                      "Seller rating",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Gotham"),
                                    )),
                                    Expanded(
                                        child: Text(
                                      "4.8",
                                      style: TextStyle(
                                          color: AppColors.background,
                                          fontFamily: "Gotham"),
                                    ))
                                  ]).marginAll(10),
                                ],
                              ),
                            ),
                          )).marginOnly(left: 12, right: 12, top: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "History",
                            style: TextStyle(
                                color: AppColors.background,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Gotham"),
                          ),
                        ],
                      ).marginOnly(left: 12, top: 12, right: 12),
                      Text(history).marginOnly(left: 12, right: 12, top: 10),
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'This watch passport was created by user ',
                      //     style: TextStyle(
                      //         fontFamily: 'Gotham',
                      //         color: AppColors.background),
                      //     children: const <TextSpan>[
                      //       TextSpan(
                      //         text: 'JamesDeetWatches',
                      //         style: TextStyle(
                      //             fontFamily: 'Gotham',
                      //             color: AppColors.orange),
                      //       ),
                      //       TextSpan(
                      //           text: ' on',
                      //           style: TextStyle(
                      //               fontFamily: 'Gotham',
                      //               color: AppColors.background)),
                      //       TextSpan(
                      //           text: ' 5th December 2022.',
                      //           style: TextStyle(
                      //               fontFamily: 'Gotham',
                      //               color: AppColors.orange)),
                      //       TextSpan(
                      //           text: ' This user is a',
                      //           style: TextStyle(
                      //               fontFamily: 'Gotham',
                      //               color: AppColors.background)),
                      //       TextSpan(
                      //           text: ' professional seller,',
                      //           style: TextStyle(
                      //               fontFamily: 'Gotham',
                      //               color: AppColors.orange)),
                      //       TextSpan(
                      //           text: ' with a trust rating of',
                      //           style: TextStyle(
                      //               fontFamily: 'Gotham',
                      //               color: AppColors.background)),
                      //       TextSpan(
                      //           text: ' 4.9',
                      //           style: TextStyle(
                      //               fontFamily: 'Gotham',
                      //               color: AppColors.orange)),
                      //     ],
                      //   ),
                      // ).marginOnly(left: 12, right: 12, top: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: watchModel.forSale ?? false,
                            checkColor: AppColors.background,
                            activeColor: AppColors.orange,
                            side: BorderSide(
                              color: AppColors.orange, //your desire colour here
                              width: 1.5,
                            ),
                            onChanged: (var value) {
                              setState(() {
                                watchModel.forSale = value!;
                              });
                            },
                          ),
                          Text(
                            "Mark for sale",
                            style: TextStyle(
                                color: AppColors.background,
                                fontSize: 18,
                                fontFamily: 'Gotham'),
                          ),
                        ],
                      ).marginOnly(top: 12),
                      watchModel.forSale != null && watchModel.forSale
                          ? Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Set Price",
                                    style: TextStyle(
                                        color: AppColors.background,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        watchModel.price = value.toString();
                                      },
                                      style: const TextStyle(
                                          color: AppColors.background),
                                      initialValue: watchModel.price ?? "",
                                      decoration: InputDecoration(
                                        isDense: true,
                                        prefix: Icon(
                                          Icons.currency_pound,
                                          size: 15,
                                        ),
                                        hintText: "Price",
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: AppColors.background,
                                              width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: AppColors.background,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: const BorderSide(
                                              color: AppColors.background,
                                              width: 1),
                                        ),
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).marginOnly(left: 12, right: 12)
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sell watch",
                            style: TextStyle(
                                color: AppColors.background, fontSize: 18),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0)),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 250,
                                            child: Form(
                                              key: formKey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Enter the user's ID to sell this watch",
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .background,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: "Gotham"),
                                                    ).marginOnly(top: 20),
                                                    Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      elevation:
                                                          buyer_elevation,
                                                      shadowColor:
                                                          AppColors.orange,
                                                      child: TextFormField(
                                                        initialValue: "fJIuiawerzfKfCTTYLGJN2Zswzr2",
                                                        validator: (BuyerId) {
                                                          if (BuyerId == null ||
                                                              BuyerId.isEmpty) {
                                                            return "Buyer ID is required";
                                                          } else {
                                                            buyerId = BuyerId;
                                                            return null;
                                                          }
                                                        },
                                                        focusNode:
                                                            focusNodeBuyerId,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .background),
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          hintText: "Buyer id",
                                                          fillColor:
                                                              Colors.white,
                                                          filled: true,
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(12),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            borderSide: const BorderSide(
                                                                color: AppColors
                                                                    .background,
                                                                width: 1),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: AppColors
                                                                        .orange,
                                                                    width: 1),
                                                          ),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ).marginOnly(top: 12),
                                                    Material(
                                                      elevation: 20,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: InkWell(
                                                        onTap: () async{
                                                          if (formKey.currentState !=
                                                                  null &&
                                                              formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                            EasyLoading.show(status: "Loading");
                                                           bool result= await DatabaseHelper().SellWatch(watchModel,buyerId);
                                                           EasyLoading.dismiss();
                                                           if(result==true){
                                                             Get.snackbar("Successful", "Watch sold successfully",
                                                                 colorText: AppColors.white,
                                                                 icon: Icon(Icons.error_outline, color: Colors.white),
                                                                 snackPosition: SnackPosition.TOP,
                                                                 backgroundColor: AppColors.orange);
                                                             Get.back();

                                                           }else{
                                                             Get.snackbar("Error", "Buyer id was not found",
                                                                 colorText: AppColors.white,
                                                                 icon: Icon(Icons.error_outline, color: Colors.white),
                                                                 snackPosition: SnackPosition.TOP,
                                                                 backgroundColor: AppColors.orange);
                                                           }
                                                            //buyerId
                                                            //history
                                                          }
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .orange,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Center(
                                                            child: Text(
                                                              "Sell watch",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "Gotham",
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ).marginOnly(top: 12)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.orange),
                                child: Icon(
                                  Icons.share,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ).marginOnly(left: 12, right: 12, top: 20),
                      Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () async {
                            EasyLoading.show();
                            await DatabaseHelper().UpdateWatch(watchModel);
                            EasyLoading.dismiss();
                            Fluttertoast.showToast(msg: "Changes saved");
                            Get.back();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Save Changes",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Gotham",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12, top: 20),
                      Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Delete Watch",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Gotham",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12, top: 20, bottom: 40),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
