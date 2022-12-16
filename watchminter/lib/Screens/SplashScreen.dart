import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:watchminter/Constants/AppColors.dart';
import 'package:watchminter/Screens/Auth/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: new AssetImage("assets/images/splashImg.png"),
          )),
        ),
      ],
    ));
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), (){
      Get.offAll(LoginScreen(),transition: Transition.zoom);
    });
  }
}
