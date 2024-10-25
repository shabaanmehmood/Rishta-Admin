import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ndialog/ndialog.dart';

import 'colors.dart';
import 'size_config.dart';


class GlobalWidgets {
  static final List<String> motherTongueList = [
    "Mother Tongue",
    "Urdu",
    "Punjabi",
    "Pashto",
    "Sindhi",
    "Saraiki",
    "Balochi",
    "Kashmiri",
    "English",
  ];
  static final List<String> religionList = [
    "Religion",
    "Islam",
    "Christian",
    "Hindu",
  ];
  static final List<String> maslakList = [
    "Maslak",
    "Ahl-e-Sunnat"
    "Ahl-e-Hadith",
    "Brailvi",
    "Deobandi",
    "Others",
    "Shia",
    "Parsi",
  ];
  static final List<String> casteList = [
    "Caste",
    "Aheer",
    "Arain",
    "Awan",
    "Baloch",
    "Bhatti",
    "Batt",
    "Catholic",
    "Chaudary",
    "Dogar",
    "Gakhar",
    "Gondal",
    "Gujjar",
    "Hashmi",
    "Jat",
    "Kamboh",
    "Kakky Zai",
    "Khokhar",
    "Maliar",
    "Mughal",
    "Malik",
    "Orthodox",
    "Paracha",
    "Parsi",
    "Pathan",
    "Pashtuns",
    "Protestant",
    "Qureshi",
    "Rajput",
    "Rana",
    "Rehmani / Malik",
    "Sheikh",
    "Siddiqui",
    "Syed",
    "Yousuf Zai"
  ];
  static final List<String> professionsList = [
    "Doctor",
    "Engineer",
    "Lecturer",
    "M.B.A",
    "M.A",
    "Foreign Living",
    "B.Sc",
    "B.A",
    "F.A",
    "Business",
    "Government Job",
    "Army / Military",
    "Lawyer",
    "Banker",
  ];
  static final List<String> profileSegmentsList = [
    "Basic Details",
    "Family Details",
    "Required Proposal",
  ];
  static final List<String> casteAndProfessionList = [
    "Doctor",
    "Engineer",
    "Lecturer",
    "M.B.A",
    "M.A",
    "Foreign Living",
    "B.Sc",
    "B.A",
    "F.A",
    "Business",
    "Government Job",
    "Army / Military",
    "Lawyer",
    "Banker",
    "Aheer",
    "Arain",
    "Awan",
    "Baloch",
    "Bhatti",
    "Batt",
    "Catholic",
    "Chaudary",
    "Dogar",
    "Gakhar",
    "Gondal",
    "Gujjar",
    "Hashmi",
    "Irani",
    "Jatt",
    "Kamboh",
    "Khan",
    "Kakky Zai",
    "Khateek",
    "Khattar",
    "Khokhar",
    "Maliar",
    "Mughal",
    "Malik",
    "Orthodox",
    "Paracha",
    "Parsi",
    "Pashtuns",
    "Protestant",
    "Qureshi",
    "Rajput",
    "Rana",
    "Rehmani / Malik",
    "Sheikh",
    "Siddiqui",
    "Syed",
    "Yousuf Zai"
  ];
  static final List<String>  citiesList = [ "Select City","Other than Pakistan","Abbottabad","Arifwala","Abdul Hakim","Alipur","Ahmad pur Sial","Astore","Attock","Awaran","Azad-Kashmir","Balakot","Badin",
  "Bagh","Bahawalnagar","Bahawalpur","Bannu","Bhai Pheru","Bhera","Bhawana",
  "Bhakkar","Bhalwal","Bhimber","Buner","Boorewala","Burewala","Chaghi","Chakwal","Chowk Azam","Choa Saidan Shah",
  "Charsadda","Chichawatni", "Chiniot","Chishtian Sharif","Chaubara"
  ,"Chitral","Chawinda","Chunian","Challas","Dadu","Dina","Daska","Depalpur","Dera Ghazi Khan","Dera Ismail Khan","Dijkot","Duniya Pur",
  "FATA","Faisalabad","Fateh jang","Fateh Pur","Fort Abbas","Feroz wala","Fort Menro","Gaarho","Gadoon","Galyat","Gharo","Ghotki","Gilgit","Gojra","Gujar Khan","Gujranwala",
  "Gwadar","Hafizabad","Hangu","Hazroo","Harappa","Hujra Shah Muqeem","Haripur","Haroonabad","Hasilpur","Hasan Abdal","Haveli Lakha","Hub (Hub Chowki)",
  "Hunza","Hyderabad","Islamabad","Isa Khel","Jand","Jacobabad","Jahanian","Jalalpur Jattan","Jatoi","Jampur","Jauharabad","Jhang","Jhelum","Jaranwala",
  "Karachi","Kaghan","Kahror Pakka","Kalat","Kamalia","Kamoki","Karak","Kasur","Khairpur","Khanewal","Khanpur","Kharian","Kalar kahar",
  "Kallakand","Karor lal esan",
  "Khushab","Khuzdar","Kohat","Kot Addu","Kotli","kot Radha kishan","Lahore","Lakki Marwat","Lalamusa","Larkana","Lasbela","Layyah","Liaquatpur",
  "Lawa","Lodhran","Loralai","Lower Dir","Laliyan","Mailsi","Makran","Malakand","Mandi Bahauddin","Mansehra","Mardan","Matiari",
  "Mian Channu","Mianwali","Minchan abad","Muzaffarabad","Mirpur Khas","Mirpur Sakro","Mirpur","Multan","Murree","Muzaffargarh","Mureedky",
  "Mureedwala","Malakwala","Mankera","Kalur kot","Kot Abdul Malik","Kabir wala","Kher pur",
  "Nankana Sahib","Naran","Narowal","Nasirabad","Nurpur Thal","Naushahro Feroze","Nandi Pur","Noshki","Nawabshah","Neelum","Nowshera","Others Azad Kashmir",
  "Others Balochistan","Others Gilgit Baltistan","Okara","Others Khyber Pakhtunkhwa","Others Punjab","Others Sindh","Others",
  "Pakpattan","Peshawar","Pasroor","Piplan","Pind Dadan Khan","Pindi Gheb","Phool Nagar","Pir Mahal","Pisheen","Pindi Bhattian","Phaliya",
  "Quetta","Qila Didar Snigh","Quidabad","Rawalpindi","Rojhan","Rahim Yar Khan","Rajanpur","Ratwal",
  "Rawalkot","Rohri","Sehwan","Sargodha","Sadiqabad","Sahiwal","Samundri","Sanghar","Shahdadpur","Shahkot","Sheikhupura",
  "Sambrial","Sohawa",
  "Shikarpur","Shorkkot","Sialkot","Soon Valley","Sibi","Skardu","Sukheki","Sudhnoti","Sukkur","Saray Alamgir","Swabi","Swat",
  "Shakargarh","Safdarabad","Sharakpur","Tando Adam","Tando Allah Yar",
  "Tando Bago","Taxila","Thatta","Toba Tek Singh","Taunsa","Tandlianwala","Vehari","Wah Cantt","Wazirabad","Waziristan",
  "Yazman","Zohb","Zafarwal"];
  static final List<String>  citiesRequiredList = [ "Select City","Anywhere from Pakistan","Other than Pakistan","Abbottabad","Arifwala","Abdul Hakim","Alipur","Ahmad pur Sial","Astore","Attock","Awaran","Azad-Kashmir","Balakot","Badin",
  "Bagh","Bahawalnagar","Bahawalpur","Bannu","Bhai Pheru","Bhera","Bhawana",
  "Bhakkar","Bhalwal","Bhimber","Buner","Boorewala","Burewala","Chaghi","Chakwal","Chowk Azam","Choa Saidan Shah",
  "Charsadda","Chichawatni", "Chiniot","Chishtian Sharif","Chaubara"
  ,"Chitral","Chawinda","Chunian","Challas","Dadu","Dina","Daska","Depalpur","Dera Ghazi Khan","Dera Ismail Khan","Dijkot","Duniya Pur",
  "FATA","Faisalabad","Fateh jang","Fateh Pur","Fort Abbas","Feroz wala","Fort Menro","Gaarho","Gadoon","Galyat","Gharo","Ghotki","Gilgit","Gojra","Gujar Khan","Gujranwala",
  "Gwadar","Hafizabad","Hangu","Hazroo","Harappa","Hujra Shah Muqeem","Haripur","Haroonabad","Hasilpur","Hasan Abdal","Haveli Lakha","Hub (Hub Chowki)",
  "Hunza","Hyderabad","Islamabad","Isa Khel","Jand","Jacobabad","Jahanian","Jalalpur Jattan","Jatoi","Jampur","Jauharabad","Jhang","Jhelum","Jaranwala",
  "Karachi","Kaghan","Kahror Pakka","Kalat","Kamalia","Kamoki","Karak","Kasur","Khairpur","Khanewal","Khanpur","Kharian","Kalar kahar",
  "Kallakand","Karor lal esan",
  "Khushab","Khuzdar","Kohat","Kot Addu","Kotli","kot Radha kishan","Lahore","Lakki Marwat","Lalamusa","Larkana","Lasbela","Layyah","Liaquatpur",
  "Lawa","Lodhran","Loralai","Lower Dir","Laliyan","Mailsi","Makran","Malakand","Mandi Bahauddin","Mansehra","Mardan","Matiari",
  "Mian Channu","Mianwali","Minchan abad","Muzaffarabad","Mirpur Khas","Mirpur Sakro","Mirpur","Multan","Murree","Muzaffargarh","Mureedky",
  "Mureedwala","Malakwala","Mankera","Kalur kot","Kot Abdul Malik","Kabir wala","Kher pur",
  "Nankana Sahib","Naran","Narowal","Nasirabad","Nurpur Thal","Naushahro Feroze","Nandi Pur","Noshki","Nawabshah","Neelum","Nowshera","Others Azad Kashmir",
  "Others Balochistan","Others Gilgit Baltistan","Okara","Others Khyber Pakhtunkhwa","Others Punjab","Others Sindh","Others",
  "Pakpattan","Peshawar","Pasroor","Piplan","Pind Dadan Khan","Pindi Gheb","Phool Nagar","Pir Mahal","Pisheen","Pindi Bhattian","Phaliya",
  "Quetta","Qila Didar Snigh","Quidabad","Rawalpindi","Rojhan","Rahim Yar Khan","Rajanpur","Ratwal",
  "Rawalkot","Rohri","Sehwan","Sargodha","Sadiqabad","Sahiwal","Samundri","Sanghar","Shahdadpur","Shahkot","Sheikhupura",
  "Sambrial","Sohawa",
  "Shikarpur","Shorkkot","Sialkot","Soon Valley","Sibi","Skardu","Sukheki","Sudhnoti","Sukkur","Saray Alamgir","Swabi","Swat",
  "Shakargarh","Safdarabad","Sharakpur","Tando Adam","Tando Allah Yar",
  "Tando Bago","Taxila","Thatta","Toba Tek Singh","Taunsa","Tandlianwala","Vehari","Wah Cantt","Wazirabad","Waziristan",
  "Yazman","Zohb","Zafarwal"];
  static late ProgressDialog progressDialog;

