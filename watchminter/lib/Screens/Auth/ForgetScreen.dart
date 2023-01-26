import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:watchminter/Constants/AppColors.dart';

import '../../Database/DatabaseHelper.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {

  TextEditingController emailController =TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var Email;
  var emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password"),
        backgroundColor: AppColors.orange,),
      backgroundColor: Color(0xffEEEEEE),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enter your email here to receive a reset link",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff908E8E),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 50, 15, 0),
                  child: TextFormField(
                    validator: (emailController) {
                      if (emailController!.isEmpty || emailController == null) {
                        return "Email Required";
                      } else if (!emailValid.hasMatch(emailController)) {
                        return "Email format not correct";
                      } else {
                        Email = emailController;
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()async{
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      // Fluttertoast.showToast(msg: Email.toString());
                      print("Running");
                     var result =  await DatabaseHelper.resetPassword(Email, context);
                     if(result ==true){
                       await FirebaseAuth.instance.sendPasswordResetEmail(email: Email);
                       Get.snackbar(Email, "link has been sent");
                       EasyLoading.dismiss();
                     }else{
                       Get.snackbar(Email, "No User Found");
                       EasyLoading.dismiss();
                     }
                    }
                  },
                  child: Container(
                    width: 115,
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Reset",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
