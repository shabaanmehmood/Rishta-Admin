import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_pages.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../utils/global_widgets.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  GlobalWidgets globalWidgets = GlobalWidgets();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: ColorsX.yellowColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              GlobalVariables.isMyProfile = true;
              getId(context);
              Get.toNamed(Routes.EDIT_PROFILE_NEW);
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.edit,color: ColorsX.black),
                  globalWidgets.myText(context, "Edit Profile",
                      ColorsX.black, 0, 10, 0, 0, FontWeight.w700, 15),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(Routes.PROFILE_VIEWS);
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person_add_alt_1,color: ColorsX.black),
                  globalWidgets.myText(context, "Profile Views",
                      ColorsX.black, 0, 0, 0, 0, FontWeight.w700, 15),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              GlobalVariables.isMyProfile = true;
              getId(context);
              Get.toNamed(Routes.PROPOSALS_DETAIL);
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.app_settings_alt_outlined,color: ColorsX.black),
                  globalWidgets.myText(context, "My Profile",
                      ColorsX.black, 0, 0, 10, 0, FontWeight.w700, 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void getId(BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    GlobalVariables.my_ID = "${preferences.getString("id")}";
    GlobalVariables.idOfProposal = "${preferences.getString("id")}";
  }
}
