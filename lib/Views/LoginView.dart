



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Views/ForgetPasswodView.dart';
import 'package:vetdrugegy/Views/HomeView.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';
import '../Controllers/UserController.dart';
import '../Models/Constants.dart';
import 'Shared/authTextField.dart';
import 'Shared/imagePager.dart';
import 'SignUpView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginView extends StatefulWidget {
  //constructor
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  final controller = UserController();
  final RoundedLoadingButtonController _loginBtnController =
  RoundedLoadingButtonController();
  var isLoading = false;
  var email;
  var pass;
  String? deviceImei="";
  String? type;
  bool getPermission = false;
  @override
 initState()  {
    super.initState();

  }




  void loginValidation(RoundedLoadingButtonController btnController) {
    if (email == null  || pass == null) {
      context.showAlert(
          title:  AppLocalizations.of(context)!.loginAlert,
          message:  AppLocalizations.of(context)!.loginAlertDetails);
      btnController.reset();
    } else {
      controller.Login(email, pass).then((value) async {
        if (value != null) {
          print("User IS ${value} *************************");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setInt("UserID", value.id);
          prefs.setString("UserName", value.name);
          prefs.setInt("Government", value.government);
          UserData.userId=value.id;
          UserData.userName=value.name;
          UserData.government=value.government;
          context.navigateFromSplash(HomeView());


        } else {
          context.showAlert(
              title:  AppLocalizations.of(context)!.loginAlert,
              message:  AppLocalizations.of(context)!.loginWrongUserOrPass);
          btnController.reset();
        }
      });
    }

    // Send the email and password to your backend for authentication
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appDesign.backGround,
      body: FB5Row(
        children:[ 
          FB5Col(
            classNames: 'col-md-3',
          ),
          FB5Col(
          classNames: 'col-12 col-md-6',
          child: SingleChildScrollView(
            child: Padding(
              // add space for all padding container
              padding: EdgeInsets.all(20),
              child: Container(
                child: FB5Row(
                  children: [
                   
                    FB5Col(classNames: 'col-12 mt-5', child: Image.asset('images/applogo.png',width: context.screenWidth*.25,height: context.screenWidth*.25 ,)),
                    FB5Col(
                      classNames: 'col-12',
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: AuthTextField(
                            labelText: AppLocalizations.of(context)!.loginUser,
                            obscureText: false,
                            onChanged: (text) {
                              email = text;
                            }),
                      ),
                    ),
                    FB5Col(
                        classNames: 'col-12',
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: AuthTextField(
                            labelText: AppLocalizations.of(context)!.loginPass,
                            obscureText: false,
                            onChanged: (text) {
                              pass = text;
                            },
                          ),
                        ),
                       ),
                    FB5Col(
                      classNames: 'col-12',
                      child: SizedBox(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                context.screenWidth * 0.15,
                                context.screenHeight * 0.02,
                                context.screenWidth * 0.15,
                                0),
                            child: RoundedLoadingButton(
                              controller: _loginBtnController,
                              color: appDesign.colorPrimary,
                              successIcon: Icons.cloud,
                              failedIcon: Icons.error,
                              child: Text(
                               AppLocalizations.of(context)!.loginLogin,
                                style: TextStyle(
                                  color: Color(0xfff6f6f6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                              onPressed: () => loginValidation(_loginBtnController),
                            ),
                          )),
                    ),

                         FB5Col(
                      classNames: 'col-12 mt-5',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          TextButton(
                            onPressed: () {
                              context.navigateTo(ForgetPasswordView());
                            },
                            child: Text(AppLocalizations.of(context)!.forgetPassword,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: appDesign.colorPrimary,
                                )),
                          )
                        ],
                      ),
                    ),
                    FB5Col(
                      classNames: 'col-12 ',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          TextButton(
                            onPressed: () {
                              context.navigateTo(SignUpView());
                            },
                            child: Text(AppLocalizations.of(context)!.loginNew,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: appDesign.colorPrimary,
                                )),
                          )
                        ],
                      ),
                    ),

                     FB5Col(
                      classNames: 'col-12 ',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          TextButton(
                            onPressed: () {
                              context.navigateTo(HomeView());
                            },
                            child: Text(AppLocalizations.of(context)!.continueasguest,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: appDesign.colorPrimary,
                                )),
                          )
                        ],
                      ),
                    ),
     FB5Col(classNames: 'col-12  mt-5', child:   Container(

                        child:  ImagePager(screenname: "login"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
                  ],
                ),
              ),
            ),
          ),
        )  , FB5Col(
            classNames: 'col-md-3',
          ),],
      ),
    );
  }
}
