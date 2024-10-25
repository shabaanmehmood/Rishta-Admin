import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';

class EditProfileNew extends StatefulWidget {
  const EditProfileNew({Key? key}) : super(key: key);

  @override
  _EditProfileNewState createState() => _EditProfileNewState();
}

class _EditProfileNewState extends State<EditProfileNew> {
  GlobalWidgets globalWidgets = GlobalWidgets();
  // ProposalDetailModel? proposalDetailModel;
  DocumentSnapshot? documentSnapshot;
  Map<String, dynamic>? fetchDoc;
  Map<String, dynamic>? myProfileDoc;
  String addedToFavourite = '';
  TextEditingController issueDescriptionCtl = new TextEditingController();
  TextEditingController txtCtl = new TextEditingController();
  var blockedUsers = [];
  String age = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
      appBar: AppBar(
        backgroundColor: ColorsX.black,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
        title: globalWidgets.myText(context, "Edit Profile", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
      ),
    );
  }

  body(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              // color:  const Color(0xff70b4ff).withOpacity(0.8),
              color:  const Color(0xffF3F5F5).withOpacity(0.8),
            ),
          ),
          listViewContent(context),
        ],
      ),
    );
  }

  listViewContent(BuildContext context) {
    // String professiontemp = '${proposalDetailModel?.serverResponse.basicDetails.profession.replaceAll('[', '')}';
    // String profession = professiontemp.replaceAll(']', '');
    // String requiredprofessiontemp = '${proposalDetailModel?.serverResponse.demands.professionDemand.replaceAll('[', '')}';
    // String professionRequired = requiredprofessiontemp.replaceAll(']', '');
    // String requiredHousePossessiontemp = '${proposalDetailModel?.serverResponse.demands.housingDemandPossession.replaceAll('[', '')}';
    // String housePossession = requiredHousePossessiontemp.replaceAll(']', '');
    // String requiredHouseLocationtemp = '${proposalDetailModel?.serverResponse.demands.housingDemandLocation.replaceAll('[', '')}';
    // String location = requiredHouseLocationtemp.replaceAll(']', '');
    // String professiontemp = '${fetchDoc?['profession'].replaceAll('[', '')}';
    // String professiontemp = '${fetchDoc?['profession']}';
    // String professions = professiontemp.replaceAll(']', '');
    // String profession = professions.replaceAll('[', '');
    // // String requiredprofessiontemp = '${fetchDoc?['profession_demand'].replaceAll('[', '')}';
    // String requiredprofessiontemp = '${fetchDoc?['profession_demand']}';
    // String professionRequirement = requiredprofessiontemp.replaceAll(']', '');
    // String professionRequired = professionRequirement.replaceAll('[', '');
    // String requiredHousePossessiontemp = '${fetchDoc?['housing_demand_possession'].replaceAll('[', '')}';
    // String housePossession = requiredHousePossessiontemp.replaceAll(']', '');
    // String requiredHouseLocationtemp = '${fetchDoc?['housing_demand_location'].replaceAll('[', '')}';
    // String location = requiredHouseLocationtemp.replaceAll(']', '');

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      // child: proposalDetailModel == null ? Container() : ListView(
      // child: documentSnapshot == null ? Container() : ListView(
      child: ListView(
        children: [
          // addToFavourites(context),

          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.infoCircle, color: ColorsX.subBlack,)),
              ),
              globalWidgets.myText(context, 'Edit Profile', ColorsX.subBlack, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          globalWidgets.myText(context, 'Click any option to edit', ColorsX.black, 20, 10, 0, 0, FontWeight.w700, 15),

          // heading(context, 'ID', '${proposalDetailModel?.serverResponse.basicDetails.id}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.id}'
          //     ,ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'ID', '${GlobalVariables.idOfProposal}'
          //     ,ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Profile Created By', '${proposalDetailModel?.serverResponse.basicDetails.profileCreatedBy}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.profileCreatedBy}'
          //     ,ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Profile Created By', '${fetchDoc?['profile_created_by']}'
          //     ,ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15,),
          // heading(context, 'Name', '${proposalDetailModel?.serverResponse.others.name}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.others.name}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Name', '${fetchDoc?['name']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15, ),
          // heading(context, 'Caste', '${proposalDetailModel?.serverResponse.basicDetails.caste}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.caste}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          SizedBox(height: 20,),
          profileSegments(context),
        ],
      ),
    );
  }

  profileSegments(BuildContext context) {

    return ListView.separated(
        itemCount: GlobalWidgets.profileSegmentsList.length,
        separatorBuilder: (context, index) =>Divider(height: 1, color: ColorsX.light_orange),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              // GlobalVariables.isCaste = false;
              // print(GlobalWidgets.profileSegmentsList[index]);
              // GlobalVariables.valueChosen = GlobalWidgets.profileSegmentsList[index];
              if(index == 0)
                Get.toNamed(Routes.BASIC_INFORMATION_EDIT);
              else if(index == 1)
                Get.toNamed(Routes.FAMILY_INFORMATION_EDIT);
              else if(index == 2)
                Get.toNamed(Routes.REQUIRED_PROPOSAL_EDIT);
              else{}
            },
            child: ListTile(
              // leading: CircleAvatar(
              //   backgroundColor: ColorsX.yellowColor,
              //   child: globalWidgets.myText(context, (index+1).toString(), ColorsX.black, 0, 0, 0, 0, FontWeight.w400, 12),
              // ),
              title: globalWidgets.myText(context, GlobalWidgets.profileSegmentsList[index], ColorsX.subBlack, 0, 0, 0, 0, FontWeight.w700, 15),
              subtitle: globalWidgets.myText(context, index == 0 ?
              "Religion, Caste, Profession and Qualification" : index == 1 ?
              "Parents, Siblings and More" : index == 2 ?
              "Your demands for spouse" : ""
                  , ColorsX.black, 0, 0, 0, 0, FontWeight.w400, 13),

              trailing: GestureDetector(
                onTap: (){
                  // GlobalVariables.isCaste = false;
                  // print(GlobalWidgets.profileSegmentsList[index]);
                  // GlobalVariables.valueChosen = GlobalWidgets.profileSegmentsList[index];
                  if(index == 0)
                    Get.toNamed(Routes.BASIC_INFORMATION_EDIT);
                  else if(index == 1)
                    Get.toNamed(Routes.FAMILY_INFORMATION_EDIT);
                  else if(index == 2)
                    Get.toNamed(Routes.REQUIRED_PROPOSAL_EDIT);
                  else{}
                },
                child: Container(
                  height: 25,
                  width: 25,
                  child: Icon(Icons.edit, color: ColorsX.white,),
                ),
              ),
            ),
          );
        });

  }

  ageCalculate(String birthDateString) {
    try {
      print(birthDateString);
      String year = birthDateString.split("/")[2];
      DateTime today = DateTime.now();
      int hisAgeValue = int.parse(year);
      int yrsOld = today.year - hisAgeValue;
      age = yrsOld.toString() + " yrs";
      return yrsOld.toString() + " yrs";
    }
    catch(e){
      age = '0 yrs';
      return age;
    }
  }

  heightCalculate(String height) {
    String newHeight = height;
    if(height.contains('@')){
      newHeight = height.replaceAll("@", "\u0027");
    }
    return newHeight;
  }

  accountCreated(String dateTime) {
    int days = 0;
    DateTime today = DateTime.now();
    DateTime incoming = DateTime.parse(dateTime);
    days = today.difference(incoming).inDays;
    if(days < 1){
      days = today.difference(incoming).inHours;
      return days.toString()+ ' hours ago';
    }else{
      return days.toString() + ' days ago';
    }
  }
  addToFavourites(BuildContext context){
    return GestureDetector(
      onTap: (){
        setState(() {
          addedToFavourite == "Yes" ? "No" : "Yes";
        });
      },
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 10, right: 10),
              child: IconButton(icon : Icon(Icons.star_outline_sharp, color:  addedToFavourite == "Yes" ? Colors.red : ColorsX.white,), onPressed: () { setState(() {
                addedToFavourite == "Yes" ? addedToFavourite = "No" : addedToFavourite = "Yes";
              }); },),
            ),
          ),
          globalWidgets.myText(context, addedToFavourite == "Yes" ?"Added to Favourites" : "Add to Favourites", ColorsX.white, 15, 0, 10, 0, FontWeight.w400, 14)
        ],
      ),
    );
  }

  reportUser(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.red_danger,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: ColorsX.white,
            blurRadius: 4,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      child: Visibility(
        visible: GlobalVariables.isMyProfile == true ? false : true,
        child: GestureDetector(
          onTap: (){
            // dialNumber(context, "${proposalDetailModel?.serverResponse.basicDetails.primaryPhone}");
            reportDialog(context);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: ColorsX.light_orange)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Icon(Icons.face_unlock_outlined, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Report User", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  reportAndBlockUser(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.red_danger,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: ColorsX.white,
            blurRadius: 4,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      child: Visibility(
        visible: GlobalVariables.isMyProfile == true ? false : true,
        child: GestureDetector(
          onTap: () {
            blockThisUserNow(context);
            // dialNumber(context, "${proposalDetailModel?.serverResponse.basicDetails.primaryPhone}");
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: ColorsX.light_orange)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Icon(Icons.block, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Block User", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  successDialog(String title, String description) {
    GlobalWidgets.hideProgressLoader();
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
        title: title,
        desc:
        description,// \n Save or remember ID to Log In' ,
        btnOkOnPress: () {
          debugPrint('OnClcik');
          Get.back();
          // Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        })
      ..show();
  }

  buttonsLayout(BuildContext context, ){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Visibility(
            visible: false,
            child: GestureDetector(
              onTap: (){

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: new Text("This feature is not available yet")));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: ColorsX.light_orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: (FaIcon(FontAwesomeIcons.rocketchat, color: ColorsX.white,)),
                      ),
                      Container(
                        child: globalWidgets.myText(context, "Chat", ColorsX.white, 5, 0, 0, 0, FontWeight.w900, 17),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: GlobalVariables.isMyProfile == true ? false : true,
            child: GestureDetector(
              onTap: (){
                // dialNumber(context, "${proposalDetailModel?.serverResponse.basicDetails.primaryPhone}");
                dialNumber(context, '${fetchDoc?['primary_phone']}');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: ColorsX.light_orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: (FaIcon(FontAwesomeIcons.phone, color: ColorsX.white,)),
                      ),
                      Container(
                        child: globalWidgets.myText(context, "Call", ColorsX.white, 5, 0, 0, 0, FontWeight.w900, 17),
                      ),
                      Container(
                        child: globalWidgets.myText(context, '${fetchDoc?['primary_phone']}', ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10,),
          Visibility(
            visible: GlobalVariables.isMyProfile == true ? false : true,
            child: GestureDetector(
              onTap: (){
                // dialNumber(context, "${proposalDetailModel?.serverResponse.basicDetails.primaryPhone}");
                dialNumber(context, '${fetchDoc?['secondary_phone']}');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: ColorsX.light_orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: (FaIcon(FontAwesomeIcons.phone, color: ColorsX.white,)),
                      ),
                      Container(
                        child: globalWidgets.myText(context, "Call", ColorsX.white, 5, 0, 0, 0, FontWeight.w900, 17),
                      ),
                      Container(
                        child: globalWidgets.myText(context, '${fetchDoc?['secondary_phone']}', ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  dialNumber(BuildContext context, String number) async {
    var url = "tel:$number";
    try{
      await launch(url);
    }
    catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("Problem Occured. Please Try Again")));
      throw 'Could not launch $url';
    }
  }

  heading(BuildContext context, String text,String detail, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return GestureDetector(
      onTap: (){
        _displayTextInputDialog(context, text, detail);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: globalWidgets.myText(context, text, colorsX, top, left, right, bottom, fontWeight, fontSize)),
          Expanded(child: globalWidgets.myText(context, detail, ColorsX.white.withOpacity(0.9), top, left, right, bottom, fontWeight, fontSize),
          ),
        ],
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context, String text, String detail) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: (globalWidgets.myText(context, text, ColorsX.black, 0,
              0, 0, 0, FontWeight.w700, 18)),
          content: Container(
            height: SizeConfig.screenHeight * .10,
            child: Column(
              children: [
                globalWidgets.myText(context, detail, ColorsX.black, 0,
                    0, 0, 0, FontWeight.w700, 18),
                TextField(
                  controller: txtCtl,
                  decoration: InputDecoration(hintText: "Text Field in Dialog"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                print(txtCtl.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  dialogWithField(BuildContext context, String title, String description){
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        headerAnimationLoop: true,
        title: '$title',
        desc:
        'Please try again with valid email and password',
        btnCancelOnPress: (){},
        btnCancelColor: ColorsX.red_danger,
        btnCancelIcon: Icons.cancel,
        btnOkOnPress: () {},
        btnOkIcon: Icons.done,
        btnOkColor: ColorsX.greenish)
      ..show();
  }

  void loadDetails() async{

    GlobalWidgets.showProgressLoader("Please Wait");
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('candidates')
        .doc(GlobalVariables.idOfProposal).get();
    if(snapshot.exists){
      fetchDoc = snapshot.data() as Map<String, dynamic>?;
      GlobalWidgets.hideProgressLoader();
      var listOfBlockedPeople = '${fetchDoc?['is_blocked_by']}';
      if(listOfBlockedPeople.contains(GlobalVariables.my_ID)){
        errorDialogForBlocked(context);
      }
      else {
        setState(() {
          documentSnapshot = snapshot;
        });
      }
      if(GlobalVariables.isMyProfile == true) {}
      else{
        // profileViewsOthers();
      }
    }
    else{
      GlobalWidgets.hideProgressLoader();
      errorDialog(context);
    }
//     var _apiService = ApiService();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     Map<String, dynamic> userInfo = Map();
//
//     userInfo['id'] = GlobalVariables.idOfProposal;
//
//     GlobalWidgets.showProgressLoader("Please Wait");
//     GlobalWidgets.hideKeyboard(context);
//     final res = await _apiService.proposalDetail(apiParams: userInfo);
//     GlobalWidgets.hideProgressLoader();
//     if (res is ProposalDetailModel) {
//       setState(() {
//         proposalDetailModel = res;
//       });
//       // ageCalculate("${proposalDetailModel?.serverResponse.basicDetails.dob}");
//       print('hurrah');
//       // Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
// //show success dialog
// //        successDialog(GlobalVariables.signUpResponse);
//     }
//     else {
//       errorDialog(context);
//     }
  }
  reportDialog(BuildContext context) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        headerAnimationLoop: true,
        title: "No proposal Found",
        desc:
        'Please try again',
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              globalWidgets.myText(context, "By clicking the OK button, you accept that you are filing a complaint against this profile and decided to block it."'\n'+ 'We assure you that we shall take a notice regarding the detail you will provide us by describing the reason to report.',
                  ColorsX.black.withOpacity(0.6), 0, 0, 0, 0, FontWeight.w400, 10),
              SizedBox(
                height: 10,
              ),
              // Material(
              //   elevation: 0,
              //   color: Colors.blueGrey.withAlpha(40),
              //   child: TextFormField(
              //     autofocus: true,
              //     keyboardType: TextInputType.multiline,
              //     minLines: 1,
              //     decoration: InputDecoration(
              //       border: InputBorder.none,
              //       labelText: 'Title',
              //       prefixIcon: Icon(Icons.text_fields),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Material(
                elevation: 0,
                color: Colors.blueGrey.withAlpha(40),
                child: TextFormField(
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  // maxLengthEnforced: true,
                  minLines: 2,
                  maxLines: null,
                  controller: issueDescriptionCtl,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.block),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AnimatedButton(
                  text: 'Close',
                  pressEvent: () {
                    Get.back();
                  })
            ],
          ),),
        btnOkOnPress: () {
          reportUserNow(context);
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  errorDialog(BuildContext context) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: true,
        title: "No proposal Found",
        desc:
        'Please try again',
        btnOkOnPress: () {
          Get.back();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
  errorDialogForBlocked(BuildContext context) {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        headerAnimationLoop: true,
        title: "No proposal Found",
        desc:
        'This profile is blocked by you',
        btnOkOnPress: () {
          Get.back();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }

  blockThisUserNow(BuildContext context) async {
    var listOfBlockedPeople = '${fetchDoc?['is_blocked_by']}';
    if(listOfBlockedPeople == '0'){
      var valueTobeAdd = [];
      valueTobeAdd.add(GlobalVariables.my_ID);
      GlobalWidgets.showProgressLoader("Please wait");
      CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
      await users
          .doc(GlobalVariables.idOfProposal)
          .update({'is_blocked_by': valueTobeAdd})
          .then((value) => successDialog("Blocked", 'This profile is blocked'))
          .catchError((error) => successDialog("Failed to block: ",'$error'));
    }
    else if(!listOfBlockedPeople.contains(GlobalVariables.my_ID)){
      var valueTobeAdd = [];
      valueTobeAdd.add(GlobalVariables.my_ID);
      for(int i = 0; i < listOfBlockedPeople.length; i++){
        valueTobeAdd.add(listOfBlockedPeople[i]);
      }
      GlobalWidgets.showProgressLoader("Please wait");
      CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
      await users
          .doc(GlobalVariables.idOfProposal)
          .update({'is_blocked_by': valueTobeAdd})
          .then((value) => successDialog("Blocked", 'This profile is blocked'))
          .catchError((error) => successDialog("Failed to block: ",'$error'));
    }
    else {
      var valueTobeAdd = [];
      valueTobeAdd.add(GlobalVariables.my_ID);
      debugPrint('already blocked');
    }
  }

  reportUserNow(BuildContext context) async {
    if(issueDescriptionCtl.text.isEmpty){
      GlobalWidgets.showErrorToast(
          context, "Issue detail required", 'This field is required. Please explain your issue.');
    }
    else{
      var listOfReportedPeople = '${fetchDoc?['is_reported_by']}';
      var listOfDetails = '${fetchDoc?['issue_detail']}';
      if(listOfReportedPeople == '0'){
        var valueTobeAdd = [];
        var detailTobeAdd = [];
        valueTobeAdd.add(GlobalVariables.my_ID);
        detailTobeAdd.add(issueDescriptionCtl.text);
        GlobalWidgets.showProgressLoader("Please wait");
        CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
        await users
            .doc(GlobalVariables.idOfProposal)
            .update({'is_reported_by': valueTobeAdd,
          "issue_detail" : detailTobeAdd})
            .then((value) => successDialog("Reported", 'Thank you for reporting issue. We shall investigate this issue according to your description. You can Block this user if you want.'))
            .catchError((error) => successDialog("Failed to report: ",'$error'));
      }
      else if(!listOfReportedPeople.contains(GlobalVariables.my_ID)){
        var valueTobeAdd = [];
        var detailTobeAdd = [];
        valueTobeAdd.add(GlobalVariables.my_ID);
        detailTobeAdd.add(issueDescriptionCtl.text);
        for(int i = 0; i < listOfReportedPeople.length; i++){
          valueTobeAdd.add(listOfReportedPeople[i]);
          detailTobeAdd.add(listOfDetails[i]);
        }
        GlobalWidgets.showProgressLoader("Please wait");
        CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
        await users
            .doc(GlobalVariables.idOfProposal)
            .update({'is_reported_by': valueTobeAdd,
          "issue_detail" : detailTobeAdd})
            .then((value) => successDialog("Reported", 'Thank you for reporting issue. We shall investigate this issue according to your description You can Block this user if you want.'))
            .catchError((error) => successDialog("Failed to report: ",'$error'));
      }
      else {
        successDialog("Reported", 'You have already reported this profile. We are investigating the issue according to your description. You can Block this user if you want.');
      }
    }
  }

  // addProfileViews() async {
  //   var profileViewsHis = '${fetchDoc?['profile_views_his']}';
  //   /**
  //    * updating the views of other user's profile as well
  //    */
  //   if(profileViewsHis == '0' || profileViewsHis.isEmpty
  //       || profileViewsHis == 'null' || profileViewsHis == "[]"){
  //
  //     try {
  //
  //
  //       List<Map<String, dynamic>> profileViewsOthers = [];
  //       Map<String, dynamic> myObject = {'name': '${myProfileDoc?['name']}',
  //         'id': GlobalVariables.my_ID,
  //         'profile_created_by': '${myProfileDoc?['profile_created_by']}',
  //         'qualification': '${myProfileDoc?['qualification']}'
  //       } ;
  //       profileViewsOthers.add(myObject);
  //       GlobalWidgets.showProgressLoader("Please wait");
  //       CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
  //       await users
  //           .doc(GlobalVariables.idOfProposal)
  //           .update({'profile_views_his': FieldValue.arrayUnion(profileViewsOthers)})
  //           .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
  //           .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
  //       apiCallForNotification();
  //     }
  //     on Exception catch(e) {
  //       print(e);
  //     }
  //
  //   }
  //   else if(!profileViewsHis.contains(GlobalVariables.my_ID)){
  //
  //
  //
  //     try {
  //
  //
  //       List<Map<String, dynamic>> profileViewsOthers = [];
  //       Map<String, dynamic> myObject = {'name': '${myProfileDoc?['name']}',
  //         'id': GlobalVariables.my_ID,
  //         'profile_created_by': '${myProfileDoc?['profile_created_by']}',
  //         'qualification': '${myProfileDoc?['qualification']}'
  //       } ;
  //       profileViewsOthers.add(myObject);
  //       GlobalWidgets.showProgressLoader("Please wait");
  //       CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
  //       await users
  //           .doc(GlobalVariables.idOfProposal)
  //           .update({'profile_views_his': FieldValue.arrayUnion(profileViewsOthers)})
  //           .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
  //           .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
  //       apiCallForNotification();
  //     }
  //     on Exception catch(e) {
  //       print(e);
  //     }
  //   }
  //   else if(profileViewsHis.contains(GlobalVariables.my_ID)){
  //     debugPrint('already contains');
  //   }
  // }

  // apiCallForNotification() async{
  //
  //   var _apiService = ApiService();
  //
  //   Map<String, dynamic> userInfo = Map();
  //
  //   userInfo['id'] = '${fetchDoc?['token']}';
  //   userInfo['name'] = '${myProfileDoc?['name']}';
  //   userInfo['fcm_id'] = GlobalVariables.my_ID;
  //
  //   GlobalWidgets.showProgressLoader("Please Wait");
  //   final res = await _apiService.sendNotification(apiParams: userInfo);
  //   GlobalWidgets.hideProgressLoader();
  //
  // }
  DialogForBackendNotificationAndUpdates(String message){
    debugPrint(message);
    GlobalWidgets.hideProgressLoader();
  }

  // profileViewsOthers() async {
  //
  //   /**
  //    * first we will update the views of the user who is viewing the profile
  //    */
  //
  //   GlobalWidgets.showProgressLoader("Please Wait");
  //   final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('candidates')
  //       .doc(GlobalVariables.my_ID).get();
  //   if(snapshot.exists) {
  //     myProfileDoc = snapshot.data() as Map<String, dynamic>?;
  //     GlobalWidgets.hideProgressLoader();
  //   }
  //   List<String> profileViewsOthers = [];
  //   var profiles = '${myProfileDoc?['profile_views_others']}';
  //   if(profiles.isEmpty || profiles == '0' || profiles == 'null' || profiles == "[]"){
  //     List<Map<String, dynamic>> profileViewsOthers = [];
  //     Map<String, dynamic> myObject = {'name': '${fetchDoc?['name']}',
  //       'id': GlobalVariables.idOfProposal,
  //       'profile_created_by': '${fetchDoc?['profile_created_by']}',
  //       'qualification': '${fetchDoc?['qualification']}'
  //     };
  //     profileViewsOthers.add(myObject);
  //     GlobalWidgets.showProgressLoader("Please wait");
  //     CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
  //     await users
  //         .doc(GlobalVariables.my_ID)
  //         .update({'profile_views_others': profileViewsOthers})
  //         .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
  //         .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
  //   }else if(!profiles.contains(GlobalVariables.idOfProposal)){
  //     try {
  //
  //       // String profiles2 = profiles1.replaceAll('[', '');
  //       // var ab = jsonDecode(profiles3).cast<String>().toList();
  //       // newList.addAll(ab);
  //       // newList.add(GlobalVariables.idOfProposal);
  //       // List<String> profileViewsOthers = [];
  //       // profileViewsOthers.addAll(newList);
  //
  //       List<Map<String, dynamic>> profileViewsOthers = [];
  //       Map<String, dynamic> myObject = {'name': '${fetchDoc?['name']}',
  //         'id': GlobalVariables.idOfProposal,
  //         'profile_created_by': '${fetchDoc?['profile_created_by']}',
  //         'qualification': '${fetchDoc?['qualification']}'
  //       } ;
  //       profileViewsOthers.add(myObject);
  //       GlobalWidgets.showProgressLoader("Please wait");
  //       CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
  //       await users
  //           .doc(GlobalVariables.my_ID)
  //           .update({'profile_views_others': FieldValue.arrayUnion(profileViewsOthers)})
  //           .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
  //           .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
  //     }
  //     on Exception catch(e) {
  //       print(e);
  //     }
  //   }
  //
  //   addProfileViews();
  //   // List<Map<String, dynamic>> valueTobeAdd = [];
  //   // valueTobeAdd.add('${myProfileDoc?['profile_views_others']}');
  //   //
  //   // if(profile1 == 0 || profile1.isEmpty){
  //   //   profileViewsOthers.add('0');
  //   // }
  //   // else
  //   //   valueTobeAdd.add('${myProfileDoc?['profile_views_others']}') ;
  //
  //   // String profiles1 = profileViewsOthers.replaceAll(']', '');
  //   // String profiles2 = profiles1.replaceAll('[', '');
  //
  //
  //
  //
  //
  //
  //
  //   // if(profileViewsOthers == '0' || profileViewsOthers.isEmpty){
  //   //   debugPrint('0 profile views others');
  //   //   debugPrint('myID '+GlobalVariables.my_ID);
  //   //   debugPrint('his ID '+GlobalVariables.idOfProposal);
  //   //   List<Map<String, dynamic>> valueTobeAdd = [];
  //   //   Map<String, dynamic> myObject = {'name': '${fetchDoc?['name']}',
  //   //     'id': GlobalVariables.idOfProposal} ;
  //   //   valueTobeAdd.add(myObject);
  //   //   GlobalWidgets.showProgressLoader("Please wait");
  //   //   CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
  //   //   await users
  //   //       .doc(GlobalVariables.my_ID)
  //   //       .update({'profile_views_others': valueTobeAdd})
  //   //       .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
  //   //       .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
  //   //
  //   // }
  //   // else if(!profileViewsOthers.contains(GlobalVariables.idOfProposal)){
  //   //   debugPrint('0 profile views others');
  //   //   debugPrint('myID '+GlobalVariables.my_ID);
  //   //   debugPrint('his ID '+GlobalVariables.idOfProposal);
  //   //
  //   //
  //   //
  //   //   for(int i=0; i< profileViewsOthers.length; i++){
  //   //     valueTobeAdd.add({'name': 'Shabaan',
  //   //       'id': profileViewsOthers[i]});
  //   //   }
  //   //   // valueTobeAdd.add(GlobalVariables.idOfProposal);
  //   //
  //   //   Map<String, dynamic> myObject = {'name': '${fetchDoc?['profile_created_by']}',
  //   //     'id': GlobalVariables.idOfProposal} ;
  //   //   valueTobeAdd.add(myObject);
  //   //
  //   //   GlobalWidgets.showProgressLoader("Please wait");
  //   //   CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
  //   //   await users
  //   //       .doc(GlobalVariables.my_ID)
  //   //       .update({'profile_views_others': valueTobeAdd})
  //   //       .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others not contains Updated'))
  //   //       .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others not contains Updated Error "+'$error'));
  //   // }
  //   // else if(profileViewsOthers.contains(GlobalVariables.idOfProposal)){
  //   //   debugPrint('already contains');
  //   // }
  //   // else{
  //   //
  //   // }
  // }
}
