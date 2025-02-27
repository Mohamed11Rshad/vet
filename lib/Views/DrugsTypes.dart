import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Views/CompassAddView.dart';
import 'package:vetdrugegy/Views/DrugsView.dart';
import 'package:vetdrugegy/Views/MillsView.dart';
import 'package:vetdrugegy/Views/Shared/BaseAppBar.dart';
import 'package:vetdrugegy/Views/Shared/imagePager.dart';


import '../Models/Constants.dart';
import 'LoginView.dart';
import 'SignUpView.dart';

class DrugsTypes extends StatefulWidget {
  final bool? isDrug;
  const DrugsTypes({Key? key,this.isDrug}) : super(key: key);

  @override
  State<DrugsTypes> createState() => DrugsTypesState();
}

class DrugsTypesState extends State<DrugsTypes> {
  @override
  void initState() {
    super.initState();
  }







  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: appDesign.backGround,
          appBar: BaseAppBar(
          appBar: AppBar(), widgetContext: context, showBackButton: true,showSearch: false,),
      body:  SingleChildScrollView(
        child: FB5Row(
          classNames: ' justify-content-center',
          children: [    FB5Col(classNames: 'col-12 col-md-12 mt-5', child:   Container(

                        child:  ImagePager(screenname: "drugtype"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',child:
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () {
                  context.navigateTo(widget.isDrug!?DrugsView(isDrug:widget.isDrug!,categoryId:0):MillsView(isDrug:widget.isDrug!,categoryId:0));

                },
                child: Card(
                  color: appDesign.colorPrimaryDark,
                  elevation: 2.0,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FB5Row(children: [  FB5Col(
                        classNames: 'col-9 align-items-center',child:Container(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(alignment: Alignment.centerRight,child: Text(UserData.language=="ar"?"دواجن":"Poultry",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold))),
                          ),
                         

                        ],
                      ),
                    )),
                      FB5Col(
                          classNames: 'col-3',child:Container(
                          height: 180,child: Image.asset("images/chickens.png")))],

                    ),
                  ),
                ),
              ),
            ),
            ),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',child:
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () {
                  context.navigateTo(widget.isDrug!?DrugsView(isDrug:widget.isDrug!,categoryId:1):MillsView(isDrug:widget.isDrug!,categoryId:1));

                },
                child: Card(
                  color: appDesign.colorPrimaryLight,
                  elevation: 2.0,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FB5Row(children: [   FB5Col(
                        classNames: 'col-3',child:Container(
                        height: 180,child: Image.asset("images/large.png"))), FB5Col(
                        classNames: 'col-9 align-items-center',child:Container(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(alignment: Alignment.centerLeft,child: Text(UserData.language=="ar"?"مجترة":"Large",style: TextStyle(color: appDesign.colorPrimaryDark,fontSize: 25,fontWeight: FontWeight.bold))),
                          ),
                     

                        ],
                      ),
                    ))
                    ],

                    ),
                  ),
                ),
              ),
            ),
            ),FB5Col(
              classNames: 'col-12 col-md-12 mt-5',child:
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () {
                  context.navigateTo(widget.isDrug!?DrugsView(isDrug:widget.isDrug!,categoryId:2):MillsView(isDrug:widget.isDrug!,categoryId:2));

                },
                child: Card(
                  color: appDesign.colorPrimaryDark,
                  elevation: 2.0,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FB5Row(children: [  FB5Col(
                        classNames: 'col-9 align-items-center',child:Container(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(alignment: Alignment.centerRight,child: Text(UserData.language=="ar"?"حيوانات اليفة":"Pets",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold))),
                          ),
                    
                        ],
                      ),
                    )),
                      FB5Col(
                          classNames: 'col-3',child:Container(
                          height: 180,child: Image.asset("images/pets.png")))],

                    ),
                  ),
                ),
              ),
            ),
            ),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',child:
            Container(
              height: 200,
              child: GestureDetector(
                onTap: () {
                  context.navigateTo(widget.isDrug!?DrugsView(isDrug:widget.isDrug!,categoryId:3):MillsView(isDrug:widget.isDrug!,categoryId:3));

                },
                child: Card(
                  color: appDesign.colorPrimaryLight,
                  elevation: 2.0,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FB5Row(children: [   FB5Col(
                        classNames: 'col-3',child:Container(
                        height: 180,child: Image.asset("images/fishes.png"))), FB5Col(
                        classNames: 'col-9 align-items-center',child:Container(
                      height: 180,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(alignment: Alignment.centerLeft, child: Text(UserData.language=="ar"?"أسماك":"Fish",style: TextStyle(color: appDesign.colorPrimaryDark,fontSize: 25,fontWeight: FontWeight.bold))),
                          ),
                  

                        ],
                      ),
                    ))
                    ],

                    ),
                  ),
                ),
              ),
            ),
            )
            ,
          ],
        ),
      ),
    );
  }
}