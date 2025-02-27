import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:vetdrugegy/Controllers/UserController.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/Drugs.dart';
import 'package:vetdrugegy/Views/DrugDetailsView.dart';
import 'package:vetdrugegy/Views/UsersGuideDetailsView.dart';
import '../Models/Constants.dart';
import '../Controllers/DrugsController.dart';
import '../Models/User.dart';
import 'DrugsViewAdmin.dart';
import 'Shared/BaseAppBar.dart';
import 'Shared/Loader.dart';
import 'Shared/authTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/imagePager.dart';

class UsersGuideView extends StatefulWidget {
  const UsersGuideView(
      {Key? key})
      : super(key: key);

  @override
  UsersGuideViewState createState() => UsersGuideViewState();
}

class UsersGuideViewState extends State<UsersGuideView> {
  late List<User>? _userModel = [];
  int selectedJobType = 0;
  bool isChecked=false;
  String searchText="";

 var jobTypes = <String>[
    UserData.language=="ar"?"كل الأنشطة":"All",
     UserData.language=="ar"?"مربي":"Breeder",
    UserData.language=="ar"?"مصنع علف":"Feed Mills Factory",
    UserData.language=="ar"?"مكتب بيطري":"Vet Pharmacy",
    UserData.language=="ar"?"شركة أدوية":"Vet Drug Company",
    UserData.language=="ar"?"طبيب بيطري":"Veternarian",
    UserData.language=="ar"?"معمل بيطري":"Vet Lab",
    UserData.language=="ar"?"مجزر دواجن":"Polutry Slaughterhouse",
    UserData.language=="ar"?"محل دواجن":"Polutry Shop",
    UserData.language=="ar"?"فندق":"Hotel",
    UserData.language=="ar"?"هايبر ماركت":"Market",
    UserData.language=="ar"?"مستودع بيع وشراء بيض":"Eggs Shop",
    UserData.language=="ar"?"مطاعم":"Restaurants",
    UserData.language=="ar"?"أخرى":"Other",


  ];
  @override
  void initState() {
    super.initState();
  }

  void getData() async {
    if(searchText.length>0){
    // From Advanced Search
int government=-1;
int jobType=-1;
if(isChecked){
government=UserData.government;
}
if(selectedJobType>0){
jobType=selectedJobType-1;
}
      _userModel = (await UserController().GetUsersSearch(
          jobType,government,searchText));
              
    setState(() {});}
    else{
      //alert
       context.showAlert(
          title:  AppLocalizations.of(context)!.loginAlert,
          message:  AppLocalizations.of(context)!.userGuideSearchAlert);
    }
  }
bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
  @override
  Widget build(BuildContext context) {
Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return appDesign.backGround;
      }
      return appDesign.backGround;
    }

    return Scaffold(
      appBar: BaseAppBar(
          appBar: AppBar(), widgetContext: context, showBackButton: true),
      body: Column(
        children: [
              Container(

                        child:  ImagePager(screenname: "userguide"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),
                      Padding(
            padding: const EdgeInsets.all(8.0),
            child:AuthTextField(
                                        labelText: AppLocalizations.of(context)!.userGuideSearchAlert,
                                        obscureText: false,
                                        onChanged: (text) {
                                         searchText=text;

                                        },
                                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),

                      focusColor: appDesign.colorPrimary ,
                      labelStyle: TextStyle(
                        fontSize: 15,

                        color: Colors.grey[350],
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide(color: appDesign.colorPrimary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide(color: appDesign.colorPrimary), // Set the focused border color
                      ),
                    ),
                    hint: Text( AppLocalizations.of(context)!.signUpBusinessType),
                    value: jobTypes[0],
                    items: jobTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      selectedJobType = jobTypes.indexOf(selectedValue!);
                      setState(() {

                      });
                    },
                  ),
          ),
            UserData.userId>0?  Row(
  children: [
    
    Checkbox(
        value: isChecked,
        checkColor: appDesign.colorPrimary,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        onChanged: (bool? selected) {
                 isChecked = selected!;
setState(() {
  
});
        }),
     Text(AppLocalizations.of(context)!.onlyNearest),
  ],
):SizedBox(),
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
                     AppLocalizations.of(context)!.drugsNo +
                          _userModel!.length.toString(),
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.start),




                ]),
          ),

          Expanded(
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
                                    UsersGuideDetailsView(ad: _userModel![index]));
                              },
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                 
                                  Expanded(
                                    flex: 10,
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
                                                      .companyName
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
        ],
      ),
    );
  }
}