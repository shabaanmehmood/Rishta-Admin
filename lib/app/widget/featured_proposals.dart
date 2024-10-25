import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../routes/app_pages.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../utils/global_widgets.dart';
import '../utils/size_config.dart';

// var list = [];
// List<String> imgList = [];
// class FeaturedProposals extends StatefulWidget {
//   // const FeaturedProposals({Key? key}) : super(key: key);
//   final FeaturedModel? featuredModel;
//   FeaturedProposals({this.featuredModel});
//   @override
//   _FeaturedProposalsState createState() => _FeaturedProposalsState();
// }
//
// class _FeaturedProposalsState extends State<FeaturedProposals> {
//   GlobalWidgets globalWidgets = GlobalWidgets();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     int length = widget.featuredModel?.serverResponse.length ?? 0;
//     for(int index = 0; index < length; index++){
//       imgList.add('https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80');
//       list.add(widget.featuredModel?.serverResponse[index]);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     print(list);
//     return Container(
//       child: CarouselSlider(
//         options: CarouselOptions(
//           autoPlay: true,
//           aspectRatio: 1.6,
//           enlargeCenterPage: true,
//         ),
//         items: imageSliders,
//       ),
//     );
//   }
//
//   final List<Widget> imageSliders = imgList.map((item) => Container(
//     child: GestureDetector(
//       onTap: (){
//         print(imgList.indexWhere((element) => false));
//         Get.toNamed(Routes.PROPOSALS_DETAIL);
//       },
//       child: Container(
//         margin: EdgeInsets.all(5.0),
//         child: ClipRRect(
//             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   decoration: BoxDecoration(
//                     color: ColorsX.white,
//                   ),
//                   child: Center(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: ColorsX.greenish,
//                                   borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 6),
//                                   child: Text("Hashmi Qureshi", style: GoogleFonts.mukta(textStyle: const TextStyle( color: ColorsX.yellowColor, fontWeight: FontWeight.w900,fontSize: 14),),),
//                                 ),),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                               width: SizeConfig.screenWidth* .55,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
//                                 child: Text("B.Sc Electrical Engineering",
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w400,
//                                       fontSize: 13)),),
//
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2),
//                                 child: Text('24 yrs | ', style: GoogleFonts.mukta(textStyle: const TextStyle( color: ColorsX.black,
//                                     fontWeight: FontWeight.w700,fontSize: 13),),),
//                               ),
//                               margin: EdgeInsets.only(left: 10),
//                             ),
//                             Container(
//                               width: SizeConfig.screenWidth* .55,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2),
//                                 child: Text("Software Engineer Software Engineer Software Engineer",
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w500,
//                                       fontSize: 13)),),
//
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                               width: SizeConfig.screenWidth* .55,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
//                                 child: Text("Allama Iqbal Town, Lahore",
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                   style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.creamColor, fontWeight: FontWeight.w400,
//                                       fontSize: 13)
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             // Container(
//                             //   child: Padding(
//                             //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
//                             //     child: Text('Height 5\u00276 ', style: GoogleFonts.mukta
//                             //       (textStyle: const TextStyle( color: ColorsX.creamColor, fontWeight: FontWeight.w900,fontSize: 13),),),
//                             //   ),),
//
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: ColorsX.greenish,
//                                   borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 6),
//                                   child: Text('Featured', style: GoogleFonts.mukta(textStyle: const
//                                   TextStyle( color: ColorsX.yellowColor, fontWeight: FontWeight.w700,fontSize: 14),),),
//                                 ),),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Positioned(
//                 //   bottom: 0.0,
//                 //   left: 0.0,
//                 //   right: 0.0,
//                 //   child: Container(
//                 //     decoration: BoxDecoration(
//                 //       gradient: LinearGradient(
//                 //         colors: [
//                 //           Color.fromARGB(200, 0, 0, 0),
//                 //           Color.fromARGB(0, 0, 0, 0)
//                 //         ],
//                 //         begin: Alignment.bottomCenter,
//                 //         end: Alignment.topCenter,
//                 //       ),
//                 //     ),
//                 //     padding: EdgeInsets.symmetric(
//                 //         vertical: 10.0, horizontal: 20.0),
//                 //     child: Text(
//                 //       'No. ${imgList.indexOf(item)} image',
//                 //       style: TextStyle(
//                 //         color: Colors.white,
//                 //         fontSize: 20.0,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             )),
//       ),
//     ),
//   ))
//       .toList();
// }
List<String> imgList = [];
class FeaturedProposals extends StatelessWidget {
  GlobalWidgets globalWidgets = GlobalWidgets();
  // final FeaturedModel? featuredModel;
  final List<DocumentSnapshot>? documents;
  // FeaturedProposals({ this.featuredModel});
  FeaturedProposals({ this.documents});
  @override
  Widget build(BuildContext context) {
    // int length = featuredModel?.serverResponse.length ?? 0;
    int length = documents?.length ?? 0;
    return Container(
      height: SizeConfig.screenHeight*.27,
      width: SizeConfig.screenWidth,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: length,
          itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  print(index);
                  // GlobalVariables.idOfProposal = "${featuredModel?.serverResponse[index].basicDetails.id}";
                  GlobalVariables.idOfProposal = "${documents?[index].reference.id}";
                  GlobalVariables.isMyProfile = false;
                  print(GlobalVariables.idOfProposal);
                  Get.toNamed(Routes.PROPOSALS_DETAIL);
                },
                child: Container(
                  width: length < 2 ? SizeConfig.screenWidth : SizeConfig.screenWidth * .80,
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: ColorsX.white,
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorsX.greenish,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 6),
                                            // child: Text("${featuredModel?.serverResponse[index].basicDetails.caste}", style: GoogleFonts.mukta(textStyle: const TextStyle( color: ColorsX.yellowColor, fontWeight: FontWeight.w900,fontSize: 14),),),
                                            child: Text("${documents?[index].get('caste')}", style: GoogleFonts.mukta(textStyle: const TextStyle( color: ColorsX.yellowColor, fontWeight: FontWeight.w900,fontSize: 14),),),
                                          ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorsX.black,
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 6),
                                            child: Text('Featured', style: GoogleFonts.mukta(textStyle: const
                                            TextStyle( color: ColorsX.white, fontWeight: FontWeight.w700,fontSize: 14),),),
                                          ),),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: SizeConfig.screenWidth* .55,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                                          // child: Text("${featuredModel?.serverResponse[index].basicDetails.qualification}",
                                          child: Text("${documents?[index].get('qualification')}",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w400,
                                                fontSize: 13)),),

                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                                        // child: Text(accountCreated("${featuredModel?.serverResponse[index].others.featuredStartDate}"),
                                        child: Text(accountCreated("${documents?[index].get('featured_start_date')}"),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black.withOpacity(0.6), fontWeight: FontWeight.w400,
                                              fontSize: 13)),),

                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2),
                                          // child: Text(ageCalculate("${featuredModel?.serverResponse[index].basicDetails.dob}"), style: GoogleFonts.mukta(textStyle: const TextStyle( color: ColorsX.black,
                                          child: Text(ageCalculate("${documents?[index].get('dob')}"), style: GoogleFonts.mukta(textStyle: const TextStyle( color: ColorsX.black,
                                              fontWeight: FontWeight.w700,fontSize: 13),),),
                                        ),
                                        margin: EdgeInsets.only(left: 10),
                                      ),
                                      // "${featuredModel?.serverResponse[index].basicDetails.occupation}" == "null" ? Container() : Container(
                                      "${documents?[index].get('occupation')}" == "null" ? Container() : Container(
                                        width: SizeConfig.screenWidth* .55,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2),
                                          // child: Text(heightCalculate(" | ${ featuredModel?.serverResponse[index].basicDetails.occupation}"),
                                          child: globalWidgets.myTextCustomOneLine(context, heightCalculate(" | ${ documents?[index].get('occupation')}"), ColorsX.black, 5, 0, 0, 5, FontWeight.w500, 13),

                                          // child: Text(heightCalculate(" | ${ documents?[index].get('occupation')}"),
                                          //   overflow: TextOverflow.ellipsis,
                                          //   maxLines: 1,
                                          //   style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w500,
                                          //       fontSize: 13)),),

                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: SizeConfig.screenWidth* .47,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                                          // child: Text("${featuredModel?.serverResponse[index].basicDetails.area}, ${featuredModel?.serverResponse[index].basicDetails.city}",
                                          // child: Text("${documents?[index].get('area')}, ${documents?[index].get('city')}",
                                          //   overflow: TextOverflow.ellipsis,
                                          //   maxLines: 1,
                                          //   style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w400,
                                          //       fontSize: 13)
                                          //   ),
                                          // ),
                                          child: globalWidgets.myTextCustomOneLine(context, "${documents?[index].get('city')} | ${documents?[index].get('area')}", ColorsX.black, 5, 0, 0, 5, FontWeight.w600, 14),
                                        ),
                                      ),
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                                          // child: Text("${featuredModel?.serverResponse[index].basicDetails.motherTongue} Speaking",
                                          child: Text("${documents?[index].get('mother_tongue')} Speaking",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black.withOpacity(0.6), fontWeight: FontWeight.w500,
                                                fontSize: 13)),),

                                        ),
                                      ),
                                      // Container(
                                      //   width: SizeConfig.screenWidth* .55,
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                                      //     child: Text("${featuredModel?.serverResponse[index].basicDetails.motherTongue} Speaking",
                                      //       overflow: TextOverflow.ellipsis,
                                      //       maxLines: 1,
                                      //       style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w400,
                                      //           fontSize: 13)),),
                                      //
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                                      //   child: Text("${featuredModel?.serverResponse[index].basicDetails.motherTongue} Speaking",
                                      //     overflow: TextOverflow.ellipsis,
                                      //     maxLines: 1,
                                      //     style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w400,
                                      //         fontSize: 13)),),
                                      //
                                      // ),
                                    ],
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: <Widget>[
                                  //     // Container(
                                  //     //   child: Padding(
                                  //     //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
                                  //     //     child: Text(accountCreated("${featuredModel?.serverResponse[index].others.featuredStartDate}"), style: GoogleFonts.mukta
                                  //     //       (textStyle: const TextStyle( color: ColorsX.creamColor, fontWeight: FontWeight.w900,fontSize: 13),),),
                                  //     //   ),),
                                  //     Container(),
                                  //     Padding(
                                  //       padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                  //       child: Container(
                                  //         decoration: BoxDecoration(
                                  //           color: ColorsX.black,
                                  //           borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                  //         ),
                                  //         child: Padding(
                                  //           padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 6),
                                  //           child: Text('Featured', style: GoogleFonts.mukta(textStyle: const
                                  //           TextStyle( color: ColorsX.white, fontWeight: FontWeight.w700,fontSize: 14),),),
                                  //         ),),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          // Positioned(
                          //   bottom: 0.0,
                          //   left: 0.0,
                          //   right: 0.0,
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       gradient: LinearGradient(
                          //         colors: [
                          //           Color.fromARGB(200, 0, 0, 0),
                          //           Color.fromARGB(0, 0, 0, 0)
                          //         ],
                          //         begin: Alignment.bottomCenter,
                          //         end: Alignment.topCenter,
                          //       ),
                          //     ),
                          //     padding: EdgeInsets.symmetric(
                          //         vertical: 10.0, horizontal: 20.0),
                          //     child: Text(
                          //       'No. ${imgList.indexOf(item)} image',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 20.0,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      )),
                ),
              );
          })
    );
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
  heightCalculate(String height) {
    String newHeight = height;
    if(height.contains('@')){
      newHeight = height.replaceAll("@", "\u0027");
    }
    return newHeight;
  }
  ageCalculate(String birthDateString) {
    print(birthDateString);
    String year = birthDateString.split("/")[2];
    DateTime today = DateTime.now();
    int hisAgeValue = int.parse(year);
    int yrsOld = today.year - hisAgeValue;
    return yrsOld.toString() + " yrs";
  }
  // final List<Widget> imageSliders = imgList.map((item) => Container(
  //   child: GestureDetector(
  //     onTap: (){
  //       print(imgList.indexWhere((element) => false));
  //       Get.toNamed(Routes.PROPOSALS_DETAIL);
  //     },
  //     child: Container(
  //       margin: EdgeInsets.all(5.0),
  //       child: ClipRRect(
  //           borderRadius: BorderRadius.all(Radius.circular(5.0)),
  //           child: Stack(
  //             children: <Widget>[
  //               Container(
  //                 decoration: BoxDecoration(
  //                   color: ColorsX.white,
  //                 ),
  //                 child: Center(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: <Widget>[
  //                           Padding(
  //                             padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                 color: ColorsX.greenish,
  //                                 borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
  //                               ),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 6),
  //                                 child: Text("Hashmi Qureshi", style: GoogleFonts.mukta(textStyle: const TextStyle( color: ColorsX.yellowColor, fontWeight: FontWeight.w900,fontSize: 14),),),
  //                               ),),
  //                           ),
  //                         ],
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: <Widget>[
  //                           Container(
  //                             width: SizeConfig.screenWidth* .55,
  //                             child: Padding(
  //                               padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
  //                               child: Text("B.Sc Electrical Engineering",
  //                                 overflow: TextOverflow.ellipsis,
  //                                 maxLines: 1,
  //                                 style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w400,
  //                                     fontSize: 13)),),
  //
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: <Widget>[
  //                           Container(
  //                             child: Padding(
  //                               padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2),
  //                               child: Text('24 yrs | ', style: GoogleFonts.mukta(textStyle: const TextStyle( color: ColorsX.black,
  //                                   fontWeight: FontWeight.w700,fontSize: 13),),),
  //                             ),
  //                             margin: EdgeInsets.only(left: 10),
  //                           ),
  //                           Container(
  //                             width: SizeConfig.screenWidth* .55,
  //                             child: Padding(
  //                               padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 2),
  //                               child: Text("Software Engineer Software Engineer Software Engineer",
  //                                 overflow: TextOverflow.ellipsis,
  //                                 maxLines: 1,
  //                                 style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.black, fontWeight: FontWeight.w500,
  //                                     fontSize: 13)),),
  //
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: <Widget>[
  //                           Container(
  //                             width: SizeConfig.screenWidth* .55,
  //                             child: Padding(
  //                               padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
  //                               child: Text("Allama Iqbal Town, Lahore",
  //                                 overflow: TextOverflow.ellipsis,
  //                                 maxLines: 1,
  //                                 style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.creamColor, fontWeight: FontWeight.w400,
  //                                     fontSize: 13)
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: <Widget>[
  //                           // Container(
  //                           //   child: Padding(
  //                           //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2),
  //                           //     child: Text('Height 5\u00276 ', style: GoogleFonts.mukta
  //                           //       (textStyle: const TextStyle( color: ColorsX.creamColor, fontWeight: FontWeight.w900,fontSize: 13),),),
  //                           //   ),),
  //
  //                           Padding(
  //                             padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                 color: ColorsX.greenish,
  //                                 borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
  //                               ),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 6),
  //                                 child: Text('Featured', style: GoogleFonts.mukta(textStyle: const
  //                                 TextStyle( color: ColorsX.yellowColor, fontWeight: FontWeight.w700,fontSize: 14),),),
  //                               ),),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               // Positioned(
  //               //   bottom: 0.0,
  //               //   left: 0.0,
  //               //   right: 0.0,
  //               //   child: Container(
  //               //     decoration: BoxDecoration(
  //               //       gradient: LinearGradient(
  //               //         colors: [
  //               //           Color.fromARGB(200, 0, 0, 0),
  //               //           Color.fromARGB(0, 0, 0, 0)
  //               //         ],
  //               //         begin: Alignment.bottomCenter,
  //               //         end: Alignment.topCenter,
  //               //       ),
  //               //     ),
  //               //     padding: EdgeInsets.symmetric(
  //               //         vertical: 10.0, horizontal: 20.0),
  //               //     child: Text(
  //               //       'No. ${imgList.indexOf(item)} image',
  //               //       style: TextStyle(
  //               //         color: Colors.white,
  //               //         fontSize: 20.0,
  //               //         fontWeight: FontWeight.bold,
  //               //       ),
  //               //     ),
  //               //   ),
  //               // ),
  //             ],
  //           )),
  //     ),
  //   ),
  // ))
  //     .toList();
}