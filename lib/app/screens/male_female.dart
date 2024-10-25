import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rishta_admin/app/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_pages.dart';
import '../utils/colors.dart';
import '../utils/global_widgets.dart';
class MaleFemale extends StatelessWidget {
  GlobalWidgets globalWidgets = GlobalWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(context),
    );
  }
  body(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return false;
      },
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color:  const Color(0xff000000).withOpacity(0.8),
        // decoration: const BoxDecoration(
        //   color:  const Color(0xff969B9B).withOpacity(0.5),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * .12),
                  child: Image.asset('assets/images/logo.png', height: 80, width: 80,)),
            ),
            SizedBox(height: 50,),
            male(context),
            SizedBox(height: 50,),
            female(context),

            // Align(
            //   alignment: Alignment.center,
            //   child: myText(context, "Don't have an account ? Click to Register", ColorsX.white, 30, 10, 0, 10, FontWeight.w400, 18.0,),
            // ),
            // signUpButton(context),
            // Align(
            //   alignment: Alignment.topCenter,
            //   child: registerNowText(context,20,10,10,0),
            // ),
          ],
        ),
      ),
    );
  }

  male(BuildContext context,) {
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('gender', "Female");
        Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: ColorsX.light_orange,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: globalWidgets.myText(context, "Male Profiles", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
  female(BuildContext context,){
    return GestureDetector(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('gender', "Male");
        Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
      },
      child: Container(
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: ColorsX.light_orange,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: globalWidgets.myText(context, "Female Profiles", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }


}
