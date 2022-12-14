import 'package:ecommerce/custom-http/custom_http.dart';
import 'package:ecommerce/model/profile_model.dart';
import 'package:flutter/material.dart';
class ProfileProvider with ChangeNotifier{
  List<ProfileModel> profileList = [];

  getProfileData() async{
    profileList = await CustomHttpRequest.getProfileApi();
    notifyListeners();
  }
}