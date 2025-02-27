import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:im_animations/im_animations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Providers/languageProvider.dart';
import 'package:vetdrugegy/Views/EditUserView.dart';
import 'package:vetdrugegy/Views/HomeView.dart';
import 'package:vetdrugegy/Views/languageSelectorView.dart';


import '../Models/Constants.dart';
import 'LoginView.dart';
import 'SignUpView.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
if(prefs.getBool("isFirst")==null){
    context.navigateFromSplash(LanguageSelectorView());

}
else{

 if(prefs.getInt("UserID")!=null){
      UserData.userId= prefs.getInt("UserID")!;
      UserData.userName=prefs.getString("UserName")!;
      UserData.government=prefs.getInt("Government")!;
      UserData.language=prefs.getString("lang")!;
           
     var languageProvider = Provider.of<LanguageProvider>(listen: false,context);

                          languageProvider.changeLanguage(Locale(UserData.language));

    }
if(UserData.userId>0){
  context.navigateFromSplash(HomeView());
}
else{
  context.navigateFromSplash(LoginView());

}
}
  }






  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      _getUser();
    });

    return Scaffold(
        backgroundColor: appDesign.backGround,
        body: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: HeartBeat(beatsPerMinute: 60,child: Image.asset("images/applogo.png")),
            ),
          ),
        )
    );
  }
}