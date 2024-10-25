import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_pages.dart';
import '../utils/colors.dart';
import '../utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging? messaging;
  static const colorizeColors = [
    ColorsX.subBlack4,
    ColorsX.blue_gradient_pure_dark,
    ColorsX.whatsappGreen,
    ColorsX.red_danger,
  ];
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging?.getToken().then((value) {
      print(value);
      saveTokenInLocal(value);
    });
    checkWhereToGo();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Opacity(
                opacity: 0.50,
                child: Image.asset(
                  "assets/images/wedding_two.png",
                  fit: BoxFit.cover,
                )),
          ),
          animatedTextLogo(),
          animatedTextLogoVerified(),
        ],
      ),
    );
  }

  animatedTextLogo() {
    const colorizeTextStyle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'Mukta',
    );
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: SizeConfig.screenHeight * .10),
        child: SizedBox(
          width: 250.0,
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'Rishta Nagar',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: true,
            onTap: () {
              debugPrint("Tap Event");
            },
          ),
        ),
      ),
    );
  }
  animatedTextLogoVerified() {
    const colorizeTextStyle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      fontFamily: 'Mukta',
    );
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.only(left: 20, bottom: SizeConfig.screenHeight * .06),
        child: SizedBox(
          width: 250.0,
          child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                '100% Verified Profiles',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: true,
            onTap: () {
              debugPrint("Tap Event");
            },
          ),
        ),
      ),
    );
  }
  checkWhereToGo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if((prefs.getString('id') == null || (prefs.getString('caste') == null)
        || (prefs.getString('id') == '') || (prefs.getString('caste') == ''))){
      Timer(
          Duration(seconds: 3),
              () => Get.toNamed(Routes.LOGIN_SCREEN));
    }else{
      // GlobalVariables.my_ID = "${prefs.getString('id')}";
      Timer(
          Duration(seconds: 3),
              () => Get.toNamed(Routes.LOGIN_SCREEN));
      // GlobalVariables.my_ID = "${prefs.getString('id')}";
      // Timer(
      //     Duration(seconds: 3),
      //         () => Get.toNamed(Routes.ALL_CASTES_MAIN_PAGE));
      // Get.toNamed(Routes.LOGIN_SCREEN);
    }
  }
  void saveTokenInLocal(String? value)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "${value}");
    print('TOKEN STORED '+ "${value}");
  }
}
