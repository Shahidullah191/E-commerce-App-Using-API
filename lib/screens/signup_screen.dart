import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/screens/auth/login_screen.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isObsecure = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
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
                "Sign Up",
                style: myStyle(35.sp, AppColor.kbgcolor, FontWeight.bold),
              )),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "Welcome Buddy!",
                style: myStyle(30.sp, AppColor.kbgcolor, FontWeight.bold),
              ),
              Text(
                "Glad to see you my buddy",
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
              customButton("Sign Up", () {

              }),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                    },
                    child: Text(
                      "Sign In",
                      style: myStyle(20.sp, AppColor.kbgcolor, FontWeight.w700),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
