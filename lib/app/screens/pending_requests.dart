import 'dart:convert';

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

import '../routes/app_pages.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../utils/global_widgets.dart';
import '../utils/size_config.dart';


class PendingRequests extends StatefulWidget {
  const PendingRequests({Key? key}) : super(key: key);

  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> with TickerProviderStateMixin{
  GlobalWidgets globalWidgets = GlobalWidgets();
  DateTime selectedDate = DateTime.now();
  TabController? controller;
  int selectedIndexOfTab = 0;
  Map<String, dynamic>? fetchDoc;
  DocumentSnapshot? documentSnapshot;
  List<DocumentSnapshot> acceptedDocuments = [];
  List<DocumentSnapshot> pendingDocuments = [];
  List<dynamic> AcceptedRequests = [];
  List<dynamic> PendingRequests = [];
  String? gender = '';
  String? name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);

    controller?.addListener(() {
      setState(() {
        selectedIndexOfTab = controller!.index;
      });
      print("Selected Index: " + controller!.index.toString());
    });
    loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    int pendingLength = PendingRequests.length ?? 0;
    int acceptedLength = AcceptedRequests.length ?? 0;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsX.black,
          bottom: TabBar(
            indicatorColor: ColorsX.white,
            indicatorWeight: 3,
            unselectedLabelStyle: TextStyle(color: ColorsX.white.withOpacity(0.5)),
            tabs: [
              // Tab(icon: Icon(Icons.person),text: 'Viewed By Me',),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(color: Colors.redAccent, width: 1)),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: globalWidgets.myText(context, "Pending", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(color: Colors.redAccent, width: 1)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: globalWidgets.myText(context, "Accepted", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
                  ),
                ),
              ),
            ],
            labelStyle: TextStyle(fontSize: 16.0,fontFamily: "Mukta"),
          ),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () { Get.back(); },),
          title: globalWidgets.myText(context, "Your Requests", ColorsX.white, 0, 0,0,0, FontWeight.w400, 16),
        ),
        body: TabBarView(
          children: [
            PendingRequests.length == 0 ? Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    // color:  const Color(0xff70b4ff).withOpacity(0.8),
                    color:  const Color(0xffF3F5F5).withOpacity(0.8),
                  ),
                  child: Center(
                    child: globalWidgets.myText(
                        context,
                        'You have no pending request yet.',
                        ColorsX.black,
                        0,
                        10,
                        0,
                        0,
                        FontWeight.w600,
                        17),
                  ),
                )
              ],
            ) : Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    // color:  const Color(0xff70b4ff).withOpacity(0.8),
                    color:  const Color(0xffF3F5F5).withOpacity(0.8),
                  ),
                  child: ListView(
                    children: [
                      Center(
                        child: Wrap(
                          spacing: 1,
                          children: <Widget>[
                            for (int index = 0; index < pendingLength; index++)
                              GestureDetector(
                                onTap: () {
                                  openIDDialogPending(index);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    height: SizeConfig.screenHeight * .33,
                                    width: SizeConfig.screenWidth * .45,
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: SizeConfig.screenHeight * .10,
                                              width: SizeConfig.screenWidth * .20,
                                              margin: EdgeInsets.only(top: 10),
                                              child: Image.asset('assets/images/logo.png'),
                                            ),
                                            globalWidgets.myText(context,'${PendingRequests[index]["sender_name"]}' == name ? '${PendingRequests[index]["receiver_caste"]}' :
                                            '${PendingRequests[index]["sender_caste"]}', ColorsX.subBlack, 5, 0, 0, 0, FontWeight.w900, 14),
                                            globalWidgets.myText(context, ageCalculate('${PendingRequests[index]["sender_name"]}' == name ? '${PendingRequests[index]["receiver_dob"]}' :
                                            '${PendingRequests[index]["sender_dob"]}') + " | " +
                                                heightCalculate('${PendingRequests[index]["sender_name"]}' == name ? '${PendingRequests[index]["receiver_height"]}' :
                                                '${PendingRequests[index]["sender_height"]}'), ColorsX.black, 5, 0, 0, 0, FontWeight.w400, 12),
                                            Container(
                                              height: SizeConfig.screenHeight* .06,
                                              width: SizeConfig.screenWidth* .42,
                                              // child: globalWidgets.myTextCustom(context, "${byCasteProposalsModel?.serverResponse[index].basicDetails.occupation} | ${byCasteProposalsModel?.serverResponse[index].basicDetails.qualification}",
                                              //     ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: globalWidgets.myTextCustom(context, '${PendingRequests[index]["sender_name"]}' == name ? '${PendingRequests[index]["receiver_occupation"]}' :
                                                '${PendingRequests[index]["sender_occupation"]} | ${PendingRequests[index]["sender_name"]}' == name ? '${PendingRequests[index]["receiver_qualification"]}' :
                                                '${PendingRequests[index]["sender_qualification"]}',
                                                    ColorsX.black, 5, 5, 5, 0, FontWeight.w400, 12),
                                              ),
                                            ),
                                            // globalWidgets.myText(context, "${byCasteProposalsModel?.serverResponse[index].basicDetails.area}", ColorsX.white, 5, 0, 0, 5, FontWeight.w400, 12),
                                            Container(
                                              // width: SizeConfig.screenWidth* .58,
                                              width: SizeConfig.screenWidth* .45,

                                              child: Align(
                                                alignment: Alignment.center,
                                                child: globalWidgets.myTextCustomOneLine(context, '${PendingRequests[index]["sender_name"]}' == name ? '${PendingRequests[index]["receiver_city"]}' :
                                                '${PendingRequests[index]["sender_city"]}'
                                                    ,ColorsX.subBlack3, 5, 0, 0, 5, FontWeight.w600, 14),
                                                // " | ${documentsByCastes[index].get('area')}", ColorsX.subBlack3, 5, 0, 0, 5, FontWeight.w600, 14),
                                              ),
                                            ),
                                            globalWidgets.myText(context, accountCreated('${PendingRequests[index]["timestamp"]}'), ColorsX.subBlack5, 0, 0, 0, 0, FontWeight.w400, 14),

                                            Expanded(child: Container()),

                                          ],
                                        ),
                                        Visibility(
                                          // visible: '${PendingRequests[index]["sender_is_verified"]}' == '1' && checkVerifiedPending(index) == "1",
                                          visible: checkVerifiedPending(index) == "1",
                                          child: Container(
                                              margin: EdgeInsets.only(top: 5, left: 5),
                                              child: Icon(Icons.verified, color: ColorsX.blue_gradient_pure_dark,)
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Visibility(
                                            visible: checkMaritalStatusPending(index) == 'Single' ? false : true,
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5, right: 5),
                                              child: globalWidgets.myTextCustom(context, "2nd Marriage"
                                                  ,ColorsX.red_danger, 5, 0, 0, 5, FontWeight.w600, 11),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            AcceptedRequests.length == 0 ? Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    // color:  const Color(0xff70b4ff).withOpacity(0.8),
                    color:  const Color(0xffF3F5F5).withOpacity(0.8),
                  ),
                  child: Center(
                    child: globalWidgets.myText(
                        context,
                        'You have no accepted requests yet.',
                        ColorsX.black,
                        0,
                        10,
                        0,
                        0,
                        FontWeight.w600,
                        17),
                  ),
                )
              ],
            )  : Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  decoration: BoxDecoration(
                    // color:  const Color(0xff70b4ff).withOpacity(0.8),
                    color:  const Color(0xffF3F5F5).withOpacity(0.8),
                  ),
                  child: ListView(
                    children: [
                      Center(
                        child: Wrap(
                          spacing: 1,
                          children: <Widget>[
                            for (int index = 0; index < acceptedLength; index++)
                              GestureDetector(
                                onTap: () {
                                  openIDDialogAccepted(index);
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    height: SizeConfig.screenHeight * .33,
                                    width: SizeConfig.screenWidth * .45,
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: SizeConfig.screenHeight * .10,
                                              width: SizeConfig.screenWidth * .20,
                                              margin: EdgeInsets.only(top: 10),
                                              child: Image.asset('assets/images/logo.png'),
                                            ),
                                            globalWidgets.myText(context,'${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_caste"]}' :
                                            '${AcceptedRequests[index]["sender_caste"]}', ColorsX.subBlack, 5, 0, 0, 0, FontWeight.w900, 14),
                                            globalWidgets.myText(context, ageCalculate('${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_dob"]}' :
                                            '${AcceptedRequests[index]["sender_dob"]}') + " | " +
                                                heightCalculate('${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_height"]}' :
                                                '${AcceptedRequests[index]["sender_height"]}'), ColorsX.black, 5, 0, 0, 0, FontWeight.w400, 12),
                                            Container(
                                              height: SizeConfig.screenHeight* .06,
                                              width: SizeConfig.screenWidth* .42,
                                              // child: globalWidgets.myTextCustom(context, "${byCasteProposalsModel?.serverResponse[index].basicDetails.occupation} | ${byCasteProposalsModel?.serverResponse[index].basicDetails.qualification}",
                                              //     ColorsX.white, 5, 0, 0, 0, FontWeight.w400, 12),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: globalWidgets.myTextCustom(context, '${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_occupation"]}' :
                                                '${AcceptedRequests[index]["sender_occupation"]} | ${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_qualification"]}' :
                                                '${AcceptedRequests[index]["sender_qualification"]}',
                                                    ColorsX.black, 5, 5, 5, 0, FontWeight.w400, 12),
                                              ),
                                            ),
                                            // globalWidgets.myText(context, "${byCasteProposalsModel?.serverResponse[index].basicDetails.area}", ColorsX.white, 5, 0, 0, 5, FontWeight.w400, 12),
                                            Container(
                                              // width: SizeConfig.screenWidth* .58,
                                              width: SizeConfig.screenWidth* .45,

                                              child: Align(
                                                alignment: Alignment.center,
                                                child: globalWidgets.myTextCustomOneLine(context, '${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_city"]}' :
                                                '${AcceptedRequests[index]["sender_city"]}'
                                                    ,ColorsX.subBlack3, 5, 0, 0, 5, FontWeight.w600, 14),
                                                // " | ${documentsByCastes[index].get('area')}", ColorsX.subBlack3, 5, 0, 0, 5, FontWeight.w600, 14),
                                              ),
                                            ),
                                            globalWidgets.myText(context, accountCreated('${AcceptedRequests[index]["timestamp"]}'), ColorsX.subBlack5, 0, 0, 0, 0, FontWeight.w400, 14),

                                            Expanded(child: Container()),

                                          ],
                                        ),
                                        Visibility(
                                          // visible: GlobalVariables.enable_is_verified && checkVerifiedAccepted(index) == "1",
                                          visible: checkVerifiedAccepted(index) == "1",
                                          child: Container(
                                              margin: EdgeInsets.only(top: 5, left: 5),
                                              child: Icon(Icons.verified, color: ColorsX.blue_gradient_pure_dark,)
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Visibility(
                                            visible: checkMaritalStatusAccepted(index) == 'Single' ? false : true,
                                            child: Container(
                                              margin: EdgeInsets.only(top: 5, right: 5),
                                              child: globalWidgets.myTextCustom(context, "2nd Marriage"
                                                  ,ColorsX.red_danger, 5, 0, 0, 5, FontWeight.w600, 11),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),


                  // ListView.separated(
                  //     itemCount: AcceptedRequests.length,
                  //     separatorBuilder: (context, index) =>Divider(height: 1, color: ColorsX.light_orange),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return GestureDetector(
                  //         onTap: (){
                  //           GlobalVariables.idOfProposal ='${AcceptedRequests[index]["sender_name"]}' == name ?
                  //           "${AcceptedRequests[index]["receiver_id"]}" : "${AcceptedRequests[index]["sender_id"]}";
                  //           GlobalVariables.isMyProfile = false;
                  //           print(GlobalVariables.idOfProposal);
                  //           Get.toNamed(Routes.PROPOSALS_DETAIL);
                  //         },
                  //         child: ListTile(
                  //           leading: showImageOfItem(context),
                  //           trailing: globalWidgets.myText(
                  //               context,
                  //               '${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_caste"]}' :
                  //               '${AcceptedRequests[index]["sender_caste"]}',
                  //               ColorsX.subBlack5, 0, 10, 0, 0, FontWeight.w400, 15),
                  //           title: globalWidgets.myText(
                  //               context,
                  //               '${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_name"]}' :
                  //               '${AcceptedRequests[index]["sender_name"]}', ColorsX.black,
                  //               0, 10, 0, 0, FontWeight.w600, 17),
                  //           subtitle: globalWidgets.myTextCustomOneLine(
                  //               context,
                  //               '${AcceptedRequests[index]["sender_name"]}' == name ? '${AcceptedRequests[index]["receiver_qualification"]}':
                  //               '${AcceptedRequests[index]["sender_qualification"]}', ColorsX.black.withOpacity(0.7),
                  //               0, 10, 0, 0, FontWeight.w600, 14),
                  //         ),
                  //       );
                  //     }),
                )
              ],
            ),
            // Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
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
    }else if(days > 1){
      return days.toString() + ' days ago';
    }else{
      return days.toString() + ' days ago';
    }
  }
  checkVerifiedPending(int index){
    if('${PendingRequests[index]['sender_name']}' == name){
      return '${PendingRequests[index]['receiver_is_verified']}';
    }else{
      return '${PendingRequests[index]['sender_is_verified']}';
    }
  }
  checkMaritalStatusPending(int index){
    if('${PendingRequests[index]['sender_name']}' == name){
      return '${PendingRequests[index]['receiver_marital_status']}';
    }else{
      return '${PendingRequests[index]['sender_marital_status']}';
    }
  }
  checkMaritalStatusAccepted(int index){
    if('${AcceptedRequests[index]['sender_name']}' == name){
      return '${AcceptedRequests[index]['receiver_marital_status']}';
    }else{
      return '${AcceptedRequests[index]['sender_marital_status']}';
    }
  }
  checkVerifiedAccepted(int index){
    if('${AcceptedRequests[index]['sender_name']}' == name){
      return '${AcceptedRequests[index]['receiver_is_verified']}';
    }else{
      return '${AcceptedRequests[index]['sender_is_verified']}';
    }
  }
  // showImageOfItem(List<DocumentSnapshot<Object?>>? documents, int index, BuildContext context) {
  //
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10, left: 3, right: 3, bottom: 3),
  //     child: Container(
  //       height: SizeConfig.screenHeight * .25,
  //       width: SizeConfig.screenWidth * .37,
  //       child: CachedNetworkImage(
  //         fit: BoxFit.contain,
  //         imageUrl: documents?[index].get('cat_image'),
  //         placeholder: (context,url) => Container(
  //           // child: Image.asset('assets/images/logo.png', height: 100, width: 100,),
  //           child: Image.asset('assets/images/logo.png', height: 100, width: 100,),
  //         ),
  //         // progressIndicatorBuilder: (context, url, downloadProgress) =>
  //         //     CircularProgressIndicator(value: downloadProgress.progress),
  //         errorWidget: (context, url, error) => Icon(Icons.error),
  //       ),
  //     ),
  //   );
  // }
  showImageOfItem(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 3, right: 3, bottom: 5),
      child: Image.asset('$gender' == 'Male' ? 'assets/images/woman.png' : 'assets/images/man.png', fit: BoxFit.contain, ),
    );
  }


  showGridView(BuildContext context, List dataList) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: SizeConfig.screenHeight * .43, // Set as you want or you can remove it also.
        maxHeight: double.infinity,
      ),
      child: Container(
        // height: SizeConfig.screenHeight,
        // width: SizeConfig.screenWidth,
        child: GridView.builder(
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          // physics: ScrollPhysics(),
          itemCount: dataList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            // crossAxisSpacing: SizeConfig.marginVerticalXsmall,
            // mainAxisSpacing: SizeConfig.marginVerticalXsmall,
            crossAxisCount: 2,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (contxt, index) {
            return  buildItem(index, context,dataList);
          },
        ),
      ),
    );
    // return Container(
    //   height: SizeConfig.screenHeight,
    //   width: SizeConfig.screenWidth,
    //   child: GridView.custom(
    //     shrinkWrap: true,
    //     physics: ScrollPhysics(),
    //     gridDelegate: SliverWovenGridDelegate.count(
    //       crossAxisCount: 2,
    //       mainAxisSpacing: 2,
    //       crossAxisSpacing: 2,
    //       pattern: [
    //         WovenGridTile(0.6),
    //         WovenGridTile(
    //           5 / 9,
    //           crossAxisRatio: 0.9,
    //           alignment: AlignmentDirectional.centerEnd,
    //         ),
    //       ],
    //     ),
    //     childrenDelegate: SliverChildBuilderDelegate(
    //           (context, index) {
    //             return ClipRRect(
    //               borderRadius: BorderRadius.circular(8),
    //               child: buildItem(index, context)
    //             );
    //           },
    //       childCount: dataList.length,
    //     ),
    //   ),
    // );
  }

  ageCalculate(String birthDateString) {
    String year = birthDateString.split("/")[2];
    DateTime today = DateTime.now();
    int hisAgeValue = int.parse(year);
    int yrsOld = today.year - hisAgeValue;
    return yrsOld.toString() + " yrs";
  }
  buildItem(int index, BuildContext context, List dataList) {
    return Container(

      height: SizeConfig.screenHeight * .20,
      width: SizeConfig.screenWidth * .38,
      child: GestureDetector(
        onTap: (){
          // GlobalVariables.categoryChosen = "${dataList?[index].get('name')}";
          // debugPrint("${dataList?[index].get('name')}");
          // Get.toNamed(Routes.PRODUCTS_OF_CATEGORY);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 8 , right: 8 ),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 5,
            color: Colors.white.withOpacity(0.5),
            child: GestureDetector(
              onTap: (){
                // GlobalVariables.categoryChosen = "${dataList?[index].get('name')}";
                // debugPrint("${dataList?[index].get('name')}");
                // Get.toNamed(Routes.PRODUCTS_OF_CATEGORY);
              },
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showImageOfItem(context),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .44),
                    // width: SizeConfig.screenWidth * .44,
                    child: globalWidgets.myTextCustom(context, "${dataList?[index]["name"]}", ColorsX.black, 0, 10, 5, 0, FontWeight.w600, 15),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .45),
                    child: globalWidgets.myTextCustom(context, "${dataList?[index]['profile_created_by']}", ColorsX.black, 0, 10, 5, 0, FontWeight.w600, 12),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: 0, minWidth: 11, maxWidth: SizeConfig.screenWidth * .45),
                    child: globalWidgets.myTextCustom(context, "${dataList?[index]['qualification']}", ColorsX.black, 0, 10, 5, 0, FontWeight.w600, 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void loadDetails() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    gender = preferences.getString('gender');
    name = preferences.getString('name');
    GlobalWidgets.showProgressLoader("Please Wait");
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('requests')
        .where('status', isEqualTo: 'Pending')
        .get();

    final QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('requests')
        .where('status', isEqualTo: 'Accepted')
        .get();

    List<DocumentSnapshot> documents = [];
    documents.addAll(querySnapshot.docs);
    documents.addAll(querySnapshot2.docs);

    if(documents.isEmpty){
      errorDialog();
    }
    else{
      for(int i=0; i<documents.length; i++){
        if(documents[i].get('status') == 'Pending'){
          pendingDocuments.add(documents[i]);
        } else {
          acceptedDocuments.add(documents[i]);
        }
      }
      setState(() {
        PendingRequests = pendingDocuments;
        AcceptedRequests = acceptedDocuments;
      });
    }
    GlobalWidgets.hideProgressLoader();
  }

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
        'Seems like no requests yet.',
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
  successDialog(String signUpResponse) {
    // String id = '';
    // if(signUpResponse.toString().contains('Data Submitted')){
    //   id = signUpResponse.toString().split(".")[1];
    //   // saveIdInLocal(id);
    // }
    // else{
    //   print('no id found');
    // }
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
        title: '${signUpResponse} \n Rishta Nagar ID',
        desc:
        'Account created successfully',// \n Save or remember ID to Log In' ,
        btnOkOnPress: () {
          debugPrint('OnClcik');
          Get.toNamed(Routes.LOGIN_SCREEN);
          // Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE);
        },
        btnOkIcon: Icons.check_circle,
        onDismissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        })
      ..show();
  }
  openIDDialogPending(int index) {
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
        title: 'Choose an ID to open',
        desc:
        'Whose profile you want to open?',// \n Save or remember ID to Log In' ,
        btnOkOnPress: () {
          GlobalVariables.idOfProposal = "${PendingRequests[index]["sender_id"]}";
          print(GlobalVariables.idOfProposal);
          GlobalVariables.isMyProfile = false;
          Get.toNamed(Routes.PROPOSALS_DETAIL);
        },
        btnOkText: 'Sender Profile',
        btnCancelText: 'Receiver Profile',
        btnCancelOnPress: () {
          GlobalVariables.idOfProposal = "${PendingRequests[index]["receiver_id"]}";
          print(GlobalVariables.idOfProposal);
          GlobalVariables.isMyProfile = false;
          Get.toNamed(Routes.PROPOSALS_DETAIL);
        },
        onDismissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        })
      ..show();
  }
  openIDDialogAccepted(int index) {
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
        title: 'Choose an ID to open',
        desc:
        'Whose profile you want to open?',// \n Save or remember ID to Log In' ,
        btnOkOnPress: () {
          GlobalVariables.idOfProposal = "${AcceptedRequests[index]["sender_id"]}";
          print(GlobalVariables.idOfProposal);
          GlobalVariables.isMyProfile = false;
          Get.toNamed(Routes.PROPOSALS_DETAIL);
        },
        btnOkText: 'Sender Profile',
        btnCancelText: 'Receiver Profile',
        btnCancelOnPress: () {
          GlobalVariables.idOfProposal = "${AcceptedRequests[index]["receiver_id"]}";
          print(GlobalVariables.idOfProposal);
          GlobalVariables.isMyProfile = false;
          Get.toNamed(Routes.PROPOSALS_DETAIL);
        },
        onDismissCallback: (type) {
          debugPrint('Dialog Dismiss from callback $type');
        })
      ..show();
  }
}
