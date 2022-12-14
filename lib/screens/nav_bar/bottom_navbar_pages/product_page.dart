import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/providers/product_provider.dart';
import 'package:ecommerce/screens/nav_bar/bottom_navbar_pages/navbar_related_others_page/add_product_page.dart';
import 'package:ecommerce/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductProvider>(context, listen: false).getProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductProvider>(context).productList;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kbgcolor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddProductPage()))
              .then((value) =>
              Provider.of<ProductProvider>(context, listen: false)
                  .getProductData());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: AppColor.kbgcolor,
        elevation: 0,
        title: Text(
          "Product",
          style: TextStyle(color: Colors.white, fontSize: 26.sp),
        ),
        centerTitle: true,
      ),
      body: productList.isEmpty
          ? spinkit
          : GridView.builder(
              padding: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
              shrinkWrap: true,
              itemCount: productList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.6.h,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0.w,
                  mainAxisSpacing: 10.0.w),
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 150.h,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12.r),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${imageUrl}${productList[index].image.toString()}"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        productList[index].name.toString(),
                        style: TextStyle(
                            color: AppColor.kbgcolor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),

                      Text("Quantity: "+
                        productList[index].stockItems![0].quantity.toString(),
                        style: TextStyle(
                            color: AppColor.kbgcolor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text("Price: "+
                          productList[index].price![0].originalPrice.toString(),
                        style: TextStyle(
                            color: AppColor.kbgcolor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      Text("Discount Price: "+
                          productList[index].price![0].discountedPrice.toString(),
                        style: TextStyle(
                            color: AppColor.kbgcolor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
