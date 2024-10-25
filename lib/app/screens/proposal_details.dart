import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes/app_pages.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../utils/global_widgets.dart';
import '../utils/size_config.dart';


class ProposalDetails extends StatefulWidget {
  const ProposalDetails({Key? key}) : super(key: key);

  @override
  _ProposalDetailsState createState() => _ProposalDetailsState();
}

class _ProposalDetailsState extends State<ProposalDetails> {
  GlobalWidgets globalWidgets = GlobalWidgets();
  // ProposalDetailModel? proposalDetailModel;
  DocumentSnapshot? documentSnapshot;
  DocumentSnapshot? updateDocumentSnapshot;
  Map<String, dynamic>? fetchDoc;
  Map<String, dynamic>? updateVerifiedDoc;
  Map<String, dynamic>? myProfileDoc;
  String addedToFavourite = '';
  TextEditingController issueDescriptionCtl = new TextEditingController();
  var blockedUsers = [];
  String age = '';

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
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
        title: globalWidgets.myText(context, "Proposal Detail", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
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
              color:  const Color(0xff000000).withOpacity(0.8),
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
    String professiontemp = '${fetchDoc?['profession']}';
    String professions = professiontemp.replaceAll(']', '');
    String profession = professions.replaceAll('[', '');
    // String requiredprofessiontemp = '${fetchDoc?['profession_demand'].replaceAll('[', '')}';
    String requiredprofessiontemp = '${fetchDoc?['profession_demand']}';
    String professionRequirement = requiredprofessiontemp.replaceAll(']', '');
    String professionRequired = professionRequirement.replaceAll('[', '');
    String requiredHousePossessiontemp = '${fetchDoc?['housing_demand_possession'].replaceAll('[', '')}';
    String housePossession = requiredHousePossessiontemp.replaceAll(']', '');
    String requiredHouseLocationtemp = '${fetchDoc?['housing_demand_location'].replaceAll('[', '')}';
    String location = requiredHouseLocationtemp.replaceAll(']', '');

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      // child: proposalDetailModel == null ? Container() : ListView(
      child: documentSnapshot == null ? Container() : ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.screenHeight * .25,
              margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
              // child: Icon('${fetchDoc?['gender']}' == 'Male' ? FontAwesomeIcons.male : FontAwesomeIcons.female, size: 80)),
              // child: FaIcon('${fetchDoc?['gender']}' == "Male" ? FontAwesomeIcons.male : FontAwesomeIcons.female, size: 30, color: ColorsX.white,),),
              child: Image.asset('${fetchDoc?['gender']}' == 'Male' ? 'assets/images/man.png' : 'assets/images/woman.png', fit: BoxFit.contain, ),),
          ),
          // addToFavourites(context),

          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.infoCircle, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Basic Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'ID', '${proposalDetailModel?.serverResponse.basicDetails.id}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.id}'
          //     ,ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'ID', '${GlobalVariables.idOfProposal}'
          //     ,ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Profile Created By', '${proposalDetailModel?.serverResponse.basicDetails.profileCreatedBy}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.profileCreatedBy}'
          //     ,ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Profile Created By', '${fetchDoc?['profile_created_by']}'
              ,ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Name', '${proposalDetailModel?.serverResponse.others.name}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.others.name}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Name', '${fetchDoc?['name']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Caste', '${proposalDetailModel?.serverResponse.basicDetails.caste}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.caste}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Caste', '${fetchDoc?['caste']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Sub-caste', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.subcaste}') == "null" ? "" :
          // heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.subcaste}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Sub-caste', heightCalculate('${fetchDoc?['subcaste']}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Mother Tongue', '${proposalDetailModel?.serverResponse.basicDetails.motherTongue}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.motherTongue} Speaking',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Mother Tongue', '${fetchDoc?['mother_tongue']} Speaking',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Age', ageCalculate('${proposalDetailModel?.serverResponse.basicDetails.dob}') == "null" ? "" :
          // ageCalculate('${proposalDetailModel?.serverResponse.basicDetails.dob}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Age', ageCalculate('${fetchDoc?['dob']}') == "null" ? "" :
          ageCalculate('${fetchDoc?['dob']}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Gender', '${proposalDetailModel?.serverResponse.basicDetails.gender}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.gender}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Gender', '${fetchDoc?['gender']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Height', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.height}') == "null" ? "" :
          // heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.height}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Height', heightCalculate('${fetchDoc?['height']}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Marital Status', '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Marital Status', '${fetchDoc?['marital_status']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Email', '${fetchDoc?['email']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Password', '${fetchDoc?['password']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // Visibility(
          //   visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
          //     child: heading(context, 'Reason for Second Marriage', '${proposalDetailModel?.serverResponse.basicDetails.reasonForSecondMarriage}' == "null" ? "" :
          //     '${proposalDetailModel?.serverResponse.basicDetails.reasonForSecondMarriage}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // ),
          Visibility(
              visible: '${fetchDoc?['marital_status']}' == 'Single' ? false : true,
              child: Divider(
                color: Colors.white,
              )
          ),
          Visibility(
            visible: '${fetchDoc?['marital_status']}' == 'Single' ? false : true,
            child: heading(context, 'Reason for Second Marriage', '${fetchDoc?['reason_for_second_marriage']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          // Visibility(
          //   visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
          //   child: heading(context, 'Marriage Period', '${proposalDetailModel?.serverResponse.basicDetails.marriagePeriod}' == "null" ? "" :
          //   '${proposalDetailModel?.serverResponse.basicDetails.marriagePeriod} yrs',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // ),
          Visibility(
            visible: '${fetchDoc?['marital_status']}' == 'Single' ? false : true,
            child: heading(context, 'Marriage Period', '${fetchDoc?['marriage_period']} yrs',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          // Visibility(
          //   visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
          //   child: heading(context, 'Separation Period', '${proposalDetailModel?.serverResponse.basicDetails.separationPeriod}' == "null" ? "" :
          //   '${proposalDetailModel?.serverResponse.basicDetails.separationPeriod} yrs',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // ),
          Visibility(
            visible: '${fetchDoc?['marital_status']}' == 'Single' ? false : true,
            child: heading(context, 'Separation Period', '${fetchDoc?['separation_period']} yrs',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          // Visibility(
          //   visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
          //   child: heading(context, 'Kids', '${proposalDetailModel?.serverResponse.basicDetails.kids}' == "null" ? "" :
          //   '${proposalDetailModel?.serverResponse.basicDetails.kids}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // ),
          Visibility(
            visible: '${fetchDoc?['marital_status']}' == 'Single' ? false : true,
            child: heading(context, 'Kids', '${fetchDoc?['kids']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          // Visibility(
          //   visible: '${proposalDetailModel?.serverResponse.basicDetails.maritalStatus}' == 'Single' ? false : true,
          //   child: heading(context, 'Kids Ownership', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.kidsOwnership}') == "null" ? "" :
          //   heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.kidsOwnership}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // ),
          Visibility(
            visible: '${fetchDoc?['marital_status']}' == 'Single' ? false : true,
            child: heading(context, 'Kids Ownership', heightCalculate('${fetchDoc?['kids_ownership']}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.houseUser, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Place of Living', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'City', '${proposalDetailModel?.serverResponse.basicDetails.city}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.city}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'City', '${fetchDoc?['city']}',ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Area', '${proposalDetailModel?.serverResponse.basicDetails.area}' == "null" ? "" :
          // '${proposalDetailModel?.serverResponse.basicDetails.area}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Area', '${fetchDoc?['area']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.bookOpen, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Qualification', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'Latest Education', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.qualification}') == "null" ? "" :
          // heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.qualification}'),ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Latest Education', heightCalculate('${fetchDoc?['qualification']}'),ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),

          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.personBooth, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Professional Information', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'Profession', '${proposalDetailModel?.serverResponse.basicDetails.profession}' == "null" ? "" :
          // '${profession}',ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Profession', '${fetchDoc?['profession']}' == "null" ? "" :
          '${profession}',ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Occupation', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.occupation}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Occupation', heightCalculate('${fetchDoc?['occupation']}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Salary', heightCalculate('${proposalDetailModel?.serverResponse.basicDetails.monthlyIncome}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Salary', heightCalculate('${fetchDoc?['monthly_income']}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.solidObjectGroup, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Family Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'Mother Alive', '${proposalDetailModel?.serverResponse.familyDetails.motherAlive}' == '1' ? 'Yes' : "No",ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Mother Alive', '${fetchDoc?['mother_alive']}' == '1' ? 'Yes' : "No",ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Father Alive', '${proposalDetailModel?.serverResponse.familyDetails.fatherAlive}' == '1' ? 'Yes' : "No",ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Father Alive', '${fetchDoc?['father_alive']}' == '1' ? 'Yes' : "No",ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Father\u0027s Occupation', heightCalculate('${proposalDetailModel?.serverResponse.familyDetails.fathersOccupation}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Father\u0027s Occupation', heightCalculate('${fetchDoc?['fathers_occupation']}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Mother\u0027s Occupation', '${proposalDetailModel?.serverResponse.basicDetails.mo}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Siblings', '${proposalDetailModel?.serverResponse.familyDetails.siblings}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Siblings', '${fetchDoc?['siblings']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Married Brothers', '${proposalDetailModel?.serverResponse.familyDetails.marriedBrothers}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Married Brothers', '${fetchDoc?['married_brothers']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Married Sisters', '${proposalDetailModel?.serverResponse.familyDetails.marriedSisters}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Married Sisters', '${fetchDoc?['married_sisters']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Unmarried Brothers', '${proposalDetailModel?.serverResponse.familyDetails.unmarriedBrothers}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Unmarried Brothers', '${fetchDoc?['unmarried_brothers']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Unmarried Sisters', '${proposalDetailModel?.serverResponse.familyDetails.unmarriedSisters}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Unmarried Sisters', '${fetchDoc?['unmarried_sisters']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.mosque, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Religion Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'Religion', '${proposalDetailModel?.serverResponse.basicDetails.religion}',ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Religion', '${fetchDoc?['religion']}',ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Sect', '${proposalDetailModel?.serverResponse.basicDetails.sect}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Sect', '${fetchDoc?['sect']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.houseDamage, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Housing Details', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'House Area', '${proposalDetailModel?.serverResponse.familyDetails.houseArea} ${proposalDetailModel?.serverResponse.familyDetails.houseIn}',ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'House Area', '${fetchDoc?['house_area']} ${fetchDoc?['house_in']}',ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'House Possession', '${proposalDetailModel?.serverResponse.familyDetails.possession}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'House Possession', '${fetchDoc?['possession']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Location', '${proposalDetailModel?.serverResponse.basicDetails.area}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Location', '${fetchDoc?['area']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Area', "Lower Mall",ColorsX.greyBackground.withOpacity(0.8), 0, 10, 0, 0, FontWeight.w700, 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.forward, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Additional Information', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'Additional Information', heightCalculate('${proposalDetailModel?.serverResponse.familyDetails.additionalInfo}'),ColorsX.greyBackground.withOpacity(0.8), 20, 10, 10, 0, FontWeight.w400, 15),
          heading(context, 'Additional Information', heightCalculate('${fetchDoc?['additional_info']}'),ColorsX.greyBackground.withOpacity(0.8), 20, 10, 10, 0, FontWeight.w400, 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.solidHeart, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Required Proposal', ColorsX.yellowColor, 25, 10, 0, 0, FontWeight.w900, 20),
            ],
          ),
          // heading(context, 'Caste Specific', '${proposalDetailModel?.serverResponse.demands.casteDemand}' == "1" ? "Please Contact only if Caste Matches" :
          // '${proposalDetailModel?.serverResponse.demands.casteDemand}' == "2" ? "Out of Caste can contact" : "No Caste Specific Demand",ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Caste Specific', '${fetchDoc?['caste_demand']}' == "1" ? "Please Contact only if Caste Matches" :
          '${fetchDoc?['caste_demand']}' == "2" ? "Out of Caste can contact" : "No Caste Specific Demand",ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Caste Restriction', '${proposalDetailModel?.serverResponse.demands.casteDemand}' == "1" ? "Yes" : "No",ColorsX.greyBackground.withOpacity(0.8), 2, 10, 10, 0, FontWeight.w400, 15),
          heading(context, 'Caste Restriction', '${fetchDoc?['caste_demand']}' == "1" ? "Yes" : "No",ColorsX.greyBackground.withOpacity(0.8), 2, 10, 10, 0, FontWeight.w400, 15),
          heading(context, 'Profession', '${professionRequired}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 10, 0, FontWeight.w400, 15),
          // heading(context, 'Age Limit', '${proposalDetailModel?.serverResponse.demands.ageLimit} yrs',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Age Limit', '${fetchDoc?['age_limit']} yrs',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Min Height', heightCalculate('${proposalDetailModel?.serverResponse.demands.heightDemand}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Min Height', heightCalculate('${fetchDoc?['height_demand']}'),ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'Min House Area', '${proposalDetailModel?.serverResponse.demands.housingDemandArea}'
          //     ' ${proposalDetailModel?.serverResponse.demands.housingDemandIn}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Min House Area', '${fetchDoc?['housing_demand_area']}'
              ' ${fetchDoc?['housing_demand_in']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'House Possession', '${housePossession}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Location', '${location}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          // heading(context, 'City', '${proposalDetailModel?.serverResponse.demands.cityDemand}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'City', '${fetchDoc?['city_demand']}',ColorsX.greyBackground.withOpacity(0.8), 2, 10, 0, 0, FontWeight.w400, 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20,left: 10, bottom: 0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: (FaIcon(FontAwesomeIcons.forward, color: ColorsX.yellowColor,)),
              ),
              globalWidgets.myText(context, 'Additional Information', ColorsX.yellowColor, 20, 10, 0, 0, FontWeight.w700, 20),
            ],
          ),
          // heading(context, 'Additional Demands', heightCalculate('${proposalDetailModel?.serverResponse.demands.additionalDemand}'),ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          heading(context, 'Additional Demands', heightCalculate('${fetchDoc?['additional_demand']}'),ColorsX.greyBackground.withOpacity(0.8), 20, 10, 0, 0, FontWeight.w400, 15),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Divider(
              color: ColorsX.white,
            ),
          ),
          SizedBox(height: 30,),
          buttonsLayout(context),
          SizedBox(height: 30,),
          reportUser(context),
          SizedBox(height: 15,),
          reportAndBlockUser(context),
          SizedBox(height: 15,),
          verifyUser(context),
          SizedBox(height: 15,),
          holdUser(context),
          SizedBox(height: 15,),
          makeFeatured(context),
          SizedBox(height: 15,),
          removeFeatured(context),
          SizedBox(height: 15,),
          whatsApp(context),
          SizedBox(height: 15,),
          editProfile(context),
          SizedBox(height: 15,),
          writeEmail(context),
          SizedBox(height: 15,),
          deleteUser(context),
          SizedBox(height: 50,),
        ],
      ),
    );
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

  verifyUser(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.greenish,
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
            updateAndVerify(context);
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
                    child: Icon(Icons.verified_user, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Verify User", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  holdUser(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.greenish,
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
            openDialogForHold();
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
                    child: Icon(Icons.verified_user, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Hold Profile", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  makeFeatured(BuildContext context){

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.black,
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
            featured(context, "1", "Added to featured");
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
                    child: Icon(Icons.featured_play_list, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Make Featured", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  removeFeatured(BuildContext context){

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.black,
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
            featured(context, "0", "Removed from featured");
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
                    child: Icon(Icons.remove_circle, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Remove from Featured", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  editProfile(BuildContext context){

    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.blue_button_color,
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
            Get.toNamed(Routes.EDIT_PROFILE_NEW);
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
                    child: Icon(Icons.edit, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Edit Profile", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  writeEmail(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.blue_button_color,
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
            final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: '${fetchDoc?['email']}',
                queryParameters: {
                  'subject': 'Rishta Nagar support team requesting for a call'
                }
            );
            launch(_emailLaunchUri.toString());
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
                    child: Icon(Icons.email, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Write Email", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  deleteUser(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorsX.greenish,
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
            deleteProfileNow(context);
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
                    child: Icon(Icons.delete, color: ColorsX.white,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: globalWidgets.myText(context, "Delete Profile", ColorsX.white, 0, 0, 0, 0, FontWeight.w900, 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  deleteProfileNow(BuildContext context) async {

    GlobalWidgets.showProgressLoader("Please Wait");
    await FirebaseFirestore.instance.collection('candidates')
        .doc(GlobalVariables.idOfProposal).delete();
    GlobalWidgets.hideProgressLoader();
    successDialog('Deleted', 'This profile has been deleted');
  }
  openDialogForHold(){
    return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  color: Colors.black.withOpacity(0.7),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        "Write down the reason to hold this profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      globalWidgets.myTextField(TextInputType.text, issueDescriptionCtl, false, 'Reason'),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              child: const Text(
                                'NO',
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              child: const Text(
                                'YES',
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if(issueDescriptionCtl.text.trim().isEmpty){
                                  GlobalWidgets.showErrorToast(context, 'Reason required', 'Please give the reason');
                                } else {
                                  holdNow(context, issueDescriptionCtl.text.toString());
                                  Get.back();
                                }
                              },
                            ),
                          ),
                        ],
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
  whatsApp(BuildContext context){
    return Visibility(
      visible: true,
      child: GestureDetector(
        onTap: () async {
          var whatsapp = '${fetchDoc?['primary_phone']}';
          if(whatsapp.startsWith('0')){
            whatsapp = whatsapp.substring(1, 11);
            whatsapp = '+92'+whatsapp;
          }
          debugPrint(whatsapp);
          var whatsappURl_android = '';
          whatsappURl_android = "https://wa.me/${whatsapp}?text= Hello, I am support officer from Rishta Nagar app.";
          // var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("${text}")}";
          if(Platform.isAndroid){
            try{
              await launch(whatsappURl_android);
            }
            catch (e){
              print(e.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: new Text("Problem occured. Please Use Direct Call Method")));
            }
            // if( await canLaunch(whatsappURl_android)){
            //   await launch(whatsappURl_android);
            // }else{
            //   ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(content: new Text("whatsapp not installed")));
            // }
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10,),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: ColorsX.whatsappGreen,
              border: Border.all(color: ColorsX.whatsappGreen)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: (FaIcon(FontAwesomeIcons.whatsapp, color: ColorsX.white,)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  holdNow(BuildContext context, String text) async {

    GlobalWidgets.showProgressLoader("Please Wait");
    CollectionReference candidates =  FirebaseFirestore.instance.collection('candidates');
    await candidates
        .doc(GlobalVariables.idOfProposal)
        .update({'is_verified': 'On Hold '+ '$text' })
        .then((value) => successDialog("On Hold", 'This profile is now on hold'))
        .catchError((error) => successDialog("Failed to hold: ",'$error'));
    GlobalWidgets.hideProgressLoader();
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: globalWidgets.myText(context, text, colorsX, top, left, right, bottom, fontWeight, fontSize)),
        Expanded(child: globalWidgets.myText(context, detail, ColorsX.white.withOpacity(0.9), top, left, right, bottom, fontWeight, fontSize),
        ),
      ],
    );
  }


  void loadDetails() async{

    GlobalWidgets.showProgressLoader("Please Wait");
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('candidates')
        .doc(GlobalVariables.idOfProposal).get();
    if(snapshot.exists){
      fetchDoc = snapshot.data() as Map<String, dynamic>?;
      GlobalWidgets.hideProgressLoader();
      // var listOfBlockedPeople = '${fetchDoc?['is_blocked_by']}';
      // if(listOfBlockedPeople.contains(GlobalVariables.my_ID)){
      //   errorDialogForBlocked(context);
      // }
      // else {
        setState(() {
          documentSnapshot = snapshot;
        });
      // }
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

  updateAndVerify(BuildContext context) async {

    GlobalWidgets.showProgressLoader("Please Wait");
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('admins')
        .doc(GlobalVariables.my_ID).get();
    if(snapshot.exists){
      updateVerifiedDoc = snapshot.data() as Map<String, dynamic>?;
      var listOfVerifiedPeople = '${updateVerifiedDoc?['verified_profiles']}';
      if(listOfVerifiedPeople.contains(GlobalVariables.idOfProposal)){
        errorDialogUpdate(context, 'This profile is already verified');
      }
      else{
        var valueTobeAdd = [];
        valueTobeAdd.add(GlobalVariables.idOfProposal);
        CollectionReference candidates =  FirebaseFirestore.instance.collection('candidates');
        await candidates
            .doc(GlobalVariables.idOfProposal)
            .update(
            {
              'is_verified': '1',
              'account_verification_date': formattedDate().toString()
            })
            .then((value) => successDialog("Verified", 'This profile is verified'))
            .catchError((error) => successDialog("Failed to verify: ",'$error'));

        CollectionReference users =  FirebaseFirestore.instance.collection('admins');
        await users
            .doc(GlobalVariables.my_ID)
            .update({'verified_profiles': FieldValue.arrayUnion(valueTobeAdd)})
            .then((value) => successDialog("Verified", 'This profile is verified'))
            .catchError((error) => successDialog("Failed to verify: ",'$error'));
      }
      setState(() {
        updateDocumentSnapshot = snapshot;
      });

      GlobalWidgets.hideProgressLoader();
    }
    else{
      GlobalWidgets.hideProgressLoader();
      errorDialog(context);
    }
  }
  featured(BuildContext context, String value, String msg) async {

    GlobalWidgets.showProgressLoader("Please Wait");
    CollectionReference candidates =  FirebaseFirestore.instance.collection('candidates');
    await candidates
        .doc(GlobalVariables.idOfProposal)
        .update({'is_featured': value, 'featured_start_date': value == "1" ? formattedDate() : "0"})
        .then((value) => successDialog("Featured", msg))
        .catchError((error) => successDialog("Failed to featured: ",'$error'));

    GlobalWidgets.hideProgressLoader();
  }

  formattedDate(){
    DateTime dateTime = DateTime.now();
    return dateTime.toString();
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
        '$error',
        btnOkOnPress: () {
          Get.back();
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

  addProfileViews() async {
    var profileViewsHis = '${fetchDoc?['profile_views_his']}';
    /**
     * updating the views of other user's profile as well
     */
    if(profileViewsHis == '0' || profileViewsHis.isEmpty
        || profileViewsHis == 'null' || profileViewsHis == "[]"){

      try {


        List<Map<String, dynamic>> profileViewsOthers = [];
        Map<String, dynamic> myObject = {
          'name': '${myProfileDoc?['name']}',
          'id': GlobalVariables.my_ID,
          'profile_created_by': '${myProfileDoc?['profile_created_by']}',
          'qualification': '${myProfileDoc?['qualification']}',
          'profile_viewed_at': formattedDate()
        } ;
        profileViewsOthers.add(myObject);
        GlobalWidgets.showProgressLoader("Please wait");
        CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
        await users
            .doc(GlobalVariables.idOfProposal)
            .update({'profile_views_his': FieldValue.arrayUnion(profileViewsOthers)})
            .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
            .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
        // apiCallForNotification();
      }
      on Exception catch(e) {
        print(e);
      }

    }
    else if(!profileViewsHis.contains(GlobalVariables.my_ID)){



      try {


        List<Map<String, dynamic>> profileViewsOthers = [];
        Map<String, dynamic> myObject = {
          'name': '${myProfileDoc?['name']}',
          'id': GlobalVariables.my_ID,
          'profile_created_by': '${myProfileDoc?['profile_created_by']}',
          'qualification': '${myProfileDoc?['qualification']}',
          'profile_viewed_at': formattedDate()
        } ;
        profileViewsOthers.add(myObject);
        GlobalWidgets.showProgressLoader("Please wait");
        CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
        await users
            .doc(GlobalVariables.idOfProposal)
            .update({'profile_views_his': FieldValue.arrayUnion(profileViewsOthers)})
            .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
            .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
        // apiCallForNotification();
      }
      on Exception catch(e) {
        print(e);
      }
    }
    else if(profileViewsHis.contains(GlobalVariables.my_ID)){
      debugPrint('already contains');
    }
  }

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

  profileViewsOthers() async {

    /**
     * first we will update the views of the user who is viewing the profile
     */

    GlobalWidgets.showProgressLoader("Please Wait");
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('candidates')
        .doc(GlobalVariables.my_ID).get();
    if(snapshot.exists) {
      myProfileDoc = snapshot.data() as Map<String, dynamic>?;
      GlobalWidgets.hideProgressLoader();
    }
    List<String> profileViewsOthers = [];
    var profiles = '${myProfileDoc?['profile_views_others']}';
    if(profiles.isEmpty || profiles == '0' || profiles == 'null' || profiles == "[]"){
      List<Map<String, dynamic>> profileViewsOthers = [];
      Map<String, dynamic> myObject = {'name': '${fetchDoc?['name']}',
        'id': GlobalVariables.idOfProposal,
        'profile_created_by': '${fetchDoc?['profile_created_by']}',
        'qualification': '${fetchDoc?['qualification']}',
        'profile_viewed_at': formattedDate()
      };
      profileViewsOthers.add(myObject);
      GlobalWidgets.showProgressLoader("Please wait");
      CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
      await users
          .doc(GlobalVariables.my_ID)
          .update({'profile_views_others': profileViewsOthers})
          .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
          .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
    }else if(!profiles.contains(GlobalVariables.idOfProposal)){
      try {

        List<Map<String, dynamic>> profileViewsOthers = [];
        Map<String, dynamic> myObject = {'name': '${fetchDoc?['name']}',
          'id': GlobalVariables.idOfProposal,
          'profile_created_by': '${fetchDoc?['profile_created_by']}',
          'qualification': '${fetchDoc?['qualification']}',
          'profile_viewed_at': formattedDate()
        } ;
        profileViewsOthers.add(myObject);
        GlobalWidgets.showProgressLoader("Please wait");
        CollectionReference users =  FirebaseFirestore.instance.collection('candidates');
        await users
            .doc(GlobalVariables.my_ID)
            .update({'profile_views_others': FieldValue.arrayUnion(profileViewsOthers)})
            .then((value) => DialogForBackendNotificationAndUpdates('Profile Views Others Updated'))
            .catchError((error) => DialogForBackendNotificationAndUpdates("Profile Views Others Updated Error "+'$error'));
      }
      on Exception catch(e) {
        print(e);
      }
    }
    addProfileViews();
  }
}
