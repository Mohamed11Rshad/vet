import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Controllers/CompassController.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/CompassResult.dart';
import 'package:vetdrugegy/Views/HomeView.dart';
import 'package:vetdrugegy/Views/Shared/BaseAppBar.dart';
import 'package:vetdrugegy/Views/Shared/imagePager.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';


import '../Models/Compass.dart';
import '../Models/Constants.dart';
import 'LoginView.dart';
import 'Shared/authTextField.dart';
import 'SignUpView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompassResultView extends StatefulWidget {
  final String? entryDate;
  const CompassResultView({Key? key,this.entryDate}) : super(key: key);

  @override
  State<CompassResultView> createState() => CompassResultViewState();
}

class CompassResultViewState extends State<CompassResultView> {
  final controller = CompassController();

  var compassAddDirections = <String>[];
  String selectedCompassDirection="";
  TextEditingController dateInput = TextEditingController();

  final RoundedLoadingButtonController btnAddToCompass =
  RoundedLoadingButtonController();

  final RoundedLoadingButtonController btnShowCompass =
  RoundedLoadingButtonController();
  late List<CompassResult>? compasses = [];


  @override
  void initState() {
    super.initState();
getCompasses();

  }



  void getCompasses() async {
    compasses = (await CompassController().GetCompasses(widget!.entryDate!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void signUpValidation(RoundedLoadingButtonController btnController) {
    btnController.reset();
    Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: BaseAppBar(
          appBar: AppBar(),
          widgetContext: context,
          showBackButton: true,
          showSearch: false,
      ),
      backgroundColor: appDesign.backGround,
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: FB5Row( classNames: ' justify-content-center',children: [    FB5Col(classNames: 'col-12  mt-5', child:   Container(

                        child:  ImagePager(screenname: "compassresult"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
                       FB5Col(
              classNames: 'col-12 col-md-6 mt-5',
              child:  Text(widget.entryDate!,style: TextStyle(   fontSize: 15,fontWeight: FontWeight.bold),),

            ),
            FB5Col(
              classNames: 'col-12 col-md-6 mt-5',
              child:  Text(AppLocalizations.of(context)!.compassResultTitle,style: TextStyle(   fontSize: 15,fontWeight: FontWeight.bold),),

            ),

            FB5Col(classNames:'col-12', child: Container(

              child: compasses==null?SizedBox():ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: compasses!.length,
                itemBuilder: (_, int index) {
                  return Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),
                      child: FB5Row(
                        children: [
                          FB5Col(
                            classNames: 'col-12',
                            child: Text(UserData.language=="ar"? Constants.animals[compasses![index]!.animalType!].name!:Constants.animalsEn[compasses![index]!.animalType!].name!,style: TextStyle(   fontSize: 15,fontWeight: FontWeight.bold
                            ),),
                          ),
                          FB5Col(
                              classNames: 'col-6',
                              child:FB5Row(children: [
                                FB5Col(  classNames: 'col-4',child: Container(
                                  height: 100,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(AppLocalizations.of(context)!.compassResultRequired,style: TextStyle(fontSize: 13)),
                                    ),
                                  ),
                                ),),
                                FB5Col(  classNames: 'col-6',child: Container(
                                  height: 100,

                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        compasses![index].buy.toString(),

                                      ),
                                    ),
                                  ),
                                ),),
                                FB5Col(  classNames: 'col-2',)
                              ],

                              )
                          ),
                          FB5Col(
                              classNames: 'col-6',
                              child:FB5Row(children: [
                                FB5Col(  classNames: 'col-6',child: Container(
                                  height: 100,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(AppLocalizations.of(context)!.compassResultOffering,style: TextStyle(fontSize: 13),),
                                    ),
                                  ),
                                ),),
                                FB5Col(  classNames: 'col-6',child: Container(
                                  height: 100,

                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        compasses![index].sell.toString(),

                                      ),
                                    ),
                                  ),
                                ),),

                              ],

                              )
                          ),
                          FB5Col(
                              classNames: 'col-12',
                              child:FB5Row(children: [
                                FB5Col(  classNames: 'col-2',child: Container(
                                  height: 60,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(AppLocalizations.of(context)!.compassPrice,style: TextStyle(fontSize: 13),),
                                    ),
                                  ),
                                ),),
                                FB5Col(  classNames: 'col-8',child: Container(
                                  height: 60,

                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        compasses![index].avgPrice.toString(),

                                      ),
                                    ),
                                  ),
                                ),),
                                FB5Col(  classNames: 'col-2')
                              ],

                              )
                          ),
                        ],

                      ),
                    ),
                  );
                },
              ) ,
            ),),

            FB5Col(
                classNames: 'col-12 col-md-6 mt-5',
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedLoadingButton(
                    controller: btnShowCompass,
                    color: appDesign.colorPrimary,
                    successIcon: Icons.cloud,
                    failedIcon: Icons.error,
                    child: Text(
                      AppLocalizations.of(context)!.compassResultBack,
                      style: TextStyle(
                          color: Color(0xfff6f6f6),
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                      ),
                    ),
                    onPressed: () => signUpValidation(btnShowCompass),
                  ),
                )
            ),
        
          ],

          ),),
      ),
    );
  }
}