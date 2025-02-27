





import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vetdrugegy/Controllers/DrugsController.dart';
import 'package:vetdrugegy/Controllers/JobsController.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/DrugsActiveIngredients.dart';
import 'package:vetdrugegy/Models/DrugsCategories.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';
import '../Models/Constants.dart';
import '../Controllers/UserController.dart';
import '../Models/Drugs.dart';
import '../Models/Jobs.dart';
import '../Models/User.dart';
import '../Models/UsersAnimals.dart';
import 'LoginView.dart';
import 'Shared/BaseAppBar.dart';
import 'Shared/authTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/imagePager.dart';

class JobAddView extends StatefulWidget {


  //constructor
  JobAddView({Key? key}) : super(key: key);

  @override
  _JobAdd createState() => _JobAdd();
}

class _JobAdd extends State<JobAddView> {
  final controller = JobsController();

  final RoundedLoadingButtonController _signUpBtnController =
  RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnDetectLocation =
  RoundedLoadingButtonController();
  var isLoading = false;
  String name="";
  String details="";
  String city="";
  String phone="";
  int selectedGoverment = 0;
  File? pdf;
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

  var selectedBreederIndexes = [];
  @override
  void initState() {
    _signUpBtnController.start();
    super.initState();

   // 
  }

  





  Future pickAttachment() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['pdf'],);

    if (result != null) {
      File file = File(result.files.single.path!);
      pdf=file;
    } else {
      // User canceled the picker
    }
  }




  void signUpValidation(RoundedLoadingButtonController btnController) {

 String base64Attachment="";

try{
       final bytes2 =
          pdf!.readAsBytesSync();

           base64Attachment = base64Encode(bytes2);
}
catch(error){

}
          
         

   
          controller
              .AddJob(
              new Jobs(id: 0, name: name, details: details, government: selectedGoverment, city: city,phone: phone,userId: UserData.userId,attachment: base64Attachment))
              .then((user) {
            if (user != null) {
              btnController.success();
              //context.saveUser(user);
              //context.navigateTo(bottom app bar);
            } else {
              btnController.error();
              context.showAlert(
                  title: AppLocalizations.of(context)!.loginAlert,
                  message: AppLocalizations.of(context)!.drugsFail);
              btnController.reset();
            }
          });






  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
         appBar: BaseAppBar(
          appBar: AppBar(), widgetContext: context, showBackButton: true),
      backgroundColor: appDesign.backGround,
      body: SingleChildScrollView(
        child: Padding(
          // add space for all padding container
          padding: EdgeInsets.all(context.screenWidth * 0.0),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: FB5Row(
                classNames: ' justify-content-center',
                children: [
                         FB5Col(classNames: 'col-12  mt-5', child:   Container(

                        child:  ImagePager(screenname: "jobadd"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( AppLocalizations.of(context)!.jobTitle,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                    onChanged: (text) {
                      name = text;
                    },
                  ),),
    FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( AppLocalizations.of(context)!.jobDes,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                    onChanged: (text) {
                      details = text;
                    },
                  ),),
                    FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( AppLocalizations.of(context)!.signUpGovernment,style: TextStyle(   fontSize: 15,
                      ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: DropdownButtonFormField<String>(
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
                    hint: Text(AppLocalizations.of(context)!.signUpGovernment),
                    value: govermentsList[0],
                    items: govermentsList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      selectedGoverment = govermentsList.indexOf(selectedValue!);
                    },
                  ),
                  ),
                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.jobAddress,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                    onChanged: (text) {
                      city = text;
                    },
                  ),),


                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.jobPhone,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                    onChanged: (text) {
                      phone = text;
                    },
                  ),),
                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: appDesign.colorPrimary,
                        child:  Text(
                            AppLocalizations.of(context)!.drugsAttachment,
                            style: TextStyle(
                                color:Colors.white, fontWeight: FontWeight.bold
                            )
                        ),
                        onPressed: () {
                          pickAttachment();
                        }
                    ),
                  ),),




                  FB5Col( classNames: 'col-12',child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedLoadingButton(
                      controller: _signUpBtnController,
                      color: appDesign.colorPrimary,
                      successIcon: Icons.cloud,
                      failedIcon: Icons.error,
                      child: Text(
                       AppLocalizations.of(context)!.compassAdd,
                        style: TextStyle(
                            color: Color(0xfff6f6f6),
                            fontWeight: FontWeight.w600,
                            fontSize: 20
                        ),
                      ),
                      onPressed: () => signUpValidation(_signUpBtnController),
                    ),
                  ))

                  // SizedBox(height: context.screenHeight * 0.025),








                  //SizedBox(height: context.screenHeight * 0.02),


                  //SizedBox(height: context.screenHeight * 0.01),

                  //SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}