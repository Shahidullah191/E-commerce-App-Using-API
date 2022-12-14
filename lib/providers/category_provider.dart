import 'package:ecommerce/custom-http/custom_http.dart';
import 'package:ecommerce/model/category_model.dart';
import 'package:flutter/material.dart';
class CategoryProvider with ChangeNotifier{
  List<CategoryModel> categoryList = [];

  getCategoryData() async{
    categoryList = await CustomHttpRequest.getCategoryApi();
    notifyListeners();
  }
}