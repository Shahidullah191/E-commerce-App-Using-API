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
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? categoryType;
  TextEditingController nameController = TextEditingController();
  TextEditingController originalPriceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController discountTypeController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    super.initState();
  }
  bool isLoading = false;
  uploadProduct() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
      String uriLink = "${baseUrl}product/store";
      var request = http.MultipartRequest("POST", Uri.parse(uriLink));
      request.headers.addAll(await CustomHttpRequest.getHeaderWithToken());
      request.fields["name"] = nameController.text.toString();
      request.fields["category_id"] = categoryType.toString();
      request.fields["quantity"] = quantityController.text.toString();
      request.fields["original_price"] = originalPriceController.text.toString();
      request.fields["discounted_price"] =
          discountPriceController.text.toString();
      request.fields["discount_type"] = "fixed";
      var photo = await http.MultipartFile.fromPath("image",image!.path);
      request.files.add(photo);
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
        showInToast("Product Uploaded Successfully");

        Navigator.of(context).pop();
      } else {
        showInToast("Something wrong. please try again..");
      }
    }
  }
  List<CategoryModel> categoryList = [];

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    originalPriceController.dispose();
    discountPriceController.dispose();
    discountTypeController.dispose();
    quantityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    categoryList = Provider.of<CategoryProvider>(context).categoryList;
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading==true,
        opacity: 0.5,
        blur: 0.5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.kbgcolor,
            elevation: 0,
            title: Text(
              "Add Product",
              style: TextStyle(color: Colors.white, fontSize: 26.sp),
            ),
            centerTitle: true,
          ),
          body: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15.h),
                      decoration: BoxDecoration(
                          color: AppColor.kbgcolor,
                          border: Border.all(color: Colors.grey, width: 0.2),
                          borderRadius: BorderRadius.circular(12.r)),
                      height: 60.h,
                      child: Center(
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 30.w, color: Colors.white,
                          ),
                          decoration: InputDecoration.collapsed(hintText: ''),
                          value: categoryType,
                          hint: Text(
                            'Select Category',
                            overflow: TextOverflow.ellipsis,
                            style: myStyle(
                                16.sp,
                                Colors.white,
                                FontWeight.w700),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              categoryType = newValue;
                              print("my Category is $categoryType");

                              // print();
                            });
                          },
                          validator: (value) =>
                          value == null ? 'field required' : null,
                          items: categoryList.map((item) {
                            return   DropdownMenuItem(
                              child:   Text(
                                "${item.name}",
                                style: myStyle(
                                    16.sp,
                                    Colors.cyan,
                                    FontWeight.w700),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              value: item.id.toString(),
                            );
                          }).toList() ?? [],
                        ),
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
                                    "UPLOAD",
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
                      padding:  EdgeInsets.symmetric(vertical: 15.h),
                      child: CustomTextField(
                        Controller: nameController,
                        labelText: "Enter Product Name",
                        icon: Icons.drive_file_rename_outline_rounded,
                      ),
                    ),
                    CustomTextField(
                      Controller: originalPriceController,
                      labelText: "Enter Product Price",
                      icon: Icons.price_check,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15.h),
                      child: CustomTextField(
                        Controller: discountPriceController,
                        labelText: "Enter Discount Price",
                        icon: Icons.price_check,
                      ),
                    ),
                    CustomTextField(
                      Controller: quantityController,
                      labelText: "Enter Product Quantity",
                      icon: Icons.production_quantity_limits,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: customButton("Add Product", () {
                        uploadProduct();
                      }),
                    )
                  ],
                ),
              )),
        ),
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
}
