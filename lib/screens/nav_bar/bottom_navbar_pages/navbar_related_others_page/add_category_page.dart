import 'dart:io';

import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/custom-http/custom_http.dart';
import 'package:ecommerce/model/category_model.dart';
import 'package:ecommerce/providers/category_provider.dart';
import 'package:ecommerce/widgets/common_widget.dart';
import 'package:ecommerce/widgets/custom_button.dart';
import 'package:ecommerce/widgets/custom_textfield.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({Key? key}) : super(key: key);

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  TextEditingController nameController = TextEditingController();

  bool isLoading = false;
  addCategory() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      String uriLink = "${baseUrl}category/store";
      var request = http.MultipartRequest("POST", Uri.parse(uriLink));
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      request.fields["name"] = nameController.text.toString();

      var photo = await http.MultipartFile.fromPath("image",image!.path);
      request.files.add(photo);

      var iconPhoto = await http.MultipartFile.fromPath("icon", icon!.path);
      request.files.add(iconPhoto);

      var response = await request.send();

      setState(() {
        isLoading = false;
      });
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("response body.......... ${responseString}");
      print(
          "Status code issss${response.statusCode} ${request.fields} ${request.files.toString()}");
      if (response.statusCode == 201) {
        showInToast("Category Added Successfully");

        Navigator.of(context).pop();
      } else {
        showInToast("Something wrong. please try again..");
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      opacity: 0.5,
      blur: 0.5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.kbgcolor,
          elevation: 0,
          title: Text(
            "Add Category",
            style: TextStyle(color: Colors.white, fontSize: 26.sp),
          ),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 15.h),
                    child: CustomTextField(
                      Controller: nameController,
                      labelText: "Enter Category Name",
                      icon: Icons.drive_file_rename_outline_rounded,
                    ),
                  ),
                  Stack(
                    //overflow: Overflow.visible,
                    children: [
                      Container(
                        height: 150.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        ),
                        child: image == null
                            ? InkWell(
                          onTap: () {
                            getImageFromGallery();
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: Colors.cyan,
                                  size: 40.w,
                                ),
                                Text(
                                  "UPLOAD IMAGE",
                                  style: myStyle(
                                      12.sp, Colors.cyan, FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        )
                            : Container(
                          height: 150.h,
                          width: 200.w,
                          child: Image.file(image!),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: width * 0.4,
                        child: Visibility(
                          visible: isImageVisible,
                          child: TextButton(
                            onPressed: () {
                              getImageFromGallery();
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50.r)),
                                  color: Colors.cyan,
                                  border: Border.all(
                                      color: Colors.cyan, width: 1.5.w)),
                              child: Center(
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Stack(
                      //overflow: Overflow.visible,
                      children: [
                        Container(
                          height: 150.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          ),
                          child: icon == null
                              ? InkWell(
                            onTap: () {
                              getIconFromGallery();
                            },
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: Colors.cyan,
                                    size: 40.w,
                                  ),
                                  Text(
                                    "UPLOAD ICON",
                                    style: myStyle(
                                        12.sp, Colors.cyan, FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          )
                              : Container(
                            height: 150.h,
                            width: 200.w,
                            child: Image.file(icon!),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: width * 0.4,
                          child: Visibility(
                            visible: isIconVisible,
                            child: TextButton(
                              onPressed: () {
                                getIconFromGallery();
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50.r)),
                                    color: Colors.cyan,
                                    border: Border.all(
                                        color: Colors.cyan, width: 1.5.w)),
                                child: Center(
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    child: Icon(Icons.edit),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  customButton("Add Category", () {
                    addCategory();
                  })
                ],
              ),
            )),
      ),
    );
  }

  File? image;
  final picker = ImagePicker();
  bool isImageVisible = false;

  Future getImageFromGallery() async {
    print('on the way of gallery');
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
        print('image found');
        print('${image!.path}');

      } else {
        print('No image found');
      }
    });
  }

  File? icon;
  final iconPicker = ImagePicker();
  bool isIconVisible = false;

  Future getIconFromGallery() async {
    print('on the way of gallery');
    final pickedIcon = await iconPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedIcon != null) {
        icon = File(pickedIcon.path);
        print('icon found');
        print('${icon!.path}');

      } else {
        print('No icon found');
      }
    });
  }
}
