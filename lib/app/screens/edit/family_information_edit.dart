import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_pages.dart';
import '../../utils/colors.dart';
import '../../utils/global_variables.dart';
import '../../utils/global_widgets.dart';
import '../../utils/size_config.dart';


class FamilyInformationEdit extends StatefulWidget {
  const FamilyInformationEdit({Key? key}) : super(key: key);

  @override
  _FamilyInformationEditState createState() => _FamilyInformationEditState();
}

class _FamilyInformationEditState extends State<FamilyInformationEdit> {
  GlobalWidgets globalWidgets = GlobalWidgets();
  String selectedTypeOfHousing = '';
  String selectedOwnershipOfHousing = '';
  String selectedGender = '';
  DateTime selectedDate = DateTime.now();
  String date = "";
  TextEditingController siblingsCtl = new TextEditingController();
  TextEditingController marriedBrothersCtl = new TextEditingController();
  TextEditingController unMarriedBrothersCtl = new TextEditingController();
  TextEditingController marriedSistersCtl = new TextEditingController();
  TextEditingController unMarriedSistersCtl = new TextEditingController();
  TextEditingController fathersOccupationCtl = new TextEditingController();
  TextEditingController qualificationCtl = new TextEditingController();
  TextEditingController occupationCtl = new TextEditingController();
  TextEditingController houseAreaCtl = new TextEditingController();
  TextEditingController myInformationCtl = new TextEditingController();

  bool isMotherALive = false;
  bool isFatherALive = false;

  static String motherTongueValue = "Mother Tongue";
  static String maslakValue = "Maslak";
  static String casteValue = "Caste";


