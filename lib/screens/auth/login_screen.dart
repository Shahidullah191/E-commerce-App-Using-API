import 'dart:convert';

import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/screens/nav_bar/bottom_nav-bar.dart';
import 'package:ecommerce/screens/nav_bar/bottom_navbar_pages/order_page.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:ecommerce/widgets/common_widget.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  bool isObsecure = true;

  getLogin() async {
    try{
      setState(() {
        isLoading = true;
      });
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String link = "${baseUrl}sign-in";
      var map = Map<String, dynamic>();
      map["email"] = _emailController.text.toString();
      map["password"] = _passwordController.text.toString();

      var response = await http.post(Uri.parse(link), body: map);
      var data = jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });
      print("bghfghfghfggggggggg${response.body}");

      print("access token is ${data["access_token"]}");

      if (data["access_token"] != null) {
        sharedPreferences.setString("token", data["access_token"]);
        print("saved token is ${sharedPreferences.getString("token")}");

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ),
                (route) => false);
      }
      else{
        showInToast("Email or Password doesn't match");
      }
    }catch(e){
      print(e);
    }
  }
  
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      blur: 0.5,
      opacity: 0.5,
      child: Scaffold(
          //backgroundColor: AppColor.kbgcolor,
          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topLeft,
            image: AssetImage(
              "assets/bg.png",
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 240.h),
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            height: ScreenUtil().screenHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  topLeft: Radius.circular(25.r)),
              color: Colors.white,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.black54,
                    thickness: 5.h,
                    indent: 150.w,
                    endIndent: 150.w,
                  ),
                  Center(
                      child: Text(
                    "Sign In",
                    style: myStyle(35.sp, AppColor.kbgcolor, FontWeight.bold),
                  )),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Welcome Back",
                    style: myStyle(30.sp, AppColor.kbgcolor, FontWeight.bold),
                  ),
                  Text(
                    "Glad to see you back my buddy",
                    style: myStyle(16.sp, Colors.black54, FontWeight.w400),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextField(
                    Controller: _emailController,
                    keyBoardType: TextInputType.emailAddress,
                    icon: Icons.email_outlined,
                    labelText: "Email",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: isObsecure,
                    obscuringCharacter: "•",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3.w,
                          color: AppColor.kbgcolor,
                        ),
                        borderRadius: BorderRadius.circular(50.0.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3.w,
                          color: AppColor.kbgcolor,
                        ),
                        borderRadius: BorderRadius.circular(50.0.r),
                      ),
                      labelText: "Password",
                      labelStyle:
                          myStyle(20.sp, AppColor.kbgcolor, FontWeight.bold),
                      prefixIcon: Icon(
                        Icons.lock_outlined,
                        color: AppColor.kbgcolor,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        icon: Icon(
                          isObsecure == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColor.kbgcolor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  customButton("Sign In", () {
                    if (_formkey.currentState!.validate()) {
                      getLogin();
                    } else {
                      showInToast("Enter all fields");
                    }
                  }),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                        },
                        child: Text(
                          "Sign Up",
                          style:
                              myStyle(20.sp, AppColor.kbgcolor, FontWeight.w700),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
