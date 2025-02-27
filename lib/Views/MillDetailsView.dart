


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';

import '../Models/Drugs.dart';
import '../Models/Constants.dart';
import '../Models/Mills.dart';
import 'Shared/BaseAppBar.dart';
import 'Shared/Loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/imagePager.dart';

class MillDetailsView extends StatefulWidget {
  final Mills ad;

  MillDetailsView({Key? key, required this.ad}) : super(key: key);

  @override
  DrugDetailsViewState createState() => DrugDetailsViewState();
}
 void navigateToMap(num lat, num lng) async {
   var uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
  
      await launch(uri.toString());
  
}

void downloadAttachment(int id) async {
   var uri = Uri.parse("https://backend.vetdrugegy.com/attchMills/"+id.toString()+".pdf");
  
      await launch(uri.toString());
  
}
class DrugDetailsViewState extends State<MillDetailsView> {
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
            Container(

              child:   CachedNetworkImage(
                imageUrl:
                '${ConstantImages.baseURL}${ConstantImages.imgMills}${widget.ad.id}.jpg',
                progressIndicatorBuilder: (context,
                    url, downloadProgress) =>
                    Loader(showText: false),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error),
              ),
              height: context.screenHeight * 0.2,
              width: context.screenWidth,
            ),
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: FB5Row(
          children:[          FB5Col(classNames: 'col-12  mt-5', child:   Container(

                        child:  ImagePager(screenname: "milldetail"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
            FB5Col(
                classNames: 'col-12 col-md-3',child: Text(
             AppLocalizations.of(context)!.compassPrice,
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
                  widget.ad.price.toString() ,
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
                classNames: 'col-12 col-md-3',child:widget.ad.isDrug? Text(
              AppLocalizations.of(context)!.drugsActiveIngredient ,
              style: TextStyle(
                  color: appDesign.colorPrimaryDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
              ),

            ):SizedBox()
            ), FB5Col(
                classNames: 'col-12 col-md-9',child: Container(
              decoration: widget.ad.isDrug? BoxDecoration(
                border: Border.all(
                  color: appDesign.colorPrimaryDark,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),):null,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child:widget.ad.isDrug?  Text(
                                   UserData.language=="ar"? widget.ad.activeIngredient!.name: widget.ad.activeIngredient!.nameEn ,
                  style: TextStyle(
                      color: appDesign.colorPrimaryDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),

                ):SizedBox(),
              ),
            )
            ),FB5Col(
          classNames: 'col-12 col-md-3',child: Text(
            AppLocalizations.of(context)!.drugsDes ,
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
                  widget.ad.description ,
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
              AppLocalizations.of(context)!.drugsManufacturerer ,
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
                  widget.ad.company ,
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
              AppLocalizations.of(context)!.drugsSellere ,
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
                  widget.ad.user!.name ,
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
              AppLocalizations.of(context)!.signUpPhone ,
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
                  widget.ad.user!.phone1 + " / "+  widget.ad.user!.phone2,
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
                  widget.ad.user!.address,
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
              
                 navigateToMap(widget.ad.user!.locationX, widget.ad.user!.locationY);
                }
            ),
            )),
            FB5Col( classNames: 'col-12 ',child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child:  MaterialButton(
                color: appDesign.colorPrimary,
                child:  Text(
                    AppLocalizations.of(context)!.drugsDownload,
                    style: TextStyle(
                        color:Colors.white, fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
              
                 downloadAttachment(widget.ad.id);
                }
            ),
            ))
          ],




        ),
      ),

        ],
      ),
    ),);
  }
}