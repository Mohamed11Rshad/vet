


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/User.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';

import '../Models/Drugs.dart';
import '../Models/Constants.dart';
import '../Models/Jobs.dart';
import 'Shared/BaseAppBar.dart';
import 'Shared/Loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/imagePager.dart';

class UsersGuideDetailsView extends StatefulWidget {
  final User ad;
  var govermentsList = <String>[
     UserData.language=="ar"?"الإسكندرية":"Alex",
     UserData.language=="ar"?"الإسماعيلية":"Ismailia",
     UserData.language=="ar"?"أسوان":"Aswan",
     UserData.language=="ar"?"أسيوط":"Assiut",
     UserData.language=="ar"?"الأقصر":"Luxor",
    UserData.language=="ar"? "البحر الأحمر":"Red Sea",
    UserData.language=="ar"? "البحيرة":"Behira",
    UserData.language=="ar"? "بني سويف":"Beni Suef",
     UserData.language=="ar"?"بورسعيد":"Portsaid",
     UserData.language=="ar"?"جنوب سيناء":"South Sinai",
    UserData.language=="ar"? "الجيزة":"Giza",
    UserData.language=="ar"? "الدقهلية":"Dakahlia",
     UserData.language=="ar"?"دمياط":"Damietta",
     UserData.language=="ar"?"سوهاج":"Sohag",
    UserData.language=="ar"? "السويس":"Suez",
    UserData.language=="ar"? "الشرقية":"Sharqia",
    UserData.language=="ar"? "شمال سيناء":"North Sinai",
    UserData.language=="ar"? "الغربية":"Gharbia",
    UserData.language=="ar"? "الفيوم":"Fayyoum",
    UserData.language=="ar"? "القاهرة":"Cairo",
    UserData.language=="ar"? "القليوبية":"Qaliobia",
     UserData.language=="ar"?"قنا":"Qena",
     UserData.language=="ar"?"كفر الشيخ":"Kafr Elsheikh",
     UserData.language=="ar"?"مطروح":"Matrouh",
     UserData.language=="ar"?"المنوفية":"Menoufia",
     UserData.language=="ar"?"المنيا":"Alminia",
     UserData.language=="ar"?"الوادي الجديد":"New Valley",

  ];
  UsersGuideDetailsView({Key? key, required this.ad}) : super(key: key);

  @override
  UsersGuideDetailsViewState createState() => UsersGuideDetailsViewState();
}
 void navigateToMap(num lat, num lng) async {
   var uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
  
      await launch(uri.toString());
  
}


class UsersGuideDetailsViewState extends State<UsersGuideDetailsView> {
  List<Drugs> randomAdsArr = [];
  final RoundedLoadingButtonController btnDownload =
  RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnGoToLocation =
  RoundedLoadingButtonController();
  @override
  void initState() {
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appDesign.backGround,
      appBar: BaseAppBar(
          appBar: AppBar(),
          widgetContext: context,
          showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
     
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: FB5Row(
          children:[
                      FB5Col(classNames: 'col-12  mt-5', child:   Container(

                        child:  ImagePager(screenname: "userguidedetail"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
            FB5Col(
                classNames: 'col-12 col-md-3',child: Text(
              AppLocalizations.of(context)!.signUpFullName,
              style: TextStyle(
                  color: appDesign.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),

            )
            ), FB5Col(
                classNames: 'col-12 col-md-9',child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: appDesign.colorPrimaryDark,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.ad.name,
                  style: TextStyle(
                      color: appDesign.colorPrimaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),

                ),
              ),
            )
            ),
            FB5Col(
                classNames: 'col-12 col-md-3',child: Text(
              AppLocalizations.of(context)!.signUpBusinessName ,
              style: TextStyle(
                  color: appDesign.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),

            )
            ), FB5Col(
                classNames: 'col-12 col-md-9',child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: appDesign.colorPrimaryDark,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.ad.companyName ,
                  style: TextStyle(
                      color: appDesign.colorPrimaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),

                ),
              ),
            )
            ),FB5Col(
          classNames: 'col-12 col-md-3',child: Text(
             AppLocalizations.of(context)!.signUpGovernment,
            style: TextStyle(
                color: appDesign.colorPrimaryDark,
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),

          )
          ), FB5Col(
              classNames: 'col-12 col-md-9',child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: appDesign.colorPrimaryDark,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
               widget.govermentsList[widget.ad.government] ,
                  style: TextStyle(
                      color: appDesign.colorPrimaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),

                ),
              ),
            ),
          )
          ),
     
        
            FB5Col(
                classNames: 'col-12 col-md-3',child: Text(
               AppLocalizations.of(context)!.signUpPhone,
              style: TextStyle(
                  color: appDesign.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),

            )
            ), FB5Col(
                classNames: 'col-12 col-md-9',child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: appDesign.colorPrimaryDark,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.ad.phone1 ,
                  style: TextStyle(
                      color: appDesign.colorPrimaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),

                ),
              ),
            )
            ),
            FB5Col(
                classNames: 'col-12 col-md-3',child: Text(
               AppLocalizations.of(context)!.drugsAddress ,
              style: TextStyle(
                  color: appDesign.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),

            )
            ), FB5Col(
                classNames: 'col-12 col-md-9',child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: appDesign.colorPrimaryDark,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.ad.address ,
                  style: TextStyle(
                      color: appDesign.colorPrimaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),

                ),
              ),
            )
            ),  FB5Col(
                classNames: 'col-12 col-md-3',child: Text(
               AppLocalizations.of(context)!.signUpNotes ,
              style: TextStyle(
                  color: appDesign.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),

            )
            ),FB5Col(
                classNames: 'col-12 col-md-9',child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: appDesign.colorPrimaryDark,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.ad.notest ,
                  style: TextStyle(
                      color: appDesign.colorPrimaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),

                ),
              ),
            )
            ),
            FB5Col( classNames: 'col-12 ',child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child:   MaterialButton(
                color: appDesign.colorPrimary,
                child:  Text(
                     AppLocalizations.of(context)!.drugsGoToLoc,
                    style: TextStyle(
                        color:Colors.white, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
              
                 navigateToMap(widget.ad.locationX, widget.ad.locationY);
                }
            ),
            )),
   
          ],




        ),
      ),

        ],
      ),
    ),);
  }
}