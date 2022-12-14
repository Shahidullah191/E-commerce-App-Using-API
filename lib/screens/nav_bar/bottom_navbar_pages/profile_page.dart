import 'package:ecommerce/const/app_color.dart';
import 'package:ecommerce/model/profile_model.dart';
import 'package:ecommerce/providers/profile_provider.dart';
import 'package:ecommerce/widgets/common_widget.dart';
import 'package:ecommerce/widgets/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProfileProvider>(context, listen: false).getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileList = Provider.of<ProfileProvider>(context).profileList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kbgcolor,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 26.sp),
        ),
        centerTitle: true,
      ),

      body: profileList.isEmpty? spinkit :  Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: profileList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:  EdgeInsets.all(8.0.w),
                      child: ListTile(
                        tileColor: Colors.black12,
                        leading: CircleAvatar(
                          backgroundColor:
                          AppColor.kbgcolor,
                          child: Text(
                              profileList[index].id
                                  .toString(),
                              style: myStyle(
                                  16.sp,
                                  Colors.white,
                                  FontWeight.w700)),
                        ),
                        trailing: Text("User Name: "+
                            profileList[index].name
                                .toString(),
                            style: myStyle(
                                16.sp,
                                Colors.cyan,
                                FontWeight.w700)),
                      ),
                    );
                  },))
        ],
      ),
    );
  }
}
