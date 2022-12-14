import 'package:ecommerce/providers/category_provider.dart';
import 'package:ecommerce/providers/order_provider.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/providers/profile_provider.dart';
import 'package:ecommerce/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => OrderProvider(),),
            ChangeNotifierProvider(create: (context) => CategoryProvider(),),
            ChangeNotifierProvider(create: (context) => ProductProvider(),),
            ChangeNotifierProvider(create: (context) => ProfileProvider(),),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}


