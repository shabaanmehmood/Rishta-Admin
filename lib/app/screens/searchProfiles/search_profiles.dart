import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rishta_admin/app/utils/cache_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';
import '../../widget/drawer_widget.dart';


class SearchProfiles extends StatefulWidget {
  const SearchProfiles({Key? key}) : super(key: key);

  @override
  _SearchProfilesState createState() => _SearchProfilesState();
}

class _SearchProfilesState extends State<SearchProfiles> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalWidgets globalWidgets = GlobalWidgets();
  CacheData cacheData = CacheData();
  TextEditingController txtCTL = TextEditingController();
  // ProposalListModel? proposalListModel;
  // ByCasteProposalsModel? byCasteProposalsModel;
  List<DocumentSnapshot> documentsByCastes = [];
  List<DocumentSnapshot> documentsByProfession = [];
  String selectedCasteType = '';
  String? gender = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: body(context),
      drawer: DrawerWidget(context),
      appBar: AppBar(
        backgroundColor: ColorsX.black,
        centerTitle: true,
        title: globalWidgets.myText(context, GlobalVariables.valueChosen == '' ? "Search" : GlobalVariables.valueChosen, ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, color: ColorsX.white,),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(), //Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  }

  body(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        // color:  const Color(0xff70b4ff).withOpacity(0.8),
        color:  const Color(0xff000000).withOpacity(0.8),
      ),
      child: customDesign(context),
    );
  }
  customDesign(BuildContext context) {
    return ListView(
      children: [
        globalWidgets.myText(context, 'Search Profile', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
        globalWidgets.myTextField(TextInputType.emailAddress, txtCTL, false, "Type Here" ),
        SizedBox(height: 10,),
        Visibility(
          visible: false,
          child:
        searchByID(context),),
        SizedBox(height: 10,),
        searchByPhone(context),
        SizedBox(height: 10,),
        searchByEmail(context),
      ],
    );
  }
  searchByID(BuildContext context,){
    return GestureDetector(
      onTap: (){

        if (txtCTL.text.trim().isEmpty) {
          GlobalWidgets.showErrorToast(
              context, "Text required", 'Please provide your text');
        }
        else{
          GlobalVariables.search_by = "id";
          GlobalVariables.search_value = txtCTL.text.toString();
          Get.toNamed(Routes.SEARCH_LIST);
        }
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
            child: globalWidgets.myText(context, "Search By ID", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
  searchByPhone(BuildContext context,){
    return GestureDetector(
      onTap: (){

        if (txtCTL.text.trim().isEmpty) {
          GlobalWidgets.showErrorToast(
              context, "Text required", 'Please provide your text');
        }
        else{
          GlobalVariables.search_by = "primary_phone";
          GlobalVariables.search_value = txtCTL.text.toString();
          Get.toNamed(Routes.SEARCH_LIST);
        }
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
            child: globalWidgets.myText(context, "Search By Phone", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
  searchByEmail(BuildContext context,){
    return GestureDetector(
      onTap: (){

        if (txtCTL.text.trim().isEmpty) {
          GlobalWidgets.showErrorToast(
              context, "Text required", 'Please provide your text');
        }
        else{
          GlobalVariables.search_by = "email";
          GlobalVariables.search_value = txtCTL.text.toString();
          Get.toNamed(Routes.SEARCH_LIST);
        }
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
            child: globalWidgets.myText(context, "Search By Email", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }
}
