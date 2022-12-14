import 'package:ecommerce/custom-http/custom_http.dart';
import 'package:ecommerce/model/ProductModel.dart';
import 'package:flutter/material.dart';
class ProductProvider with ChangeNotifier{
  List<ProductModel> productList = [];

  getProductData() async{
    productList = await CustomHttpRequest.getProductApi();
    notifyListeners();
  }
}