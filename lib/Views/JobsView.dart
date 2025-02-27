import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:vetdrugegy/Controllers/JobsController.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/Drugs.dart';
import 'package:vetdrugegy/Views/DrugAddView.dart';
import 'package:vetdrugegy/Views/DrugDetailsView.dart';
import 'package:vetdrugegy/Views/JobsViewAdmin.dart';
import '../Models/Constants.dart';
import '../Controllers/DrugsController.dart';
import '../Models/Jobs.dart';
import 'JobsDetailsView.dart';
import 'Shared/BaseAppBar.dart';
import 'Shared/Loader.dart';
import 'Shared/authTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/imagePager.dart';

class JobsView extends StatefulWidget {
  const JobsView(
      {Key? key})
      : super(key: key);

  @override
  JobsViewState createState() => JobsViewState();
}

class JobsViewState extends State<JobsView> {
  late List<Jobs>? _userModel = [];
String searchQuery="";
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // From Advanced Search


    _userModel = (await JobsController().GetJobs(searchQuery));


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

                        child:  ImagePager(screenname: "jobview"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),
          UserData.userId>0?    Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
             Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                color: appDesign.colorPrimary,
                child:  Text(
                AppLocalizations.of(context)!.drugsControlPanel,
                    style: TextStyle(
                        color:Colors.white, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                 context.navigateTo(JobsViewAdmin());
                }
            ),
          ),




                ]),
          ):SizedBox(),
 Padding(
            padding: const EdgeInsets.all(8.0),
            child: AuthTextField(
                labelText: AppLocalizations.of(context)!.drugsSearch,
                obscureText: false,
                onChanged: (text) {
searchQuery=text;
                }),
          ),
          MaterialButton(
                color: appDesign.colorPrimary,
                child:  Text(
                    AppLocalizations.of(context)!.drugsSearch,
                    style: TextStyle(
                        color:Colors.white, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
              
                 getData();
                }
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
                                   context.navigateTo(
                                      JobDetailsView(ad: _userModel![index]));
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
                                                    child: _userModel![index].user ==
                                                        null
                                                        ? const Center()
                                                        : Text(
                                                     AppLocalizations.of(context)!.jobAdvertiser+" : " +
                                                          _userModel![index]
                                                              .user!
                                                              .name,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      textAlign:
                                                      TextAlign.start,
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