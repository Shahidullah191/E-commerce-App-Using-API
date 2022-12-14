import 'package:ecommerce/custom-http/custom_http.dart';
import 'package:ecommerce/model/all_order_model.dart';
import 'package:flutter/material.dart';
class OrderProvider with ChangeNotifier{
  List<AllOrderModel> allOrderList = [];

  getOrderData() async{
    allOrderList = await CustomHttpRequest.getAllOrderApi();
    notifyListeners();
  }
}