import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/Drugs.dart';
import 'package:vetdrugegy/Models/Mills.dart';
import 'package:vetdrugegy/Views/DrugDetailsView.dart';
import 'package:vetdrugegy/Views/MillDetailsView.dart';
import 'package:vetdrugegy/Views/MillsViewAdmin.dart';
import '../Models/Constants.dart';
import '../Controllers/DrugsController.dart';
import 'DrugsViewAdmin.dart';
import 'Shared/BaseAppBar.dart';
import 'Shared/Loader.dart';
import 'Shared/authTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/imagePager.dart';

class MillsView extends StatefulWidget {
  final bool? isDrug;
final int? categoryId;
  const MillsView(
      {Key? key,
        this.isDrug,this.categoryId})
      : super(key: key);

  @override
  DrugsViewState createState() => DrugsViewState();
}

class DrugsViewState extends State<MillsView> {
  late List<Mills>? _userModel = [];
  late bool isDrug;
String searchQuery="";
  @override
  void initState() {
    super.initState();
    isDrug = widget.isDrug!;
    getData();
  }

  Future<void> getData() async {
    // From Advanced Search

    if(_isNumeric(searchQuery)){
      _userModel = (await DrugsController().GetMills(
          widget.categoryId!, "", double.parse(searchQuery)));
                  }
                  else{
      _userModel = (await DrugsController().GetMills(
           widget.categoryId!, searchQuery, 1000000));
                  }



    // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    setState(() {});
  }
bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: BaseAppBar(
          appBar: AppBar(), widgetContext: context, showBackButton: true,showSearch: false,),
      body: Column(
        children: [
                 Container(

                        child:  ImagePager(screenname: "millview"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),
       UserData.userId>0?    Padding(
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
                  context.navigateTo(MillsViewAdmin(isDrug:widget.isDrug!,categoryId:widget.categoryId!));
                }
            ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                     AppLocalizations.of(context)!.drugsNo+
                          _userModel!.length.toString(),
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.start),




                ]),
          ),

          Expanded(
            child: Container(
              child: LiquidPullToRefresh(
              showChildOpacityTransition: false,
                   onRefresh: ()=>getData(),
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
                                      MillDetailsView(ad: _userModel![index]));
                                },
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          //apply padding to all four sides
                                          child: CachedNetworkImage(
                                            imageUrl:
                                            '${ConstantImages.baseURL}${ConstantImages.imgMills}${_userModel![index].id}.jpg',
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) =>
                                                Loader(showText: false),
                                            errorWidget: (context, url, error) =>
                                                Icon(Icons.error),
                                            height: context.screenHeight * 0.17,
                                          )),
                                    ),
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
                                                 UserData.language=="ar"?   _userModel![index]
                                                        .name
                                                        .toString():_userModel![index]
                                                        .nameEn
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
                                                    child: Text(
                                            AppLocalizations.of(context)!.compassPrice +
                                                          _userModel![index]
                                                              .price
                                                              .toString()
                                                          ,
                                                      style: TextStyle(
                                                          color: Colors.deepOrange),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  )),
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
                                                     AppLocalizations.of(context)!.drugsSellere+":" +
                                                          _userModel![index]
                                                              .user!
                                                              .companyName,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      textAlign:
                                                      TextAlign.start,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        _userModel![index].isDrug?  Row(
                                            children: [
                                              Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: _userModel![index].user ==
                                                        null
                                                        ? const Center()
                                                        : Text(
                                                  AppLocalizations.of(context)!.drugsActiveIngredient+":"  +
                                                          UserData.language=="ar"? _userModel![index]
                                                              .activeIngredient!.name:_userModel![index]
                                                              .activeIngredient!.nameEn,
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      textAlign:
                                                      TextAlign.start,
                                                    ),
                                                  )),
                                            ],
                                          ):SizedBox(),
                
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