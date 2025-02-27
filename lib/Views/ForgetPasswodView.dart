



import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Views/HomeView.dart';
import 'package:vetdrugegy/Views/NewPasswordView.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';
import '../Controllers/UserController.dart';
import '../Models/Constants.dart';
import 'Shared/authTextField.dart';
import 'Shared/imagePager.dart';
import 'SignUpView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ForgetPasswordView extends StatefulWidget {
  //constructor
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ForgetPasswordView> {
  final controller = UserController();
  final RoundedLoadingButtonController _loginBtnController =
  RoundedLoadingButtonController();
  var isLoading = false;
  var email;
  var pass;
  String? deviceImei="";
  String? type;
  bool getPermission = false;
  int randomNumber=0;
  @override
 initState()  {
    super.initState();

  }


sendSMS(RoundedLoadingButtonController btnController){
  if(randomNumber==0){
      if (email == null) {
      context.showAlert(
          title:  AppLocalizations.of(context)!.loginAlert,
          message:  AppLocalizations.of(context)!.loginAlertDetails);
                btnController.reset();
                    

    } else {
 randomNumber = Random().nextInt(999999 - 100000) + 100000;
      controller.SendSMS(email, "برجاء ادخال الرمز التالي "+randomNumber.toString()+" تطبيق فيت دراج ايجي").then((value) async {
      btnController.reset();

      });
      }}
      else{
          context.showAlert(
          title:  AppLocalizations.of(context)!.loginAlert,
          message:  AppLocalizations.of(context)!.codesent);
                btnController.reset();
      }
}

  void loginValidation() {
    if (pass == null || randomNumber==0) {
      context.showAlert(
          title:  AppLocalizations.of(context)!.loginAlert,
          message:  AppLocalizations.of(context)!.loginAlertDetails);
    } else {
      print("password"+pass+"/"+randomNumber.toString());
      if (pass==randomNumber.toString()) {
        
          context.navigateTo(NewPasswordView(phone: email));


        } else {
          context.showAlert(
              title:  AppLocalizations.of(context)!.loginAlert,
              message:  AppLocalizations.of(context)!.wrongcode);
        }
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
                            labelText: AppLocalizations.of(context)!.signUpPhone,
                            obscureText: false,
                            onChanged: (text) {
                              email = text;
                            }),
                      ),
                    ),
                   FB5Col(
                      classNames: 'col-12',
                      child: SizedBox(
                          child: Padding(
                                                      padding: const EdgeInsets.all(11.0),

                            child: RoundedLoadingButton(
                              controller: _loginBtnController,
                              color: appDesign.colorPrimary,
                              successIcon: Icons.cloud,
                              failedIcon: Icons.error,
                              child: Text(
                               AppLocalizations.of(context)!.sendCode,
                                style: TextStyle(
                                  color: Color(0xfff6f6f6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                              onPressed: () =>                           sendSMS(_loginBtnController)
,
                            ),
                          )),
                    ),
                    FB5Col(
                        classNames: 'col-12',
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: AuthTextField(
                            labelText: AppLocalizations.of(context)!.code,
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
                            child: MaterialButton(
                               shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
                        color: appDesign.colorPrimary,
                        child:  Text(
                            AppLocalizations.of(context)!.cofirm,
                              style: TextStyle(
                                  color: Color(0xfff6f6f6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                        ),
                        onPressed: () {
                          loginValidation();
                        }
                    ),
                          )),
                    ),
                   
     FB5Col(classNames: 'col-12  mt-5', child:   Container(

                        child:  ImagePager(screenname: "forgetpassword"),
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