  static String? day = "";
  static String? month = "";
  static String? year = "";
  static String? chosenDateTimeFromSetAppointment = "";

  static void showProgressDialog(
      BuildContext context, String title, String message) {
    progressDialog =
        ProgressDialog(context, message: Text(message), title: Text(title));
  }

  myText(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text, style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  myTextCustom(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  myTextCustomOneLine(BuildContext context, String text, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  detailText(BuildContext context, String text,String detail, Color colorsX, double top, double left, double right, double bottom,
      FontWeight fontWeight, double fontSize){
    return Container(
      margin: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
      child: Text(text, style: GoogleFonts.mukta(textStyle: TextStyle( color: colorsX, fontWeight: fontWeight,
          fontSize: fontSize)),),
    );
  }
  myTextField(TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          border: Border.all(color: ColorsX.white, width: 1.25)
      ),
      child: TextFormField(
        keyboardType: inputType,
        controller: ctl,
        obscureText: obscureText,
        style: TextStyle(color: ColorsX.white),
        decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            hintText: hint, hintStyle: TextStyle(color: ColorsX.white)
        ),
      ),
    );
  }
  myTextFieldEdit(TextInputType inputType, TextEditingController ctl, bool obscureText, String hint){
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
            hintText: hint, hintStyle: TextStyle(color: ColorsX.subBlack)
        ),
      ),
    );
  }
  static bool validateEmail(String email) {
    bool emailValid = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
    return emailValid;
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: ColorsX.blue_button_color,
        textColor: ColorsX.white,
        fontSize: 16.0);
  }
  //
  static showErrorToast(
      BuildContext context, String title, String description) {
    MotionToast.error(
        title: Text(title, style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.white, fontWeight: FontWeight.w400,
            fontSize: 16)),),
        animationDuration: Duration(microseconds: 100),
        toastDuration: Duration(milliseconds: 1700),
        description: Text(description, style: GoogleFonts.mukta(textStyle: TextStyle( color: ColorsX.white, fontWeight: FontWeight.w400,
            fontSize: 16)),),)
        .show(context);
  }

  static hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static showProgressLoader(String msg) {
    EasyLoading.show(status: msg);
  }

  static hideProgressLoader() {
    EasyLoading.dismiss();
  }

  static void initializeLoader() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 60
      ..radius = 20
      ..backgroundColor = Colors.black
      ..indicatorColor = ColorsX.white
      ..textColor = Colors.white
      ..userInteractions = true
      ..dismissOnTap = false
      ..indicatorType = EasyLoadingIndicatorType.cubeGrid;
  }
}
