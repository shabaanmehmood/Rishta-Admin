import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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


class RequiredProposalEdit extends StatefulWidget {
  const RequiredProposalEdit({Key? key}) : super(key: key);

  @override
  _RequiredProposalEditState createState() => _RequiredProposalEditState();
}

class _RequiredProposalEditState extends State<RequiredProposalEdit> {
  GlobalWidgets globalWidgets = GlobalWidgets();
  var selectedTypeOfHousing = [];
  var selectedOwnershipOfHousing = [];
  String selectedAreaOfHousing = '';
  String selectedProfession = '';
  DateTime selectedDate = DateTime.now();
  String start_age = '';
  String end_age = '';
  String start_height = '';
  String end_height = '';
  String date = "";
  DocumentSnapshot? documentSnapshot;
  Map<String, dynamic>? fetchDoc;
  TextEditingController fathersOccupationCtl = new TextEditingController();
  TextEditingController feetCtl = new TextEditingController();
  TextEditingController inchesCtl = new TextEditingController();
  TextEditingController qualificationCtl = new TextEditingController();
  TextEditingController houseAreaCtl = new TextEditingController();
  TextEditingController myInformationCtl = new TextEditingController();
  TextEditingController cityCtl = new TextEditingController();

  bool isCasteSpecificSelected = false;
  bool isAnyCasteSelected = false;
  bool isChecked = false;
  var listOfProfessions = [];
  RangeValues _currentRangeValues = RangeValues(18, 45);
  RangeValues _currentHeightValues = RangeValues(4, 7);
  static String cityValue = "Select City";
  static String maslakValue = "Maslak";
  static String casteValue = "Caste";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
      appBar: AppBar(
        backgroundColor: ColorsX.black,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          Get.back();
        },),
        title: globalWidgets.myText(
            context,
            "Demands",
            ColorsX.white,
            0,
            0,
            0,
            0,
            FontWeight.w400,
            16),
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
              color: const Color(0xffF3F5F5).withOpacity(0.8),
            ),
          ),
          listViewContent(context),
        ],
      ),
    );
  }

  listViewContent(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: documentSnapshot == null ? Container() : ListView(
        children: <Widget>[
          // steps(context),
          globalWidgets.myText(context, 'Update any thing and click the Button Edit Now below', ColorsX.black, 20, 10, 0, 0, FontWeight.w700, 15),
          globalWidgets.myText(
              context,
              'Required Proposal',
              ColorsX.subBlack5,
              10,
              10,
              0,
              0,
              FontWeight.w700,
              20),
          globalWidgets.myText(
              context,
              'Major information',
              ColorsX.black,
              0,
              10,
              0,
              0,
              FontWeight.w700,
              16),
          globalWidgets.myText(
              context,
              'Fill in details according to your interests and demands',
              ColorsX.black,
              3,
              10,
              0,
              0,
              FontWeight.w400,
              13),
          profession(context),
          globalWidgets.myText(
              context,
              'Caste Requirements',
              ColorsX.subBlack5,
              20,
              10,
              0,
              0,
              FontWeight.w700,
              20),
          globalWidgets.myText(
              context,
              'Select one or both',
              ColorsX.black,
              0,
              10,
              0,
              0,
              FontWeight.w400,
              13),
          casteSpecificProposals(context),
          fromAnyCaste(context),
          globalWidgets.myText(
              context,
              'Age Limit',
              ColorsX.subBlack5,
              20,
              10,
              0,
              0,
              FontWeight.w700,
              20),
          globalWidgets.myText(
              context,
              'Choose your required age limit (Drag buttons)',
              ColorsX.black,
              0,
              10,
              0,
              0,
              FontWeight.w400,
              13),
          ageLimit(context),
          Visibility(
              visible: start_age == '' ? false : true,
              child: globalWidgets.myText(
                  context,
                  'Your selected age limit is ' + start_age + " - " + end_age,
                  ColorsX.black,
                  10,
                  10,
                  0,
                  0,
                  FontWeight.w400,
                  15)
          ),
          globalWidgets.myText(
              context,
              'Height',
              ColorsX.subBlack5,
              20,
              10,
              0,
              0,
              FontWeight.w700,
              20),
          globalWidgets.myText(
              context,
              'Minimum Required height (feet & inches)',
              ColorsX.black,
              0,
              10,
              0,
              0,
              FontWeight.w400,
              13),
          // heightLimit(context),
          getHeight(context, feetCtl, inchesCtl, false),
          globalWidgets.myText(
              context,
              'Housing',
              ColorsX.subBlack5,
              20,
              10,
              0,
              0,
              FontWeight.w700,
              20),
          globalWidgets.myText(
              context,
              'Provide housing requirement you\u0027re looking for',
              ColorsX.black,
              0,
              10,
              0,
              0,
              FontWeight.w400,
              13),
          housingDetails(
              context,
              "Posh Area",
              "Any Area",
              "Own",
              "Rent",
              "Marla",
              "Kanal"),
          globalWidgets.myText(
              context,
              'Housing Area',
              ColorsX.subBlack5,
              20,
              10,
              0,
              0,
              FontWeight.w700,
              20),
          globalWidgets.myText(
              context,
              'Minimum Required Area of your residence',
              ColorsX.black,
              0,
              10,
              0,
              0,
              FontWeight.w400,
              13),
          globalWidgets.myTextFieldEdit(
              TextInputType.number, houseAreaCtl, false, "Area (5 / 10)"),
          globalWidgets.myText(
              context,
              'City',
              ColorsX.subBlack5,
              20,
              10,
              0,
              0,
              FontWeight.w700,
              20),
          globalWidgets.myText(
              context,
              'City to find easily',
              ColorsX.black,
              0,
              10,
              0,
              0,
              FontWeight.w400,
              13),
          cityDropdown(),
          globalWidgets.myText(
              context,
              'Additional Demands',
              ColorsX.subBlack,
              20,
              10,
              0,
              0,
              FontWeight.w700,
              20),
          globalWidgets.myText(
              context,
              'Your demands could be related to education, personality, housing, job, income, family background or any kind of information about bride or groom. ',
              ColorsX.black,
              0,
              10,
              0,
              0,
              FontWeight.w400,
              13),
          myInformationTextField(
              TextInputType.multiline, myInformationCtl, false,
              "Your demands here"),
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

  cityDropdown() {
    return Container(
      width: SizeConfig.screenWidth,
      height: 50,
      margin: EdgeInsets.only(top: 5, right: 10, left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsX.subBlack),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(cityValue),
        underline: SizedBox(),
        value: cityValue,
        //elevation: 5,
        style: TextStyle(
            color: Colors.black,
            fontSize: 14),
        icon: Container(
          margin: EdgeInsets.only(right: 10),
          child: Icon(Icons.arrow_drop_down, color: ColorsX.subBlack,),
        ),
        items: GlobalWidgets.citiesRequiredList.map<DropdownMenuItem<String>>(
                (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.only(
                      right:
                      SizeConfig.marginVerticalXXsmall),
                  child: globalWidgets.myText(
                      context,
                      value,
                      ColorsX.black,
                      0,
                      10,
                      0,
                      0,
                      FontWeight.w400,
                      15),
                ),
              );
            }).toList(),
        onChanged: (value) {
          setState(() {
            cityValue = value!;
            print(cityValue);
          });
        },
      ),
    );
  }

  getHeight(BuildContext context, TextEditingController feetCtl,
      TextEditingController inchCtl, bool obscureText) {
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(child: globalWidgets.myTextFieldEdit(
              TextInputType.phone, feetCtl, false, 'Feet')),
          Expanded(child: globalWidgets.myTextFieldEdit(
              TextInputType.phone, inchCtl, false, 'Inch')),
        ],
      ),
    );
  }

  ageLimit(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      min: 18,
      max: 45,
      divisions: 13,
      inactiveColor: ColorsX.yellowColor,
      activeColor: ColorsX.light_orange,
      semanticFormatterCallback: ageValuesRange(
          _currentRangeValues.start, _currentRangeValues.end),
      labels: RangeLabels(
        _currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentRangeValues = values;
          start_age = _currentRangeValues.start.toStringAsFixed(0);
          end_age = _currentRangeValues.end.toStringAsFixed(0);
        });
      },
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
      String casteDemand = '${fetchDoc?['caste_demand']}';
      if(casteDemand == "1")
        isCasteSpecificSelected = true;
      if(casteDemand == "2")
        isAnyCasteSelected = true;
      if(casteDemand == "3") {
        isCasteSpecificSelected = true;
        isAnyCasteSelected = true;
      }
      String ageLim = '${fetchDoc?['age_limit']}';
      String ageLimitTo = ageLim.split('-')[0];
      String ageLimitFrom = ageLim.split('-')[1];
      start_age = ageLimitTo;
      end_age = ageLimitFrom;
      _currentRangeValues = RangeValues(double.parse(start_age), double.parse(end_age));
      RangeLabels(_currentRangeValues.start.round().toString(),
        _currentRangeValues.end.round().toString(),);
      feetCtl.text = '${fetchDoc?['height_demand']}'.split('\u0027')[0];
      inchesCtl.text = '${fetchDoc?['height_demand']}'.split('\u0027')[1];
      selectedAreaOfHousing = '${fetchDoc?['housing_demand_in']}';
      var arrayForArea = fetchDoc?['housing_demand_location'];
      if(arrayForArea.contains('Posh Area'))
        selectedTypeOfHousing.add('Posh Area');
      else if(arrayForArea.contains('Any Area'))
        selectedTypeOfHousing.add('Any Area');
      var arrayForPoss = fetchDoc?['housing_demand_possession'];
      if(arrayForPoss.contains('Own'))
        selectedOwnershipOfHousing.add('Own');
      else if(arrayForPoss.contains('Rent'))
        selectedOwnershipOfHousing.add('Rent');
      debugPrint(selectedOwnershipOfHousing.toString());
      houseAreaCtl.text = fetchDoc?['housing_demand_area'];
      cityValue = fetchDoc?['city_demand'];
      myInformationCtl.text = fetchDoc?['additional_demand'];
      var array = fetchDoc?['profession_demand'];
      for(int i = 0; i < array.length; i++){
        setState(() {
          listOfProfessions.add(array[i]);
        });
      }
    }
    else{
      GlobalWidgets.hideProgressLoader();
      errorDialogAPI(context);
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
  errorDialogAPI(BuildContext context) {
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
  heightLimit(BuildContext context) {
    return RangeSlider(
      values: _currentHeightValues,
      min: 4,
      max: 7,
      divisions: 3,
      inactiveColor: ColorsX.yellowColor,
      activeColor: ColorsX.light_orange,
      semanticFormatterCallback: ageValuesRange(
          _currentHeightValues.start, _currentHeightValues.end),
      labels: RangeLabels(
        _currentHeightValues.start.round().toString(),
        _currentHeightValues.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _currentHeightValues = values;
          start_height = _currentHeightValues.start.toStringAsFixed(0);
          end_height = _currentHeightValues.end.toStringAsFixed(0);
        });
      },
    );
  }

  requiredProfession(BuildContext context, String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedProfession = type;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedProfession == type ? ColorsX.light_orange : ColorsX
              .lightColorServiceRow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15, vertical: 5
          ),
          child: globalWidgets.myText(
              context,
              type,
              selectedProfession == type ? ColorsX.white : ColorsX.black,
              0,
              10,
              10,
              0,
              FontWeight.w600,
              15),
        ),
      ),
    );
  }

  housingDetails(BuildContext context, String poshArea, String anyArea,
      String personal, String rent, String marla, String kanal) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedTypeOfHousing.isEmpty) {
                      selectedTypeOfHousing.add(poshArea);
                    } else if (selectedTypeOfHousing.contains(poshArea)) {
                      selectedTypeOfHousing.remove(poshArea);
                    } else {
                      selectedTypeOfHousing.add(poshArea);
                    }
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: ColorsX.subBlack5),
                    color: selectedTypeOfHousing.contains(poshArea) ? ColorsX
                        .light_orange : ColorsX.lightColorServiceRow,
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
                          child: globalWidgets.myText(
                              context,
                              poshArea,
                              ColorsX.white,
                              10,
                              0,
                              0,
                              0,
                              FontWeight.w400,
                              15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedTypeOfHousing.isEmpty) {
                      selectedTypeOfHousing.add(anyArea);
                    } else if (selectedTypeOfHousing.contains(anyArea)) {
                      selectedTypeOfHousing.remove(anyArea);
                    } else {
                      selectedTypeOfHousing.add(anyArea);
                    }
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: ColorsX.subBlack5),
                    color: selectedTypeOfHousing.contains(anyArea) ? ColorsX
                        .light_orange : ColorsX.lightColorServiceRow,
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
                          child: globalWidgets.myText(
                              context,
                              anyArea,
                              ColorsX.white,
                              10,
                              0,
                              0,
                              0,
                              FontWeight.w400,
                              15),
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
                onTap: () {
                  setState(() {
                    if (selectedOwnershipOfHousing.isEmpty) {
                      selectedOwnershipOfHousing.add(personal);
                    } else if (selectedOwnershipOfHousing.contains(personal)) {
                      selectedOwnershipOfHousing.remove(personal);
                    } else {
                      selectedOwnershipOfHousing.add(personal);
                    }
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: ColorsX.subBlack5),
                    color: selectedOwnershipOfHousing.contains(personal)
                        ? ColorsX.light_orange
                        : ColorsX.lightColorServiceRow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: (FaIcon(FontAwesomeIcons.solidAddressCard,
                            color: ColorsX.white,)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: globalWidgets.myText(
                              context,
                              personal,
                              ColorsX.white,
                              10,
                              0,
                              0,
                              0,
                              FontWeight.w400,
                              15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedOwnershipOfHousing.isEmpty) {
                      selectedOwnershipOfHousing.add(rent);
                    } else if (selectedOwnershipOfHousing.contains(rent)) {
                      selectedOwnershipOfHousing.remove(rent);
                    } else {
                      selectedOwnershipOfHousing.add(rent);
                    }
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: ColorsX.subBlack5),
                    color: selectedOwnershipOfHousing.contains(rent) ? ColorsX
                        .light_orange : ColorsX.lightColorServiceRow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: (FaIcon(FontAwesomeIcons.solidBuilding,
                            color: ColorsX.white,)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: globalWidgets.myText(
                              context,
                              rent,
                              ColorsX.white,
                              10,
                              0,
                              0,
                              0,
                              FontWeight.w400,
                              15),
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
                onTap: () {
                  setState(() {
                    selectedAreaOfHousing = marla;
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: ColorsX.subBlack5),
                    color: selectedAreaOfHousing == marla
                        ? ColorsX.light_orange
                        : ColorsX.lightColorServiceRow,
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
                          child: globalWidgets.myText(
                              context,
                              marla,
                              ColorsX.white,
                              10,
                              0,
                              0,
                              0,
                              FontWeight.w400,
                              15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAreaOfHousing = kanal;
                  });
                },
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth * .25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(width: 2, color: ColorsX.subBlack5),
                    color: selectedAreaOfHousing == kanal
                        ? ColorsX.light_orange
                        : ColorsX.lightColorServiceRow,
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
                          child: globalWidgets.myText(
                              context,
                              kanal,
                              ColorsX.white,
                              10,
                              0,
                              0,
                              0,
                              FontWeight.w400,
                              15),
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

  phoneNumberLayout(BuildContext context, TextInputType inputType,
      TextEditingController ctl, bool obscureText, String hint) {
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
                  child: globalWidgets.myText(
                      context,
                      "",
                      ColorsX.white,
                      0,
                      0,
                      0,
                      0,
                      FontWeight.w400,
                      15),
                ),
              )
          ),
          Expanded(child: globalWidgets.myTextFieldEdit(
              inputType, ctl, obscureText, hint)),
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

  termsText(BuildContext context, double top, double right, double left,
      double bottom) {
    return GestureDetector(
      onTap: () {
        // Get.toNamed(Routes.CREATE_ACCOUNT);
      },
      child: Container(
        margin: EdgeInsets.only(
            left: left, right: right, top: top, bottom: bottom),
        child: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: "By clicking the button, you agree to our ",
                  style: TextStyle(color: ColorsX.subBlack5, fontSize: 16),
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

  maslakDropdown() {
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
          margin: EdgeInsets.only(left: SizeConfig.screenWidth * .56),
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
                  child: globalWidgets.myText(
                      context,
                      value,
                      ColorsX.light_orange,
                      0,
                      10,
                      0,
                      0,
                      FontWeight.w400,
                      15),
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

  casteDropdown() {
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
          margin: EdgeInsets.only(left: SizeConfig.screenWidth * .56),
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
                  child: globalWidgets.myText(
                      context,
                      value,
                      ColorsX.light_orange,
                      0,
                      10,
                      0,
                      0,
                      FontWeight.w400,
                      15),
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

  dateOfBirth(BuildContext context, TextInputType inputType,
      TextEditingController ctl, bool obscureText, String hint) {
    return GestureDetector(
      onTap: () {
        return selectDateOfBirth(context);
      },
      child: GestureDetector(
        onTap: () {
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
              globalWidgets.myText(
                  context,
                  selectedDate == DateTime.now() ? 'Date of Birth' :
                  selectedDate.day.toString() + "/" +
                      selectedDate.month.toString() + "/" +
                      selectedDate.year.toString(),
                  ColorsX.white,
                  0,
                  15,
                  0,
                  0,
                  FontWeight.w400,
                  15),
              Expanded(child: Container()),
              Icon(Icons.date_range, color: ColorsX.white,),
              SizedBox(width: 15,),
            ],
          ),
        ),
      ),
    );
  }


  myInformationTextField(TextInputType inputType, TextEditingController ctl,
      bool obscureText, String hint) {
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: ColorsX.subBlack, width: 1.25)
      ),
      child: TextFormField(
        keyboardType: inputType,
        controller: ctl,
        maxLines: null,
        obscureText: obscureText,
        style: TextStyle(color: ColorsX.subBlack),
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: hint,
            hintStyle: TextStyle(color: ColorsX.subBlack)
        ),
      ),
    );
  }

  casteSpecificProposals(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: ColorsX.subBlack5),
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 10, top: 15),
        child: CheckboxListTile(
          checkColor: ColorsX.light_orange,
          activeColor: ColorsX.white,
          tileColor: ColorsX.white,
          title: globalWidgets.myText(
              context,
              "Only that matches my caste",
              ColorsX.subBlack5,
              0,
              15,
              0,
              0,
              FontWeight.w400,
              15),
          subtitle: globalWidgets.myText(
              context,
              "Same caste",
              ColorsX.black,
              0,
              15,
              0,
              0,
              FontWeight.w400,
              13),
          value: isCasteSpecificSelected,
          onChanged: (newValue) {
            setState(() {
              isCasteSpecificSelected = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity
              .leading, //  <-- leading Checkbox
        ),
      ),
    );
  }

  fromAnyCaste(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: ColorsX.subBlack5),
      child: Container(
        margin: EdgeInsets.only(left: 0, right: 10, top: 5),
        child: CheckboxListTile(
          checkColor: ColorsX.light_orange,
          activeColor: ColorsX.white,
          tileColor: ColorsX.white,
          title: globalWidgets.myText(
              context,
              "Could be from any caste",
              ColorsX.subBlack5,
              0,
              15,
              0,
              0,
              FontWeight.w400,
              15),
          subtitle: globalWidgets.myText(
              context,
              "No caste restrictions",
              ColorsX.black,
              0,
              15,
              0,
              0,
              FontWeight.w400,
              13),
          value: isAnyCasteSelected,
          onChanged: (newValue) {
            setState(() {
              isAnyCasteSelected = newValue!;
            });
          },
          controlAffinity: ListTileControlAffinity
              .leading, //  <-- leading Checkbox
        ),
      ),
    );
  }

  profession(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 15),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: <Widget>[
          professionType(context, 'Doctor', 0),
          professionType(context, 'Engineer', 1),
          professionType(context, 'Lecturer', 2),
          professionType(context, 'M.B.A', 3),
          professionType(context, 'M.A', 4),
          professionType(context, 'Foreign Living', 5),
          professionType(context, 'B.Sc', 6),
          professionType(context, 'B.A', 7),
          professionType(context, 'F.A', 8),
          professionType(context, 'Business', 9),
          professionType(context, 'Government Job', 10),
          professionType(context, 'Army / Military', 11),
          professionType(context, 'Lawyer', 12),
          professionType(context, 'Banker', 13),
        ],
      ),
    );
  }

  professionType(BuildContext context, String type, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (listOfProfessions.isEmpty) {
            listOfProfessions.add(type);
          }
          else if (listOfProfessions.contains(type)) {
            listOfProfessions.remove(type);
            removeItem(type);
          }
          else {
            listOfProfessions.add(type);
          }
        });

      },
      child: Container(
        decoration: BoxDecoration(
          color: listOfProfessions.contains(type)
              ? ColorsX.light_orange
              : ColorsX.lightColorServiceRow,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 15, vertical: 8
          ),
          child: globalWidgets.myText(
              context,
              type,
              listOfProfessions.contains(type) ? ColorsX.white : ColorsX.black,
              0,
              10,
              10,
              0,
              FontWeight.w600,
              15),
        ),
      ),
    );
  }

  createProfileButton(BuildContext context,) {
    return GestureDetector(
      onTap: () async {
        if (!isCasteSpecificSelected && !isAnyCasteSelected) {
          GlobalWidgets.showErrorToast(
              context, "Caste Demand", 'Select your Caste demands');
        }
        else if (start_age
            .trim()
            .isEmpty && end_age
            .trim()
            .isEmpty) {
          GlobalWidgets.showErrorToast(
              context, "Age limit", 'Provide your Age limit demand');
        }
        else if (feetCtl.text
            .trim()
            .isEmpty && inchesCtl.text
            .trim()
            .isEmpty) {
          GlobalWidgets.showErrorToast(context, "Minimum height Demand",
              'Provide your Minimum Height demand');
        }
        else if (selectedTypeOfHousing.isEmpty) {
          GlobalWidgets.showErrorToast(context, "Housing Demand",
              'Provide your Housing Location demand');
        }
        else if (selectedOwnershipOfHousing.isEmpty) {
          GlobalWidgets.showErrorToast(context, "House Possession",
              'Provide your Housing Possession demand');
        }
        else if (selectedAreaOfHousing.isEmpty) {
          GlobalWidgets.showErrorToast(
              context, "House Space", 'Provide your Housing Space demand');
        }
        else if (houseAreaCtl.text
            .trim()
            .isEmpty) {
          GlobalWidgets.showErrorToast(
              context, "House Area", 'Provide your Housing Area demand');
        }
        else if (cityValue == 'Select City') {
          GlobalWidgets.showErrorToast(
              context, "City Demand", 'Provide your City demand');
        }
        else {
          // GlobalVariables.profession_demand =
          // listOfProfessions.isEmpty ? "Nil" : listOfProfessions.toString();
          GlobalVariables.professionDemandListFirestore = listOfProfessions.isEmpty ?
          GlobalVariables.professionDemandListFirestore : listOfProfessions;
          GlobalVariables.caste_demand =
          isAnyCasteSelected && isCasteSpecificSelected
              ? "3"
              : isCasteSpecificSelected ? "1" : "2";
          GlobalVariables.age_limit = start_age + "-" + end_age;
          GlobalVariables.height_demand =
              feetCtl.text.trim().toString() + '\u0027' +
                  inchesCtl.text.trim().toString();
          GlobalVariables.housing_demand_location =
              selectedTypeOfHousing.toString();
          GlobalVariables.housing_demand_possession =
              selectedOwnershipOfHousing.toString();
          GlobalVariables.housing_demand_in = selectedAreaOfHousing.toString();
          GlobalVariables.city_demand = cityValue;
          GlobalVariables.housing_demand_area =
              houseAreaCtl.text.trim().toString();
          GlobalVariables.additional_demand =
              myInformationCtl.text.trim().toString();

          GlobalWidgets.showProgressLoader("Please wait");
          CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
          await users
              .doc(GlobalVariables.idOfProposal)
              .update(
              {
                'caste_demand' : GlobalVariables.caste_demand,
                'age_limit' : GlobalVariables.age_limit,
                'height_demand' : GlobalVariables.height_demand,
                'housing_demand_location' : GlobalVariables.housing_demand_location,
                'housing_demand_possession' : GlobalVariables.housing_demand_possession,
                'housing_demand_in' : GlobalVariables.housing_demand_in,
                'housing_demand_area' : GlobalVariables.housing_demand_area,
                'city_demand' : GlobalVariables.city_demand,
                'additional_demand' : GlobalVariables.additional_demand,

              })
              .then((value) => debugPrint('data updated'))
              .catchError((error) => debugPrint('data update error $error'));

          await users
              .doc(GlobalVariables.idOfProposal)
              .update({'profession_demand': FieldValue.arrayUnion(GlobalVariables.professionDemandListFirestore)})
              .then((value) => successDialog())
              .catchError((error) => errorDialogUpdate(context,'${error}'));

          GlobalWidgets.hideProgressLoader();

          // createAccount(context);
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
            child: globalWidgets.myText(
                context,
                "Edit Now",
                ColorsX.white,
                0,
                0,
                0,
                0,
                FontWeight.w600,
                17),
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
        'Required Proposal Details are updated.',// \n Save or remember ID to Log In' ,
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

  ageValuesRange(double start, double end) {
    debugPrint(start.toStringAsFixed(0));
    debugPrint(end.toStringAsFixed(0));
  }
//  git code
//   void createAccount(BuildContext context) async {
//     // var _apiService = ApiService();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     GlobalWidgets.hideKeyboard(context);
//     print(prefs.getString('token'));
//     print(GlobalVariables.profileCreatedBy);
//     print(GlobalVariables.maritalStatus);
//     print(GlobalVariables.reason_for_second_marriage);
//     print("marriage period"+GlobalVariables.marriage_period);
//     print("separattion period"+GlobalVariables.separation_period);
//     print(GlobalVariables.kids);
//     Map<String, dynamic> userInfo = Map();
//     userInfo['token'] = prefs.getString('token');
//     userInfo['profile_created_by'] = GlobalVariables.profileCreatedBy;
//     userInfo['marital_status'] = GlobalVariables.maritalStatus;
//     userInfo['reason_for_second_marriage'] = GlobalVariables.reason_for_second_marriage;
//     userInfo['marriage_period'] = GlobalVariables.marriage_period;
//
//     userInfo['separation_period'] = GlobalVariables.separation_period;
//     userInfo['kids'] = GlobalVariables.kids;
//     userInfo['kids_ownership'] = GlobalVariables.kids_ownership;
//     userInfo['gender'] = GlobalVariables.gender;
//     userInfo['name'] = GlobalVariables.name;
//
//     userInfo['dob'] = GlobalVariables.dob;
//     userInfo['city'] = GlobalVariables.city;
//     userInfo['area'] = GlobalVariables.area;
//     userInfo['address'] = GlobalVariables.address;
//     userInfo['height'] = GlobalVariables.height;
//
//     userInfo['email'] = GlobalVariables.email;
//     userInfo['password'] = GlobalVariables.password;
//     userInfo['primary_phone'] = GlobalVariables.primary_phone;
//     userInfo['secondary_phone'] = GlobalVariables.secondary_phone;
//     userInfo['mother_tongue'] = GlobalVariables.mother_tongue;
//
//     userInfo['religion'] = GlobalVariables.religion;
//     userInfo['sect'] = GlobalVariables.sect;
//     userInfo['caste'] = GlobalVariables.caste;
//     userInfo['subcaste'] = GlobalVariables.subcaste;
//     // userInfo['profession'] = GlobalVariables.profession;
//     userInfo['profession'] = GlobalVariables.myProfessionListFirestore;
//
//     userInfo['qualification'] = GlobalVariables.qualificatiion;
//     userInfo['occupation'] =  GlobalVariables.occupation;
//     userInfo['monthly_income'] = GlobalVariables.monthly_income;
//     userInfo['mother_alive'] = GlobalVariables.mother_alive;
//     userInfo['father_alive'] = GlobalVariables.father_alive;
//
//     userInfo['siblings'] = GlobalVariables.siblings;
//     userInfo['married_brothers'] = GlobalVariables.married_brothers;
//     userInfo['married_sisters'] = GlobalVariables.married_sisters;
//     userInfo['unmarried_brothers'] = GlobalVariables.unmarried_brothers;
//     userInfo['unmarried_sisters'] = GlobalVariables.unmarried_sisters;
//
//     userInfo['fathers_occupation'] = GlobalVariables.fathers_occupation;
//     userInfo['house_in'] = GlobalVariables.house_in;
//     userInfo['possession'] = GlobalVariables.possession;
//     userInfo['house_area'] = GlobalVariables.house_area;
//     userInfo['additional_info'] = GlobalVariables.additional_info;
//
//     // userInfo['profession_demand'] = GlobalVariables.profession_demand;
//     userInfo['profession_demand'] = GlobalVariables.professionDemandListFirestore;
//     userInfo['caste_demand'] = GlobalVariables.caste_demand;
//     userInfo['age_limit'] = GlobalVariables.age_limit;
//     userInfo['height_demand'] = GlobalVariables.height_demand;
//     userInfo['housing_demand_location'] = GlobalVariables.housing_demand_location;
//
//     userInfo['housing_demand_possession'] = GlobalVariables.housing_demand_possession;
//     userInfo['housing_demand_in'] = GlobalVariables.housing_demand_in;
//     userInfo['housing_demand_area'] = GlobalVariables.housing_demand_area;
//     userInfo['city_demand'] = GlobalVariables.city_demand;
//     userInfo['additional_demand'] = GlobalVariables.additional_demand;
//
//     userInfo['account_created_at'] = formattedDate();
//     userInfo['is_reported_by'] = '0';
//     userInfo['is_blocked_by'] = '0';
//     userInfo['is_featured'] = '0';
//     userInfo['featured_start_date'] = '0';
//     userInfo['featured_end_date'] = '0';
//     userInfo['profile_views_his'] = '0';
//
//     userInfo['profile_views_others'] = '0';
//     userInfo['is_paid_user'] = '0';
//     userInfo['package_type'] = 'trial';
//     userInfo['favourites'] = '0';
//     userInfo['activate_call_check'] = '0';
//
//     userInfo['number_of_call_views'] = '0';
//     userInfo['involve_in_issue'] = '0';
//     userInfo['issue_detail'] = '0';
//     userInfo['is_active_account'] = '1';
//     userInfo['payment_start_date'] = '0';
//     userInfo['payment_end_date'] = '0';
//
//     print(userInfo);
//     checkIfEmailExists(GlobalVariables.email, userInfo);
//     // if(checkIfEmailExists(GlobalVariables.email, userInfo) == 'ok'){
//     //   ///email does not exist now we can add data.
//     //   GlobalWidgets.showProgressLoader("Please Wait");
//     //   // final res = await _apiService.userSignUp(apiParams: userInfo);
//     //   var collection = FirebaseFirestore.instance.collection('candidates');
//     //   var docRef = await collection.add(userInfo);
//     //   var documentId = docRef.id;
//     //   GlobalWidgets.hideProgressLoader();
//     //   successDialog(documentId);
//     // }
//     // else{
//     //   errorDialog();
//     // }
// //     if (res) {
// // //show success dialog
// //       successDialog(GlobalVariables.signUpResponse);
// //     }
// //     else {
// //       // Fluttertoast.showToast(
// //       //     msg: res.toString(),
// //       //     toastLength: Toast.LENGTH_LONG,
// //       //     gravity: ToastGravity.CENTER,
// //       //     timeInSecForIosWeb: 1,
// //       //     backgroundColor: Colors.red,
// //       //     textColor: Colors.white,
// //       //     fontSize: 16.0
// //       // );
// //       errorDialog();
// //     }
//   }
  /// Check If Document Exists. This method is to check whether the user is already registered or not
  /// so that we could create account or not.

  // Future<String> checkIfEmailExists(String email, Map<String, dynamic> userInfo) async {
  //   // Get docs from collection reference
  //   String response = '';
  //   GlobalWidgets.showProgressLoader("Validating Data");
  //
  //   final QuerySnapshot result = await FirebaseFirestore.instance
  //       .collection('candidates')
  //       .where('email', isEqualTo: email)
  //   // .limit(1)
  //       .get();
  //   final List<DocumentSnapshot> documents = result.docs;
  //   if(documents.isEmpty) {
  //     response = 'ok';
  //
  //     // final res = await _apiService.userSignUp(apiParams: userInfo);
  //     var collection = FirebaseFirestore.instance.collection('candidates');
  //     var docRef = await collection.add(userInfo);
  //     var documentId = docRef.id;
  //     GlobalWidgets.hideProgressLoader();
  //     successDialog(documentId);
  //     GlobalWidgets.hideProgressLoader();
  //   }
  //   else {
  //     print(documents.first);
  //     response = 'no';
  //     GlobalWidgets.hideProgressLoader();
  //     errorDialog();
  //   }
  //   return response;
  // }
  formattedDate(){
    DateTime dateTime = DateTime.now();
    GlobalVariables.account_created_at = dateTime.toString();
    return dateTime.toString();
  }
  errorDialog() {
    return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: true,
        title: 'Error',
        desc:
        'Please try again. This email already exists.',
        btnOkOnPress: () {},
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
              child: globalWidgets.myText(context, 'Step 3', ColorsX.yellowColor, 0, 10, 10, 0, FontWeight.w600, 16),
            ),
          ),
        ],
      ),
    );
  }

  void saveIdInLocal(String? value)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', "${value}");
    print('ID STORED '+ "${value}");
  }


  removeItem(String type) async {

    var itemToBeRemoved = [];
    itemToBeRemoved.add(type);
    GlobalWidgets.showProgressLoader("Please wait");
    CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
    await users
        .doc(GlobalVariables.idOfProposal)
        .update({'profession_demand': FieldValue.arrayRemove(itemToBeRemoved)})
        .then((value) => debugPrint('ok'))
        .catchError((error) => debugPrint('error'));
    GlobalWidgets.hideProgressLoader();
  }
}
