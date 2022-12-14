import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/providers/order_provider.dart';
import 'package:ecommerce/widgets/common_widget.dart';

import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrderProvider>(context, listen: false).getOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final allOrderList =  Provider.of<OrderProvider>(context).allOrderList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kbgcolor,
        elevation: 0,
        title: Text(
          "Order",
          style: TextStyle(color: Colors.white, fontSize: 26.sp),
        ),
        centerTitle: true,
      ),
      body: allOrderList.isEmpty? spinkit : Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: allOrderList.length,
                itemBuilder: (context, index) {
                  var icon =
                      allOrderList[index].orderStatus!.orderStatusCategory!.id;
                  return Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 15.h,
                            left: 15.w,
                            right: 15.w,
                            bottom: 15.h),
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: const Offset(
                                5.0,
                                5.0,
                              ), //Offset
                              blurRadius: 10.0,
                              spreadRadius: 2.0,
                            ), //BoxShadow
                            BoxShadow(
                              color: Colors.white,
                              offset: const Offset(0.0, 0.0),
                              blurRadius: 0.0,
                              spreadRadius: 0.0,
                            ), //BoxShadow
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          icon == 1
                                              ? Icons.check_box_outline_blank
                                              : icon == 2
                                              ? Icons.check_box_outlined
                                              : Icons.check_box,
                                          color: icon == 1
                                              ? Colors.blue
                                              : icon == 2
                                              ? Colors.teal
                                              : Colors.green,
                                        ),
                                        Text(
                                            "Order Id: " +
                                                allOrderList[index].id
                                                    .toString(),
                                            style: myStyle(
                                                16.sp,
                                                Colors.cyan,
                                                FontWeight.w700)),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Name: " +
                                                allOrderList[index]
                                                    .user!.name
                                                    .toString(),
                                            style: myStyle(
                                                14.sp,
                                                Colors.teal,
                                                FontWeight.w700)),

                                        Text(
                                            "Price: " +
                                                allOrderList[index].price
                                                    .toString(),
                                            style: myStyle(
                                                16.sp,
                                                AppColor.kbgcolor,
                                                FontWeight.w700)),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CircleAvatar(
                                          backgroundColor:
                                          AppColor.kbgcolor,
                                          child: Text(
                                              allOrderList[index].quantity
                                                  .toString(),
                                              style: myStyle(
                                                  16.sp,
                                                  Colors.white,
                                                  FontWeight.w700)),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
