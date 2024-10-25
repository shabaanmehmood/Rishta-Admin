import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_pages.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../utils/global_widgets.dart';
import '../utils/size_config.dart';

class DrawerWidget extends StatelessWidget {
  GlobalWidgets globalWidgets = GlobalWidgets();

  DrawerWidget(BuildContext context);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth*.75,
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: ColorsX.black.withOpacity(0.8),
        ),
        child: Drawer(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: <Widget>[
              // _createHeader(),
              SizedBox(height: SizeConfig.screenHeight*.13,),
              _createDrawerItem(Icons.back_hand, 'Requests', context),
              _createDrawerItem(Icons.featured_play_list_outlined, 'Search Profiles', context),
              _createDrawerItem(Icons.featured_play_list_outlined, 'New Profiles', context),
              Divider(
                color: ColorsX.white,
              ),
              // _createDrawerItem(Icons.star_outline_sharp, 'Favourites', context),
              // _createDrawerItem(Icons.filter_list_alt, 'Filter', context),
              // Divider(
              //   color: ColorsX.white,
              // ),
              _createDrawerItem(Icons.privacy_tip_outlined, 'Privacy Policy', context),
              _createDrawerItem(Icons.photo_size_select_large_rounded, 'Terms & Conditions', context),
              Divider(
                color: ColorsX.white,
              ),
              _createDrawerItem(Icons.edit, 'Edit Profile', context),
              Divider(
                color: ColorsX.white,
              ),
              _createDrawerItem(Icons.app_settings_alt_outlined, 'My Profile', context),
              Divider(
                color: ColorsX.white,
              ),
              _createDrawerItem(Icons.person_add_alt_1, 'Profile Views', context),
              Divider(
                color: ColorsX.white,
              ),
              _createDrawerItem(Icons.delete, 'Delete Profile', context),
              Divider(
                color: ColorsX.white,
              ),
              _createDrawerItem(Icons.share_rounded, 'Share with Friends', context),
              _createDrawerItem(Icons.bug_report, 'Report an issue', context),
              Divider(
                color: ColorsX.white,
              ),
              _createDrawerItem(Icons.logout, 'Logout', context),
              Divider(
                color: ColorsX.white,
              ),
              // ListTile(
              //   title: Text('Powered by Epopiah', style: TextStyle(color: ColorsX.white),),
              //   onTap: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _createDrawerItem(IconData icon, String text, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if(text=='Filter'){

          Get.toNamed(Routes.FILTER_SCREEN);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='Edit Profile'){

          GlobalVariables.isMyProfile = true;
          getId(context);
          Get.toNamed(Routes.EDIT_PROFILE_NEW);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text== "Privacy Policy"){
          Get.back();
          GlobalVariables.webView_url = "http://rishtaaasan.000webhostapp.com/privacy_policy.html";
          Get.toNamed(Routes.PRIVACY_POLICY);
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text== "Terms & Conditions"){
          Get.back();
          GlobalVariables.webView_url = "http://rishtaaasan.000webhostapp.com/terms.html";
          Get.toNamed(Routes.TERMS_CONDITIONS);
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='Search Profiles'){

          Get.toNamed(Routes.EDIT_PROFILE);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='New Profiles'){

          Get.toNamed(Routes.NEW_PROFILES);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='Report an issue'){

          Get.toNamed(Routes.EDIT_PROFILE);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='Favourites'){

          Get.toNamed(Routes.PROPOSALS_LIST);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='My Profile'){
          GlobalVariables.isMyProfile = true;
          Get.toNamed(Routes.PROPOSALS_DETAIL);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='Profile Views'){
          Get.toNamed(Routes.PROFILE_VIEWS);
          Get.back();
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='Requests'){
          Get.back();
          Get.toNamed(Routes.PENDING_REQUESTS);
        }
        if(text=='Delete Profile'){
          Get.toNamed(Routes.DELETE_PROFILE);
          // deleteProfileDialog(context);
          // Get.toNamed(Routes.FAMILY_INFORMATION);
        }
        if(text=='Share with Friends'){
          Get.back();
          Share.share('This is an amazing app to find best match for your marriage. You should at least try once by creating your profile. https://play.google.com/store/apps/details?id=com.epopiah.matrimonial_app');
        }
        if(text=='Logout'){
          logoutNow();
        }

      },
      child: Container(
         child: ListTile(
           dense: true,
           leading: Icon(icon, color: ColorsX.black,),
           title: globalWidgets.myText(context, text, ColorsX.black, 0, 2, 0, 0, FontWeight.w600, 16),
           onTap: () async {
             if(text == "Filter"){
               Get.back();
               Get.toNamed(Routes.FILTER_SCREEN);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Privacy Policy"){
               Get.back();
               GlobalVariables.webView_url =("http://rishtaaasan.000webhostapp.com/privacy_policy.html");
               Get.toNamed(Routes.PRIVACY_POLICY);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Terms & Conditions"){
               Get.back();
               GlobalVariables.webView_url = ("http://rishtaaasan.000webhostapp.com/terms.html");
               Get.toNamed(Routes.TERMS_CONDITIONS);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Edit Profile"){
               Get.back();
               GlobalVariables.isMyProfile = true;
               getId(context);
               Get.toNamed(Routes.EDIT_PROFILE_NEW);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text=='Requests'){
               Get.back();
               Get.toNamed(Routes.PENDING_REQUESTS);
             }
             if(text== "Search Profiles"){
               Get.back();
               Get.toNamed(Routes.SEARCH_PROFILES);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "New Profiles"){
               Get.back();
               Get.toNamed(Routes.NEW_PROFILES);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Profile Views"){
               Get.back();
               Get.toNamed(Routes.PROFILE_VIEWS);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Report an issue"){
               Get.back();
               Get.toNamed(Routes.EDIT_PROFILE);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Favourites"){
               Get.back();
               Get.toNamed(Routes.PROPOSALS_LIST);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "My Profile"){
               Get.back();
               GlobalVariables.isMyProfile = true;
               getId(context);
               Get.toNamed(Routes.PROPOSALS_DETAIL);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text=='Delete Profile'){
               Get.toNamed(Routes.DELETE_PROFILE);
               // deleteProfileDialog(context);
               // Get.toNamed(Routes.FAMILY_INFORMATION);
             }
             if(text== "Share with Friends"){
               Get.back();
               Share.share('This is an amazing app to find best match for your marriage. You should at least try once by creating your profile. https://play.google.com/store/apps/details?id=com.epopiah.matrimonial_app');
             }
             if(text== "Logout"){

               SharedPreferences prefs = await SharedPreferences.getInstance();
               prefs.setString('id', '');
               prefs.setString('caste', '');
               prefs.setString('subcaste', '');
               prefs.setString('religion', '');
               prefs.setString('sect', '');
               prefs.setString('account_created_at', '');
               prefs.setString('mother_tongue', '');
               prefs.setString('phone', '');
               prefs.setString('gender', '');
               Get.back();
               Get.toNamed(Routes.LOGIN_SCREEN);
             }
           },
         ),
      ),
    );
  }

  _createHeader() {
    return Container(
      height: SizeConfig.screenHeight*.25,
      child: Stack(
        children: [
          Container(
            color: ColorsX.black.withOpacity(0.8),
          ),
        ],
      ),
    );
  }

  void getId(BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    GlobalVariables.idOfProposal = "${preferences.getString("id")}";
  }

   logoutNow() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', '');
    prefs.setString('caste', '');
    prefs.setString('subcaste', '');
    prefs.setString('religion', '');
    prefs.setString('sect', '');
    prefs.setString('account_created_at', '');
    prefs.setString('mother_tongue', '');
    prefs.setString('phone', '');
    prefs.setString('gender', '');
    Get.back();
    Get.toNamed(Routes.LOGIN_SCREEN);
  }

  deleteProfileDialog(BuildContext context) {
    getId(context);
    return AwesomeDialog(
        context: context,
        animType: AnimType.leftSlide,
        headerAnimationLoop: false,
        dialogType: DialogType.success,
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        closeIcon: Container(),
        // closeIcon: IconButton(icon : Icon(Icons.close, color: ColorsX.light_orange,),onPressed: () {
        //   Get.back();
        //   // Get.toNamed(Routes.LOGIN_SCREEN);
        // },),
        showCloseIcon: true,
        title: 'Are you sure to delete your profile permanently?',
        desc:
        'This will delete your profile permanently. After this you cannot be able to view other profiles.',// \n Save or remember ID to Log In' ,
        btnCancelOnPress: (){},
        btnCancelColor: ColorsX.red_danger,
        btnCancelIcon: Icons.cancel,
        btnOkOnPress: () {
          debugPrint('OnClcik');
          deleteProfileNow();
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        })
      ..show();
  }

   deleteProfileNow() async {

     GlobalWidgets.showProgressLoader("Please Wait");
     await FirebaseFirestore.instance.collection('candidates')
         .doc(GlobalVariables.idOfProposal).delete();
     GlobalWidgets.hideProgressLoader();
     logoutNow();
   }
}