import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/screens/nav_bar/bottom_navbar_pages/category_page.dart';
import 'package:ecommerce/screens/nav_bar/bottom_navbar_pages/order_page.dart';
import 'package:ecommerce/screens/nav_bar/bottom_navbar_pages/product_page.dart';
import 'package:ecommerce/screens/nav_bar/bottom_navbar_pages/profile_page.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  final pages = [OrderPage(), CategoryPage(), ProductPage(), ProfilePage()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.withOpacity(0.2),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: myStyle(16.sp, Colors.white),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            label: "Order",
            icon: Icon(Icons.shopping_cart_rounded),
            backgroundColor: AppColor.kbgcolor,
          ),
          BottomNavigationBarItem(
            label: "Category",
            icon: Icon(Icons.category),
            backgroundColor: AppColor.kbgcolor,
          ),
          BottomNavigationBarItem(
            label: "Product",
            icon: Icon(Icons.bookmark_border),
            backgroundColor: AppColor.kbgcolor,
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
            backgroundColor: AppColor.kbgcolor,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

      body: pages[_currentIndex],
    );
  }
}
