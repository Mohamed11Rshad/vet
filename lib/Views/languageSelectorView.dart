



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Providers/languageProvider.dart';
import 'package:vetdrugegy/Views/HomeView.dart';
import 'package:vetdrugegy/Views/LoginView.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';
import '../Controllers/UserController.dart';
import '../Models/Constants.dart';
import 'Shared/authTextField.dart';
import 'Shared/imagePager.dart';
import 'SignUpView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LanguageSelectorView extends StatefulWidget {
  //constructor
  const LanguageSelectorView({Key? key}) : super(key: key);

  @override
  LanguageSelectorViewState createState() => LanguageSelectorViewState();
}

class LanguageSelectorViewState extends State<LanguageSelectorView> {

  @override
 initState()  {
    super.initState();

  }




  


  @override
  Widget build(BuildContext context) {
        var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: appDesign.backGround,
      body: FB5Row(
        children:[ FB5Col(
          classNames: 'col-12',
          child: SingleChildScrollView(
            child: Padding(
              // add space for all padding container
              padding: EdgeInsets.all(20),
              child: Container(
                child: FB5Row(
                  children: [
                    FB5Col(classNames: 'col-12 mt-5', child: Image.asset('images/applogo.png',width: context.screenWidth*.25,height: context.screenWidth*.25 ,)),
                   FB5Col(
                      classNames: 'col-6',
                      child: GestureDetector(
                        onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setBool("isFirst", false);
prefs.setString("lang", "en");

UserData.language="en";
                          languageProvider.changeLanguage(Locale("en"));
                            context.navigateFromSplash(LoginView());

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Container(height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: appDesign.colorPrimaryDark,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Center(child: Text("English"))
                        ),
                        ),
                      ),
                    ),  FB5Col(
                      classNames: 'col-6',
                      child: GestureDetector(
                         onTap: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setBool("isFirst", false);
prefs.setString("lang", "ar");

UserData.language="ar";
                          languageProvider.changeLanguage(Locale("ar"));
                            context.navigateFromSplash(LoginView());

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: Container(height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: appDesign.colorPrimaryDark,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Center(child: Text("العربية"))
                        ),
                        ),
                      ),
                    )
                   ,
     FB5Col(classNames: 'col-12', child:   Container(

                        child:  ImagePager(screenname: "language"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
                  ],
                ),
              ),
            ),
          ),
        )],
      ),
    );
  }
}
