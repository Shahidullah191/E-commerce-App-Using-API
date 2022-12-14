import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/providers/category_provider.dart';
import 'package:ecommerce/screens/nav_bar/bottom_navbar_pages/navbar_related_others_page/add_category_page.dart';
import 'package:ecommerce/widgets/common_widget.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<CategoryProvider>(context, listen: false).getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryList = Provider.of<CategoryProvider>(context).categoryList;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kbgcolor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddCategoryPage()))
              .then((value) =>
              Provider.of<CategoryProvider>(context, listen: false)
                  .getCategoryData());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: AppColor.kbgcolor,
        elevation: 0,
        title: Text(
          "Category",
          style: TextStyle(color: Colors.white, fontSize: 26.sp),
        ),
        centerTitle: true,
      ),
      body: categoryList.isEmpty
          ? spinkit
          : GridView.builder(
              padding: EdgeInsets.only(
                  top: 10.h, left: 10.w, right: 10.w, bottom: 10.h),
              shrinkWrap: true,
              itemCount: categoryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.h,
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
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.red,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${imageUrl}${categoryList[index].image}"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.r),
                                child: CircleAvatar(
                                    child: Image.network(
                                        "${imageUrl}${categoryList[index].icon}")),
                              )),
                        ],
                      ),
                      Text(
                        categoryList[index].name.toString(),
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
