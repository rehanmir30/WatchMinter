import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Database/DatabaseHelper.dart';
import 'package:watchminter/Screens/Auth/Signup/SignUpScreen.dart';
import 'package:watchminter/Screens/Home/HomeScreen.dart';
import '../../Models/UserModel.dart';
import 'ForgetScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  var focusNodeEmail = FocusNode();
  var focusNodePassword = FocusNode();
  var email_elevation = 0.0;
  var password_elevation = 0.0;
  var Email, Password;
  var emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  void initState() {
    focusNodeEmail.addListener(() {
      if (focusNodeEmail.hasFocus) {
        setState(() {
          email_elevation = 10; //Check your conditions on text variable
        });
      } else {
        setState(() {
          email_elevation = 0; //Check your conditions on text variable
        });
      }
    });
    focusNodePassword.addListener(() {
      if (!focusNodePassword.hasFocus) {
        setState(() {
          password_elevation = 0; //Check your conditions on text variable
        });
      } else {
        setState(() {
          password_elevation = 10; //Check your conditions on text variable
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        //backgroundColor: AppColors.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "",
              style: TextStyle(
                  color: AppColors.background,
                  fontSize: 24,
                  fontFamily: 'Gotham'),
            ).marginOnly(left: 12, top: 80),
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/hoodwenki.png",
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 100,
                )),
            const SizedBox(
              height: 100,
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(15),
              child: Form(
                key: formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: email_elevation,
                        shadowColor: AppColors.orange,
                        child: TextFormField(
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return "Email required";
                            } else if (!emailValid.hasMatch(email)) {
                              return "Provided email is not in correct formate";
                            } else {
                              Email = email;
                              return null;
                            }
                          },
                          focusNode: focusNodeEmail,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: AppColors.background),
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Email",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.background, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.orange, width: 1),
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: password_elevation,
                        shadowColor: AppColors.orange,
                        child: TextFormField(
                          validator: (password){
                            if(password==null||password.isEmpty){
                              return "Password required";
                            }else{
                              Password=password;
                              return null;
                            }
                          },
                          focusNode: focusNodePassword,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: AppColors.background),
                          obscureText: true,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: "Password",
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
                                  color: AppColors.background, width: 0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: AppColors.orange, width: 1),
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ).marginOnly(top: 12, left: 12, right: 12),
                      InkWell(
                        onTap: (){
                          Get.to(ForgetScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: AppColors.background,
                                fontFamily: 'Gotham'),
                          ).marginOnly(left: 12, right: 12),
                        ),
                      ),
                      Material(
                        elevation: 20,
                        borderRadius: BorderRadius.circular(50),
                        child: InkWell(
                          onTap: () async {
                            Get.focusScope!.unfocus();
                            if (formKey.currentState != null &&
                                formKey.currentState!.validate()){
                              EasyLoading.show(status: 'loading...');
                              UserModel userModel=await DatabaseHelper().SignIn(Email, Password);

                              if(userModel.id==null){
                                EasyLoading.dismiss();
                                Get.snackbar("Error", "Failed to login",
                                    colorText: AppColors.white,
                                    icon: const Icon(Icons.error_outline, color: Colors.white),
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppColors.orange);
                              }else{
                                EasyLoading.dismiss();
                                Get.offAll(HomeScreen(userModel),
                                  transition: Transition.leftToRight);
                              }
                            }

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Gotham",
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ).marginOnly(left: 12, right: 12, top: 12),
                    ],
                  ),
                ),
              ),
            ).marginOnly(left: 12, right: 12),
            Expanded(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12)),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'New here? ',
                            style: TextStyle(fontFamily: "Gotham")),
                        TextSpan(
                            text: 'Signup now',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(const SignUpScreen(),
                                    transition: Transition.leftToRight);
                              },
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange,
                                fontFamily: "Gotham")),
                      ],
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
