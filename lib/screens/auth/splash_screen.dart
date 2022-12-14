import 'dart:async';

import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/screens/auth/login_screen.dart';
import 'package:ecommerce/screens/nav_bar/bottom_nav-bar.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavBar()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }
  }

  @override
  void initState() {
    isLogin();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kbgcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome to My",
            style: myStyle(40.sp, Colors.white, FontWeight.w700),
          ),
          Text(
            "E-commerce",
            style: myStyle(40.sp, Colors.white, FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
