import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Database/DatabaseHelper.dart';
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

  @override
  void initState() {
    getWatchDetails();
  }

  getWatchDetails() async {
    EasyLoading.show(status: "Loading....");
    watchModel = await DatabaseHelper().GetWatch(widget.watchId);
    setState(() {
      watchModel;
      images = watchModel.images;
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
                          // InkWell(
                          //     onTap: () {
                          //       // Get.to(EditWatchHistory(),transition: Transition.downToUp);
                          //     },
                          //     child: Icon(Icons.edit))
                        ],
                      ).marginOnly(left: 12, top: 12, right: 12),
                      RichText(
                        text: TextSpan(
                          text: 'This watch passport was created by user ',
                          style: TextStyle(
                              fontFamily: 'Gotham',
                              color: AppColors.background),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'JamesDeetWatches',
                              style: TextStyle(
                                  fontFamily: 'Gotham',
                                  color: AppColors.orange),
                            ),
                            TextSpan(
                                text: ' on',
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color: AppColors.background)),
                            TextSpan(
                                text: ' 5th December 2022.',
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color: AppColors.orange)),
                            TextSpan(
                                text: ' This user is a',
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color: AppColors.background)),
                            TextSpan(
                                text: ' professional seller,',
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color: AppColors.orange)),
                            TextSpan(
                                text: ' with a trust rating of',
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color: AppColors.background)),
                            TextSpan(
                                text: ' 4.9',
                                style: TextStyle(
                                    fontFamily: 'Gotham',
                                    color: AppColors.orange)),
                          ],
                        ),
                      ).marginOnly(left: 12, right: 12, top: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: watchModel.forSale??false,
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
                      watchModel.forSale!=null && watchModel.forSale?
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Set Price",
                              style: TextStyle(
                                  color: AppColors.background, fontSize: 18),
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                style: const TextStyle(
                                    color: AppColors.background),
                                initialValue: watchModel.price??"",
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefix: Icon(
                                    Icons.currency_pound,
                                    size: 15,
                                  ),
                                  hintText: "Price",
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.background,
                                        width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.background,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        color: AppColors.background,
                                        width: 1),
                                  ),
                                  // disabledBorder: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(25.0),
                                  //   borderSide: const BorderSide(
                                  //       color: Colors.transparent, width: 0),
                                  // ),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).marginOnly(left: 12, right: 12):Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Sell watch",
                            style: TextStyle(
                                color: AppColors.background, fontSize: 18),
                          ),
                          Container(
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
