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


class NewProfilesInWeek extends StatefulWidget {
  const NewProfilesInWeek({Key? key}) : super(key: key);

  @override
  _NewProfilesInWeekState createState() => _NewProfilesInWeekState();
}

class _NewProfilesInWeekState extends State<NewProfilesInWeek> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalWidgets globalWidgets = GlobalWidgets();
  CacheData cacheData = CacheData();
  // ProposalListModel? proposalListModel;
  // ByCasteProposalsModel? byCasteProposalsModel;
  List<DocumentSnapshot> documentsWithinWeek = [];
  List<DocumentSnapshot> documentsByCaste = [];
  String selectedCasteType = '';
  String? gender = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserData();
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
        title: globalWidgets.myText(context, GlobalVariables.valueChosen == '' ? "New Profiles" : GlobalVariables.valueChosen, ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
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
      child: Stack(
        children: <Widget>[
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              // color:  const Color(0xff70b4ff).withOpacity(0.8),
              color:  const Color(0xff000000).withOpacity(0.8),
            ),
            child: listViewContent(context),
          ),
        ],
      ),
    );
  }
  listViewContent(BuildContext context){
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: customItemDesign(context),
    );
  }
  listViewContentCaste(BuildContext context){
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: customItemDesignCaste(context),
    );
  }

  proposals(BuildContext context){
    return ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) =>Divider(height: 1, color: ColorsX.light_orange),
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Get.toNamed(Routes.PROPOSALS_DETAIL);
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(

                leading: CircleAvatar(
                  backgroundColor: ColorsX.yellowColor,
                  child: globalWidgets.myText(context, (index+1).toString(), ColorsX.black, 0, 0, 0, 0, FontWeight.w400, 12),
                ),
                title: globalWidgets.myText(context, index%2==0 ? "Siddiqui" : "Hashmi Qureshi", ColorsX.yellowColor, 0, 0, 0, 0, FontWeight.w900, 14),
                subtitle: globalWidgets.myText(context, "32 yrs | 5\u00276 \nEngineer | Software Engineer\n"
                    "DHA Lahore", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 13),
                trailing: globalWidgets.myText(context, "12 days ago", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 13),
              ),
            ),
          );
        }
    );

  }
  customItemDesign(BuildContext context){
    // int length = proposalListModel?.serverResponse.length ?? 0;
    int length = documentsWithinWeek.length ?? 0;
    return ListView.separated(
        itemCount: length,
        separatorBuilder: (context, index) =>Divider(height: 1, color: ColorsX.light_orange),
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              // GlobalVariables.idOfProposal = "${proposalListModel?.serverResponse[index].basicDetails.id}";
              GlobalVariables.idOfProposal = "${documentsWithinWeek[index].reference.id}";
              GlobalVariables.isMyProfile = false;
              print(GlobalVariables.idOfProposal);
              Get.toNamed(Routes.PROPOSALS_DETAIL);
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 8.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 3, right: 3, bottom: 5),
                        child: Image.asset("${documentsWithinWeek[index].get('gender')}" == 'Male' ? 'assets/images/man.png' : 'assets/images/woman.png', fit: BoxFit.contain, height: 30,width: 30,),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: CircleAvatar(
                      //     backgroundColor: ColorsX.yellowColor,
                      //     // child: globalWidgets.myText(context, (index+1).toString(), ColorsX.black, 0, 0, 0, 0, FontWeight.w400, 12),
                      //     child: FaIcon(FontAwesomeIcons.handshake, color: ColorsX.black,)
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(width: 8.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // globalWidgets.myText(context, "${proposalListModel?.serverResponse[index].basicDetails.caste}", ColorsX.yellowColor, 5, 0, 0, 0, FontWeight.w900, 14),
                      globalWidgets.myText(context, "${documentsWithinWeek[index].get('caste')}", ColorsX.yellowColor, 5, 0, 0, 0, FontWeight.w900, 14),
                      // globalWidgets.myText(context, ageCalculate("${proposalListModel?.serverResponse[index].basicDetails.dob}") + " | " +heightCalculate("${proposalListModel?.serverResponse[index].basicDetails.height}"), ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                      globalWidgets.myText(context, ageCalculate("${documentsWithinWeek[index].get('dob')}") + " | " +heightCalculate("${documentsWithinWeek[index].get('height')}"), ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                      Container(
                        width: SizeConfig.screenWidth* .55,
                        // child: globalWidgets.myTextCustom(context, "${proposalListModel?.serverResponse[index].basicDetails.occupation} | ${proposalListModel?.serverResponse[index].basicDetails.qualification}",
                        //     ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                        child: globalWidgets.myTextCustom(context, "${documentsWithinWeek[index].get('occupation')} | ${documentsWithinWeek[index].get('qualification')}",
                            ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                      ),
                      // globalWidgets.myText(context, "${proposalListModel?.serverResponse[index].basicDetails.area}", ColorsX.white, 5, 0, 0, 5, FontWeight.w400, 12),
                      Container(
                        width: SizeConfig.screenWidth* .58,
                        child: globalWidgets.myTextCustomOneLine(context, "${documentsWithinWeek[index].get('city')} | ${documentsWithinWeek[index].get('area')}", ColorsX.white, 5, 0, 0, 5, FontWeight.w600, 14),
                      ),
                      Visibility(
                        visible: "${documentsWithinWeek[index].get('is_verified')}" != "0",
                        child: globalWidgets.myText(context, "${documentsWithinWeek[index].get('is_verified')}" == "1"
                            ? "Verified" : "${documentsWithinWeek[index].get('is_verified')}", "${documentsWithinWeek[index].get('is_verified')}" == "1" ? ColorsX.greenish
                            : ColorsX.red_danger, 5, 0, 0, 0, FontWeight.w900, 18),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // globalWidgets.myText(context, accountCreated("${proposalListModel?.serverResponse[index].others.accountCreatedAt}"), ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 14),
                      globalWidgets.myText(context, accountCreated("${documentsWithinWeek[index].get('account_created_at')}"), ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 14),
                      SizedBox(height: 3,),
                      // GestureDetector(
                      //     onTap: (){
                      //
                      //     },
                      //     child: FaIcon(FontAwesomeIcons.heart, color: ColorsX.white,))
                    ],
                  ),
                  SizedBox(width: 8.0,),
                ],
              ),
              // child: ListTile(
              //
              //   leading: CircleAvatar(
              //     backgroundColor: ColorsX.yellowColor,
              //     child: globalWidgets.myText(context, (index+1).toString(), ColorsX.black, 0, 0, 0, 0, FontWeight.w400, 12),
              //   ),
              //   title: globalWidgets.myText(context, index%2==0 ? "Siddiqui" : "Hashmi Qureshi", ColorsX.yellowColor, 0, 0, 0, 0, FontWeight.w900, 14),
              //   subtitle: globalWidgets.myText(context, "32 yrs | 5\u00276 \nEngineer | Software Engineer\n"
              //       "DHA Lahore", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 13),
              //   trailing: globalWidgets.myText(context, "16 days ago", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 13),
              // ),
            ),
          );
        }
    );
  }
  customItemDesignCaste(BuildContext context){
    // int length = byCasteProposalsModel?.serverResponse.length ?? 0;
    int length = documentsByCaste.length ?? 0;
    return ListView.separated(
        itemCount: length,
        separatorBuilder: (context, index) =>Divider(height: 1, color: ColorsX.light_orange),
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              // GlobalVariables.idOfProposal = "${byCasteProposalsModel?.serverResponse[index].basicDetails.id}";
              GlobalVariables.idOfProposal = "${documentsByCaste[index].reference.id}";
              print(GlobalVariables.idOfProposal);
              GlobalVariables.isMyProfile = false;
              Get.toNamed(Routes.PROPOSALS_DETAIL);
            },
            child: Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 8.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 3, right: 3, bottom: 5),
                        child: Image.asset('$gender' == 'Male' ? 'assets/images/woman.png' : 'assets/images/man.png', fit: BoxFit.contain, height: 30,width: 30,),
                      ),
                    ],
                  ),
                  SizedBox(width: 8.0,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // globalWidgets.myText(context, "${byCasteProposalsModel?.serverResponse[index].basicDetails.caste}", ColorsX.yellowColor, 5, 0, 0, 0, FontWeight.w900, 14),
                      globalWidgets.myText(context, "${documentsByCaste[index].get('caste')}", ColorsX.yellowColor, 5, 0, 0, 0, FontWeight.w900, 14),
                      // globalWidgets.myText(context, ageCalculate("${byCasteProposalsModel?.serverResponse[index].basicDetails.dob}") + " | " +
                      //     heightCalculate("${byCasteProposalsModel?.serverResponse[index].basicDetails.height}"), ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                      globalWidgets.myText(context, ageCalculate("${documentsByCaste[index].get('dob')}") + " | " +
                          heightCalculate("${documentsByCaste[index].get('height')}"), ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                      Container(
                        width: SizeConfig.screenWidth* .55,
                        // child: globalWidgets.myTextCustom(context, "${byCasteProposalsModel?.serverResponse[index].basicDetails.occupation} | ${byCasteProposalsModel?.serverResponse[index].basicDetails.qualification}",
                        //     ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                        child: globalWidgets.myTextCustom(context, "${documentsByCaste[index].get('occupation')} | ${documentsByCaste[index].get('qualification')}",
                            ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                      ),
                      // globalWidgets.myText(context, "${byCasteProposalsModel?.serverResponse[index].basicDetails.area}", ColorsX.white, 5, 0, 0, 5, FontWeight.w400, 12),
                      Container(
                        width: SizeConfig.screenWidth* .58,
                        child: globalWidgets.myTextCustomOneLine(context, "${documentsByCaste[index].get('city')} | ${documentsByCaste[index].get('area')}", ColorsX.white, 5, 0, 0, 5, FontWeight.w600, 14),

                      ),
                      Visibility(
                        visible: "${documentsByCaste[index].get('is_verified')}" == "1",
                        child: globalWidgets.myText(context, "Verified", ColorsX.greenish, 5, 0, 0, 0, FontWeight.w900, 18),
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // globalWidgets.myText(context, accountCreated("${byCasteProposalsModel?.serverResponse[index].others.accountCreatedAt}"), ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 14),
                      globalWidgets.myText(context, accountCreated("${documentsByCaste[index].get('account_created_at')}"), ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 14),
                      SizedBox(height: 3,),
                      // GestureDetector(
                      //     onTap: (){
                      //
                      //     },
                      //     child: FaIcon(FontAwesomeIcons.heart, color: ColorsX.white,))
                    ],
                  ),
                  SizedBox(width: 8.0,),
                ],
              ),
              // child: ListTile(
              //
              //   leading: CircleAvatar(
              //     backgroundColor: ColorsX.yellowColor,
              //     child: globalWidgets.myText(context, (index+1).toString(), ColorsX.black, 0, 0, 0, 0, FontWeight.w400, 12),
              //   ),
              //   title: globalWidgets.myText(context, index%2==0 ? "Siddiqui" : "Hashmi Qureshi", ColorsX.yellowColor, 0, 0, 0, 0, FontWeight.w900, 14),
              //   subtitle: globalWidgets.myText(context, "32 yrs | 5\u00276 \nEngineer | Software Engineer\n"
              //       "DHA Lahore", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 13),
              //   trailing: globalWidgets.myText(context, "16 days ago", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 13),
              // ),
            ),
          );
        }
    );
  }
  // proposals(BuildContext context, int index){
  //
  //   return Container(
  //     width: SizeConfig.screenWidth,
  //     margin: EdgeInsets.only(left: 10, right: 10),
  //     child : GestureDetector(
  //       onTap: (){
  //         Get.toNamed(Routes.PROPOSALS_DETAIL);
  //       },
  //       child: Card(
  //         color:  const Color(0xffE1e1e1),
  //         // shape: RoundedRectangleBorder(
  //         //   borderRadius: BorderRadius.circular(20),
  //         // ),
  //         child: Container(
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 8.0),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(horizontal: 3.0),
  //                             child: Container(
  //                               child: globalWidgets.myText(context, "Siddiqui", ColorsX.black, 2, 0, 5, 0, FontWeight.w900, 20),
  //                             ),
  //                           ),
  //                         ),
  //
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           children: [
  //
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Container(
  //                                 margin: EdgeInsets.only( top: 0),
  //                                 child: Padding(
  //                                   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
  //                                   child: globalWidgets.myText(context, "32 Yrs", ColorsX.light_orange, 0, 0, 0, 0, FontWeight.w700, 16),
  //                                 ),
  //                               ),
  //                             ),
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Container(
  //                                 margin: EdgeInsets.only( top: 0),
  //                                 child: Padding(
  //                                   padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  //                                   child: globalWidgets.myText(context, " | ", ColorsX.black, 0, 0, 0, 0, FontWeight.w700, 16),
  //                                 ),
  //                               ),
  //                             ),
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Container(
  //                                 margin: EdgeInsets.only( top: 0),
  //                                 child: Padding(
  //                                   padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  //                                   child: globalWidgets.myText(context, " 5\u00276", ColorsX.light_orange, 0, 0, 0, 0, FontWeight.w700, 16),
  //                                 ),
  //                               ),
  //                             ),
  //                             // Align(
  //                             //   alignment: Alignment.centerLeft,
  //                             //   child: Container(
  //                             //     margin: EdgeInsets.only( top: 5),
  //                             //     child: Padding(
  //                             //       padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
  //                             //       child: globalWidgets.myText(context, " | Ahl-e-Hadith", ColorsX.greytext, 0, 0, 0, 0, FontWeight.w600, 15),
  //                             //     ),
  //                             //   ),
  //                             // ),
  //                             // Align(
  //                             //   alignment: Alignment.centerLeft,
  //                             //   child: Container(
  //                             //     margin: EdgeInsets.only( top: 5),
  //                             //     decoration: BoxDecoration(
  //                             //       color: ColorsX.blue_text_color,
  //                             //       borderRadius: BorderRadius.all(Radius.circular(20)),
  //                             //     ),
  //                             //     child: Padding(
  //                             //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
  //                             //       child: globalWidgets.myText(context, "5 Marla (Personal)", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 15),
  //                             //     ),
  //                             //   ),
  //                             // ),
  //
  //                           ],
  //                         ),
  //                         Align(
  //                           alignment: Alignment.centerLeft,
  //                           child: Padding(
  //                             padding: const EdgeInsets.symmetric(horizontal: 6.0),
  //                             child: Container(
  //                               child: globalWidgets.myText(context, "Pharm D", ColorsX.light_orange, 0, 0, 5, 0, FontWeight.w700, 14),
  //                             ),
  //                           ),
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Align(
  //                               alignment: Alignment.centerLeft,
  //                               child: Container(
  //                                 margin: EdgeInsets.only( top: 5),
  //                                 decoration: BoxDecoration(
  //                                   color: ColorsX.blue_text_color,
  //                                   borderRadius: BorderRadius.all(Radius.circular(15)),
  //                                 ),
  //                                 child: Padding(
  //                                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
  //                                   child: globalWidgets.myText(context, "DHA Lahore", ColorsX.white, 0, 0, 0, 0, FontWeight.w400, 15),
  //                                 ),
  //                               ),
  //                         ),],),
  //
  //                         SizedBox(height: 5,),
  //                       ],
  //                     ),
  //
  //                 Align(
  //                   alignment: Alignment.topCenter,
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 6.0),
  //                     child: Container(
  //                       child: globalWidgets.myText(context, "2 months ago", ColorsX.greytext, 0, 0, 5, 0, FontWeight.w700, 14),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  ageCalculate(String birthDateString) {
    String year = birthDateString.split("/")[2];
    DateTime today = DateTime.now();
    int hisAgeValue = int.parse(year);
    int yrsOld = today.year - hisAgeValue;
    return yrsOld.toString() + " yrs";
  }

  Widget categoryType(BuildContext context, String type) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: GestureDetector(
        onTap: (){
          setState(() {
            selectedCasteType = type;
          });
        },
        child: Container(
          height: 120,
          width: SizeConfig.screenWidth * .30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(width: 2,color: ColorsX.white),
            color: selectedCasteType == type ? ColorsX.light_orange : Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  child: FaIcon(cacheData.genderOfThePerson == "Male" ? FontAwesomeIcons.female : FontAwesomeIcons.female, color: ColorsX.black,),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Container(
                    child: globalWidgets.myText(context, type, ColorsX.black, 10, 5, 5, 0, FontWeight.w400, 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loadProfessionData() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    gender = prefs.getString('gender');
    // if(gender.toString() == 'Male'){
    //   gender == 'Female';
    // }else{
    //   gender == 'Male';
    // }

    GlobalWidgets.showProgressLoader("Please wait");

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('candidates')
        .where('profession', arrayContainsAny: [GlobalVariables.valueChosen])
        .where('gender', isNotEqualTo: gender)
        .where('is_active_account', isEqualTo: '1')
    // .limit(1)
        .get();
    final List<DocumentSnapshot> firestoreResponseList = querySnapshot.docs;
    if(firestoreResponseList.isEmpty) {
      errorDialog(context);
    }
    else {
      setState(() {
        documentsWithinWeek = querySnapshot.docs;
        // GlobalVariables.featuredModelLength = documentsByCaste.length ?? 0;
        // GlobalVariables.featuredModelLength = featuredModel?.serverResponse.length ?? 0;
        print('professions length' + documentsWithinWeek.length.toString());
      });
    }
    GlobalWidgets.hideProgressLoader();
    // var _apiService = ApiService();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    // Map<String, dynamic> userInfo = Map();
    //
    // userInfo['gender'] = prefs.getString('gender');
    // userInfo['profession'] = GlobalVariables.valueChosen;
    //
    // GlobalWidgets.showProgressLoader("Please Wait");
    // GlobalWidgets.hideKeyboard(context);
    // final res = await _apiService.byProfession(apiParams: userInfo);
    // GlobalWidgets.hideProgressLoader();
    // if (res is ProposalListModel) {
    //   setState(() {
    //     proposalListModel = res;
    //   });
    //   print('hurrah');
    // Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
//show success dialog
//        successDialog(GlobalVariables.signUpResponse);
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

  void loadUserData() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    gender = prefs.getString('gender');
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS");

    // Get current date and time
    DateTime now = DateTime.now();

    // Calculate the date 6 days ago
    DateTime sixDaysAgo = now.subtract(Duration(days: 30));

    // Convert dates to string for comparison
    // String sixDaysAgoString = dateFormat.format(sixDaysAgo);
    // String nowString = dateFormat.format(now);

    // Calculate the date 10 days ago
    DateTime tenDaysAgo = now.subtract(Duration(days: 30));

    // Format the date to match the format in Firestore (if needed)
    String formattedDate = tenDaysAgo.toIso8601String();
    GlobalWidgets.showProgressLoader("Please wait");


    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('candidates')
        .where('account_created_at', isGreaterThanOrEqualTo: formattedDate)
        // .where('is_active_account', isEqualTo: '1')
        // .where('gender', isNotEqualTo: gender)
        .get();
    final List<DocumentSnapshot> firestoreResponseList = querySnapshot.docs;
    if(firestoreResponseList.isEmpty) {
      errorDialog(context);
    }
    else {
      setState(() {
        // documentsWithinWeek = querySnapshot.docs;

        // Filter documents locally
        documentsWithinWeek = querySnapshot.docs;
        // documentsWithinWeek = querySnapshot.docs.where((doc) {
        //   String createdAtString = doc['account_created_at'] as String;
        //   DateTime createdAt = dateFormat.parse(createdAtString);
        //   return createdAt.isAfter(sixDaysAgo) && createdAt.isBefore(now);
        // }).toList();
      });
    }
    
    GlobalWidgets.hideProgressLoader();
//     var _apiService = ApiService();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     Map<String, dynamic> userInfo = Map();
//
//     userInfo['caste'] = GlobalVariables.valueChosen;
//     userInfo['gender'] = prefs.getString('gender');
//
//     GlobalWidgets.showProgressLoader("Please Wait");
//     GlobalWidgets.hideKeyboard(context);
//     final res = await _apiService.byCaste(apiParams: userInfo);
//     GlobalWidgets.hideProgressLoader();
//     if (res is ByCasteProposalsModel) {
//       setState(() {
//         byCasteProposalsModel = res;
//       });
//       print('hurrah');
//       // Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
// //show success dialog
// //        successDialog(GlobalVariables.signUpResponse);
//     }
    // else {
    //   errorDialog(context);
    // }
  }

  heightCalculate(String height) {
    String newHeight = height;
    if(height.contains('@')){
      newHeight = height.replaceAll("@", "\u0027");
    }
    return newHeight;
  }

  accountCreated(String dateTime) {
    print(dateTime);
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
  accountCreatedWithinWeek(String dateTime) {
    print(dateTime);
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
}
