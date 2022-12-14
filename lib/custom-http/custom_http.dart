import 'dart:convert';

import 'package:ecommerce/model/ProductModel.dart';
import 'package:ecommerce/model/all_order_model.dart';
import 'package:ecommerce/model/category_model.dart';
import 'package:ecommerce/model/profile_model.dart';
import 'package:ecommerce/widgets/common_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomHttpRequest{

  static Future<Map<String, String>> getHeaderWithToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var header ={
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPreferences.getString("token")}',
    };
    print("Saved token is ${sharedPreferences.getString("token")}");
    return header;
  }

//All order Model get API.......................
  static Future<List<AllOrderModel>> getAllOrderApi() async {
    List<AllOrderModel> allOrderList = [];
    String link = "${baseUrl}all/orders";
    final response = await http.get(Uri.parse(link), headers: await CustomHttpRequest.getHeaderWithToken());

    var data = jsonDecode(response.body.toString());

    print("bghfghfghfggggggggg${response.body}");

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        allOrderList.add(AllOrderModel.fromJson(i));
      }
      return allOrderList;
    } else {
      return allOrderList;
    }
  }

  //All CategoryModel get API.......................
  static Future<List<CategoryModel>> getCategoryApi() async {
    List<CategoryModel> categoryList = [];
    String link = "${baseUrl}category";
    final response = await http.get(Uri.parse(link), headers: await CustomHttpRequest.getHeaderWithToken());

    var data = jsonDecode(response.body.toString());

    print("bghfghfghfggggggggg${response.body}");

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        categoryList.add(CategoryModel.fromJson(i));
      }
      return categoryList;
    } else {
      return categoryList;
    }
  }


  //All ProductModel get API.......................
  static Future<List<ProductModel>> getProductApi() async {
    List<ProductModel> productList = [];
    String link = "${baseUrl}products";
    final response = await http.get(Uri.parse(link), headers: await CustomHttpRequest.getHeaderWithToken());

    var data = jsonDecode(response.body.toString());

    print("bghfghfghfggggggggg${response.body}");

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        productList.add(ProductModel.fromJson(i));
      }
      return productList;
    } else {
      return productList;
    }
  }

  //All ProfileModel get API.......................
  static Future<List<ProfileModel>> getProfileApi() async {
    List<ProfileModel> profileList = [];
    String link = "${baseUrl}all/user";
    final response = await http.get(Uri.parse(link), headers: await CustomHttpRequest.getHeaderWithToken());

    var data = jsonDecode(response.body.toString());

    print("bghfghfghfggggggggg${response.body}");

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        profileList.add(ProfileModel.fromJson(i));
      }
      return profileList;
    } else {
      return profileList;
    }
  }
}
