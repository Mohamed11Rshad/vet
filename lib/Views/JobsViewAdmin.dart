import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:vetdrugegy/Controllers/JobsController.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/Drugs.dart';
import 'package:vetdrugegy/Views/DrugAddView.dart';
import 'package:vetdrugegy/Views/DrugDetailsView.dart';
import 'package:vetdrugegy/Views/JobAddView.dart';
import 'package:vetdrugegy/Views/JobEditView.dart';
import '../Models/Constants.dart';
import '../Controllers/DrugsController.dart';
import '../Models/Jobs.dart';
import 'Shared/BaseAppBar.dart';
import 'Shared/Loader.dart';
import 'Shared/authTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/imagePager.dart';

class JobsViewAdmin extends StatefulWidget {
  const JobsViewAdmin(
      {Key? key})
      : super(key: key);

  @override
  JobsViewAdminState createState() => JobsViewAdminState();
}

class JobsViewAdminState extends State<JobsViewAdmin> {
  late List<Jobs>? _userModel = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // From Advanced Search


    _userModel = (await JobsController().GetJobsByUserId(UserData.userId));


    // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: BaseAppBar(
          appBar: AppBar(), widgetContext: context, showBackButton: true),
      body: Column(
        children: [
      Container(

                        child:  ImagePager(screenname: "jobviewadmin"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
             Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                color: appDesign.colorPrimary,
                child:  Text(
                  AppLocalizations.of(context)!.compassAdd,
                    style: TextStyle(
                        color:Colors.white, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                  context.navigateTo(JobAddView());
                }
            ),
          ),




                ]),
          ),

          Expanded(
            child: LiquidPullToRefresh(
              showChildOpacityTransition: false,
              onRefresh: ()=>getData(),
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  cacheExtent: 1024 * 1024 * 300,
                  itemCount: _userModel?.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 200.0,
                        child: FadeInAnimation(
                          child: Card(
                              margin: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  print("${_userModel![index].toJson()} ===============");
                                 //  context.navigateTo(
                                  //    JobDetailsView(ad: _userModel![index]));
                                },
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth:
                                                      context.screenWidth *
                                                          0.5),
                                                  child: Text(
                                                    _userModel![index]
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        Row(
                                            children: [
                                                   Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: MaterialButton(
                                                        color: appDesign.colorPrimary,
                                                        child:  Text(
                                                            AppLocalizations.of(context)!.edit,
                                                            style: TextStyle(
                                                                color:Colors.white, fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        onPressed: () async {
                                 context.navigateTo(JobEditView(job: _userModel![index]));
              
                                                        }),),),
                                              Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: MaterialButton(
                                                        color: appDesign.colorPrimary,
                                                        child:  Text(
                                                            AppLocalizations.of(context)!.drugsDelete,
                                                            style: TextStyle(
                                                                color:Colors.white, fontWeight: FontWeight.bold
                                                            )
                                                        ),
                                                        onPressed: () async {
              
                                                            Widget cancelButton = TextButton(
                  child: Text(AppLocalizations.of(context)!.drugsYes),
                  onPressed:  () {  Navigator.pop(context);},
                );
                Widget continueButton = TextButton(
                  child: Text(AppLocalizations.of(context)!.drugsNoNo),
                  onPressed:  () async {          await JobsController().JobDelete(_userModel![index].id).then((isSucc) {
                          
              
              
                            setState(() {
                              getData();
                              Navigator.pop(context);
                            });
                                                        });},
                );
              
                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: Text(AppLocalizations.of(context)!.loginAlert),
                  content: Text(AppLocalizations.of(context)!.drugsDeleteConfirm),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );
              
                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
                                                        
                                                        }
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}