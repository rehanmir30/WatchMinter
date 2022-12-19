import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchminter/Constants/AppColors.dart';

class CreateNewMessage extends StatefulWidget {
  const CreateNewMessage({Key? key}) : super(key: key);

  @override
  State<CreateNewMessage> createState() => _CreateNewMessageState();
}

class _CreateNewMessageState extends State<CreateNewMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Message"),
        backgroundColor: AppColors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "To: ",
                style: TextStyle(fontSize: 16),
              ),
              Expanded(
                child: TextFormField(
                  // validator: (email) {
                  //   if (email == null || email.isEmpty) {
                  //     return "Email required";
                  //   } else if (!emailValid.hasMatch(email)) {
                  //     return "Provided email is not in correct formate";
                  //   } else {
                  //     Email = email;
                  //     return null;
                  //   }
                  // },
initialValue: "tIGgfuLfPCWHs2kdpFPjYJ1ExFb2",
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: AppColors.background),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "User id",
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
                      borderSide:
                          const BorderSide(color: AppColors.orange, width: 1),
                    ),
                    // disabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(25.0),
                    //   borderSide: const BorderSide(
                    //       color: Colors.transparent, width: 0),
                    // ),
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ).marginOnly(left: 12, right: 12),
              ),
            ],
          ).marginSymmetric(horizontal: 10),
          Text(
            "Message",
            style: TextStyle(fontSize: 16),
          ).marginSymmetric(horizontal: 10, vertical: 12),
          TextFormField(
            // validator: (email) {
            //   if (email == null || email.isEmpty) {
            //     return "Email required";
            //   } else if (!emailValid.hasMatch(email)) {
            //     return "Provided email is not in correct formate";
            //   } else {
            //     Email = email;
            //     return null;
            //   }
            // },
            maxLines: 10,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: AppColors.background),
            decoration: InputDecoration(
              isDense: true,
              hintText: "Message",
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(color: AppColors.background, width: 1),
              ),
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(10.0),
              //   borderSide: const BorderSide(
              //       color: AppColors.background, width: 1),
              //),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: AppColors.orange, width: 1),
              ),
              // disabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(25.0),
              //   borderSide: const BorderSide(
              //       color: Colors.transparent, width: 0),
              // ),
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ).marginSymmetric(horizontal: 12),
          InkWell(
            onTap: (){

            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Send",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Gotham",
                        color: Colors.white),
                  ),
                  Icon(Icons.send,color: AppColors.white,).marginOnly(left: 8)
                ],
              ),
            ),
          ).marginOnly(top: 20,left: 12,right: 12),
        ],
      ).marginOnly(top: 12),
    );
  }
}