  DocumentSnapshot? documentSnapshot;
  Map<String, dynamic>? fetchDoc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }


  @override
  Widget build(BuildContext context) {
    // siblingsCtl = new TextEditingController();
    // marriedBrothersCtl = new TextEditingController();
    // marriedSistersCtl = new TextEditingController();
    // unMarriedBrothersCtl = new TextEditingController();
    // unMarriedSistersCtl = new TextEditingController();
    // fathersOccupationCtl = new TextEditingController();
    // qualificationCtl = new TextEditingController();
    // occupationCtl = new TextEditingController();
    // houseAreaCtl = new TextEditingController();
    // myInformationCtl = new TextEditingController();
    return Scaffold(
      body: body(context),
      appBar: AppBar(
        backgroundColor: ColorsX.black,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
        title: globalWidgets.myText(context, "Family Information", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
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
  listViewContent(BuildContext context){
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: documentSnapshot == null ? Container() : ListView(
        children: <Widget>[
          // steps(context),
          globalWidgets.myText(context, 'Update any thing and click the Button Edit Now below', ColorsX.black, 20, 10, 0, 0, FontWeight.w700, 15),
          globalWidgets.myText(context, 'Provide your family information', ColorsX.subBlack5, 10, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Major family information', ColorsX.black, 0, 10, 0, 0, FontWeight.w700, 16),
          globalWidgets.myText(context, 'Information about parents, siblings and house', ColorsX.black, 3, 10, 0, 0, FontWeight.w400, 13),
          MotherIsAlive(context),
          FatherIsAlive(context),
          //
          // Container(
          //   margin: EdgeInsets.only(top: 15),
          //   child: Divider(
          //     height: 1,
          //     thickness: 1,
          //     color: ColorsX.greytext,
          //   ),
          // ),
          globalWidgets.myText(context, 'Siblings information', ColorsX.black, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Number of Siblings', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Total number of siblings of the candidate', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          globalWidgets.myTextFieldEdit(TextInputType.number,siblingsCtl, false, "Siblings" ),
          globalWidgets.myText(context, 'Married Brothers', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Married brother of the candidate', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          globalWidgets.myTextFieldEdit(TextInputType.number, marriedBrothersCtl, false, "Married Brothers" ),
          globalWidgets.myText(context, 'Married Sisters', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Married sisters of the candidate', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          globalWidgets.myTextFieldEdit(TextInputType.number, marriedSistersCtl, false, "Married Sisters" ),
          globalWidgets.myText(context, 'Unmarried Brothers', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Unmarried brothers of the candidate', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          globalWidgets.myTextFieldEdit(TextInputType.number, unMarriedBrothersCtl, false, "Unmarried Brothers" ),
          globalWidgets.myText(context, 'Unmarried Sisters', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Unmarried sisters of the candidate', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          globalWidgets.myTextFieldEdit(TextInputType.number, unMarriedSistersCtl, false, "Unmarried Sisters" ),
          globalWidgets.myText(context, 'Father\u0027s Occupation', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Father\u0027s occupation of the candidate', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          globalWidgets.myTextFieldEdit(TextInputType.text, fathersOccupationCtl, false, "Father\u0027s occupation" ),

          globalWidgets.myText(context, 'Housing information', ColorsX.black, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Housing', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Provide housing information to strong your profile ', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          housingDetails(context, "Marla", "Kanal","Own", "Rent",),
          globalWidgets.myText(context, 'Housing Area', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'Area of your residence', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          globalWidgets.myTextFieldEdit(TextInputType.number, houseAreaCtl, false, "Area (5 / 10)" ),
          globalWidgets.myText(context, 'Further Information', ColorsX.subBlack5, 20, 10, 0, 0, FontWeight.w700, 20),
          globalWidgets.myText(context, 'You can provide education, personality, housing, job, income or any kind of information about bride or groom. ', ColorsX.black, 0, 10, 0, 0, FontWeight.w400, 13),
          myInformationTextField(TextInputType.multiline, myInformationCtl, false, "Your information here" ),
          SizedBox(height: 30,),
          createProfileButton(context),
          Align(
            alignment: Alignment.topCenter,
            child: termsText(context, 25, 20, 20, 20),
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }

  void loadDetails() async{

    GlobalWidgets.showProgressLoader("Please Wait");
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('candidates')
        .doc(GlobalVariables.idOfProposal).get();
    if(snapshot.exists){
      fetchDoc = snapshot.data() as Map<String, dynamic>?;
      GlobalWidgets.hideProgressLoader();
      setState(() {
        documentSnapshot = snapshot;
      });
      String motherAlive = '${fetchDoc?['mother_alive']}';
      String fatherAlive = '${fetchDoc?['father_alive']}';
      if(motherAlive == '1')
        isMotherALive = true;
      else
        isMotherALive = false;
      if(fatherAlive == '1')
        isFatherALive = true;
      else
        isFatherALive = false;
      siblingsCtl.text = '${fetchDoc?['siblings']}';
      marriedBrothersCtl.text = '${fetchDoc?['married_brothers']}';
      unMarriedBrothersCtl.text = '${fetchDoc?['unmarried_brothers']}';
      marriedSistersCtl.text = '${fetchDoc?['married_sisters']}';
      unMarriedSistersCtl.text = '${fetchDoc?['unmarried_sisters']}';
      fathersOccupationCtl.text = '${fetchDoc?['fathers_occupation']}';
      selectedTypeOfHousing = '${fetchDoc?['house_in']}';
      selectedOwnershipOfHousing = '${fetchDoc?['possession']}';
      houseAreaCtl.text = '${fetchDoc?['house_area']}';
      myInformationCtl.text = '${fetchDoc?['additional_info']}';
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
  housingDetails(BuildContext context, String marla, String kanal, String personal, String rent){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  setState(() {
                    selectedTypeOfHousing = marla;
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2,color: ColorsX.subBlack5),
                    color: selectedTypeOfHousing == marla ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Icon(Icons.home, color: ColorsX.white,),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: globalWidgets.myText(context, marla, ColorsX.white, 10, 0, 0, 0, FontWeight.w400, 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    selectedTypeOfHousing = kanal;
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2,color: ColorsX.subBlack5),
                    color: selectedTypeOfHousing == kanal ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Icon(Icons.home, color: ColorsX.white,),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: globalWidgets.myText(context, kanal, ColorsX.white, 10, 0, 0, 0, FontWeight.w400, 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  setState(() {
                    selectedOwnershipOfHousing = personal;
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2,color: ColorsX.subBlack5),
                    color: selectedOwnershipOfHousing == personal ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: (FaIcon(FontAwesomeIcons.solidAddressCard, color: ColorsX.white,)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: globalWidgets.myText(context, personal, ColorsX.white, 10, 0, 0, 0, FontWeight.w400, 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    selectedOwnershipOfHousing = rent;
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2,color: ColorsX.subBlack5),
                    color: selectedOwnershipOfHousing == rent ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: (FaIcon(FontAwesomeIcons.solidBuilding, color: ColorsX.white,)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: globalWidgets.myText(context, rent, ColorsX.white, 10, 0, 0, 0, FontWeight.w400, 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  getHeight(BuildContext context, TextEditingController feetCtl, TextEditingController inchCtl, bool obscureText){
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: globalWidgets.myTextField(TextInputType.phone, feetCtl, false, 'Feet')),
          Expanded(child: globalWidgets.myTextField(TextInputType.phone, inchCtl, false, 'Inch')),
        ],
      ),
    );
  }
  phoneNumberLayout(BuildContext context, TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 0, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: ColorsX.white),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child:  globalWidgets.myText(context, "", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 15),
                ),
              )
          ),
          Expanded(child: globalWidgets.myTextField(inputType, ctl, obscureText, hint)),
        ],
      ),
    );
  }
  selectDateOfBirth(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  termsText(BuildContext context, double top, double right, double left, double bottom){
    return GestureDetector(
      onTap: (){
        // Get.toNamed(Routes.CREATE_ACCOUNT);
      },
      child: Container(
        margin: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: "By clicking the button, you agree to our ", style: TextStyle(color: ColorsX.subBlack5, fontSize: 16),
                ),
                TextSpan(
                  text: "Terms & Conditions", style: TextStyle(color: ColorsX.black, fontSize: 16, fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()..onTap = () {

                    GlobalVariables.webView_url = ("http://rishtaaasan.000webhostapp.com/terms.html");
                    Get.toNamed(Routes.TERMS_CONDITIONS);
                  },
                ),
                TextSpan(
                  text: " and ", style: TextStyle(color: ColorsX.subBlack5, fontSize: 16),
                ),
                TextSpan(
                  text: "Privacy Policy", style: TextStyle(color: ColorsX.black, fontSize: 16, fontWeight: FontWeight.w700),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    GlobalVariables.webView_url =("http://rishtaaasan.000webhostapp.com/privacy_policy.html");
                    Get.toNamed(Routes.PRIVACY_POLICY);
                  },
                ),
              ]
          ),
        ),
      ),
    );
  }
  motherTongeDropdown(){
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.white),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        hint: Text(motherTongueValue),
        underline: SizedBox(),
        value: motherTongueValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(left: SizeConfig.screenWidth*.56),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.white,),
        ),
        items: GlobalWidgets.motherTongueList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: globalWidgets.myText(context, value, ColorsX.light_orange, 0, 10, 0, 0, FontWeight.w400, 15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            motherTongueValue = value!;
            print(motherTongueValue);
          });
        },
      ),
    );
  }
  maslakDropdown(){
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.white),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        hint: Text(maslakValue),
        underline: SizedBox(),
        value: maslakValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(left: SizeConfig.screenWidth*.56),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.white,),
        ),
        items: GlobalWidgets.maslakList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: globalWidgets.myText(context, value, ColorsX.light_orange, 0, 10, 0, 0, FontWeight.w400, 15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            maslakValue = value!;
            print(maslakValue);
          });
        },
      ),
    );
  }
  casteDropdown(){
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.white),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        hint: Text(casteValue),
        underline: SizedBox(),
        value: casteValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(left: SizeConfig.screenWidth*.56),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.white,),
        ),
        items: GlobalWidgets.casteList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: globalWidgets.myText(context, value, ColorsX.light_orange, 0, 10, 0, 0, FontWeight.w400, 15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            casteValue = value!;
            print(casteValue);
          });
        },
      ),
    );
  }

  dateOfBirth(BuildContext context, TextInputType inputType, TextEditingController ctl, bool obscureText, String hint) {
    return GestureDetector(
      onTap: (){
        return selectDateOfBirth(context);
      },
      child: GestureDetector(
        onTap: (){
          return selectDateOfBirth(context);
        },
        child: Container(
          width: SizeConfig.screenWidth,
          height: 50,
          margin: EdgeInsets.only(left: 10, right: 10, top: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              border: Border.all(color: ColorsX.white, width: 1.25)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              globalWidgets.myText(context, selectedDate == DateTime.now() ? 'Date of Birth' :
              selectedDate.day.toString() + "/"+ selectedDate.month.toString() + "/"+ selectedDate.year.toString(), ColorsX.white, 0, 15, 0, 0,
                  FontWeight.w400, 15),
              Expanded(child: Container()),
              Icon(Icons.date_range, color: ColorsX.white,),
              SizedBox(width: 15,),
            ],
          ),
        ),
      ),
    );
  }

  myInformationTextField(TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: ColorsX.subBlack5, width: 1.25)
      ),
      child: TextFormField(
        keyboardType: inputType,
        controller: ctl,
        maxLines: null,
        obscureText: obscureText,
        style: TextStyle(color: ColorsX.subBlack5),
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: hint, hintStyle: TextStyle(color: ColorsX.subBlack5)
        ),
      ),
    );
  }
  MotherIsAlive(BuildContext context){
    return Theme(
      data: ThemeData(unselectedWidgetColor: ColorsX.subBlack5),
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 10, top: 15),
        child: CheckboxListTile(
          checkColor: ColorsX.light_orange,
          activeColor: ColorsX.white,
          tileColor: ColorsX.white,
          title: globalWidgets.myText(context, "Mother is alive", ColorsX.subBlack5, 0, 15, 0, 0, FontWeight.w400, 15),
          subtitle: globalWidgets.myText(context, "Select if mother is alive", ColorsX.black, 0, 15, 0, 0, FontWeight.w400, 13),
          value: isMotherALive,
          onChanged: (newValue) {
            setState(() {
              isMotherALive = newValue!;
              debugPrint(isMotherALive.toString());
            });
          },
          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
        ),
      ),
    );
  }
  FatherIsAlive(BuildContext context){
    return Theme(
      data: ThemeData(unselectedWidgetColor: ColorsX.subBlack5),
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 10, top: 5),
        child: CheckboxListTile(
          checkColor: ColorsX.light_orange,
          activeColor: ColorsX.white,
          tileColor: ColorsX.white,
          title: globalWidgets.myText(context, "Father is alive", ColorsX.subBlack5, 0, 15, 0, 0, FontWeight.w400, 15),
          subtitle: globalWidgets.myText(context, "Select if father is alive", ColorsX.black, 0, 15, 0, 0, FontWeight.w400, 13),
          value: isFatherALive,
          onChanged: (newValue) {
            setState(() {
              isFatherALive = newValue!;
              debugPrint(isFatherALive.toString());
            });
          },
          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
        ),
      ),
    );
  }
  gender(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          genderType(context, 'Male'),
          genderType(context, 'Female'),
        ],
      ),
    );
  }
  genderType(BuildContext context, String type){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedGender = type;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedGender == type ? ColorsX.light_orange : ColorsX.lightColorServiceRow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15, vertical: 5
          ),
          child: globalWidgets.myText(context, type, selectedGender == type ? ColorsX.white : ColorsX.black, 0, 10, 10, 0, FontWeight.w600, 15),
        ),
      ),
    );
  }
  createProfileButton(BuildContext context,){
    return GestureDetector(
      onTap: () async {
        if(siblingsCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Siblings", 'Number of Siblings of candidate');
        }
        else if(marriedBrothersCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Married Brothers", 'Married brothers of candidate');
        }
        else if(marriedSistersCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Married Sisters", 'Married sisters of candidate');
        }
        else if(unMarriedBrothersCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Unmarried Brothers", 'Unmarried brothers of candidate');
        }
        else if(unMarriedSistersCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Unmarried Sisters", 'Unmarried sisters of candidate');
        }
        else if(fathersOccupationCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Father's Occupation", "Provide father's occupation");
        }
        else if(selectedTypeOfHousing.isEmpty){
          GlobalWidgets.showErrorToast(context, "Housing", 'Choose House Area Dimensions');
        }
        else if(selectedOwnershipOfHousing.isEmpty){
          GlobalWidgets.showErrorToast(context, "Housing Possession", 'Choose House Possession');
        }
        else if(houseAreaCtl.text.trim().isEmpty){
          GlobalWidgets.showErrorToast(context, "Housing Area", 'Provide House Area');
        }
        else {

          GlobalVariables.mother_alive = isMotherALive ? "1" : "No";
          GlobalVariables.father_alive = isFatherALive ? "1" : "No";
          GlobalVariables.siblings = siblingsCtl.text.trim().toString();
          GlobalVariables.married_brothers = marriedBrothersCtl.text.trim().toString();
          GlobalVariables.married_sisters = marriedSistersCtl.text.trim().toString();
          GlobalVariables.unmarried_brothers = unMarriedBrothersCtl.text.trim().toString();
          GlobalVariables.unmarried_sisters = unMarriedSistersCtl.text.trim().toString();
          GlobalVariables.fathers_occupation = fathersOccupationCtl.text.trim().toString();
          GlobalVariables.house_in = selectedTypeOfHousing;
          GlobalVariables.possession = selectedOwnershipOfHousing;
          GlobalVariables.house_area = houseAreaCtl.text.trim().toString();
          GlobalVariables.additional_info = myInformationCtl.text.trim().toString().isEmpty ? "Nil" : myInformationCtl.text.trim().toString();


          GlobalWidgets.showProgressLoader("Please wait");
          CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
          await users
              .doc(GlobalVariables.idOfProposal)
              .update(
              {'mother_alive': GlobalVariables.mother_alive,
                'father_alive' : GlobalVariables.father_alive,
                'siblings' : GlobalVariables.siblings,
                'married_brothers' : GlobalVariables.married_brothers,
                'unmarried_brothers' : GlobalVariables.unmarried_brothers,
                'married_sisters' : GlobalVariables.married_sisters,
                'unmarried_sisters' : GlobalVariables.unmarried_sisters,
                'fathers_occupation' : GlobalVariables.fathers_occupation,
                'house_in' : GlobalVariables.house_in,
                'possession' : GlobalVariables.possession,
                'house_area' : GlobalVariables.house_area,
                'additional_info' : GlobalVariables.additional_info,
              })
              .then((value) => successDialog())
              .catchError((error) => errorDialogUpdate(context,'${error}'));

          GlobalWidgets.hideProgressLoader();
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
            child: globalWidgets.myText(context, "Edit Now", ColorsX.white, 0, 0, 0, 0, FontWeight.w600, 17),
          ),
        ),
      ),
    );
  }

  successDialog() {
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
        title: 'Profile Updated',
        desc:
        'Family Details are updated.',// \n Save or remember ID to Log In' ,
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
  errorDialogUpdate(BuildContext context, String error) {
    debugPrint(error);
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: true,
        title: "Update Error",
        desc:
        'Please try again',
        btnOkOnPress: () {
          Get.back();
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
  steps(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: ColorsX.light_orange,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: ColorsX.light_orange)
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 8
              ),
              child: globalWidgets.myText(context, 'Step 1', ColorsX.yellowColor, 0, 10, 10, 0, FontWeight.w600, 16),
            ),
          ),
          SizedBox(width: 8,),
          Container(
            decoration: BoxDecoration(
              color: ColorsX.light_orange,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 8
              ),
              child: globalWidgets.myText(context, 'Step 2', ColorsX.yellowColor, 0, 10, 10, 0, FontWeight.w600, 16),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 8
              ),
              child: globalWidgets.myText(context, 'Step 3', ColorsX.white, 0, 10, 10, 0, FontWeight.w600, 15),
            ),
          ),
        ],
      ),
    );
  }

}
