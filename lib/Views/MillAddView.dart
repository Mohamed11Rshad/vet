





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
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/DrugsActiveIngredients.dart';
import 'package:vetdrugegy/Models/DrugsCategories.dart';
import 'package:vetdrugegy/Models/Mills.dart';
import 'package:vetdrugegy/Models/MillsActiveIngredients.dart';
import 'package:vetdrugegy/Views/Shared/BaseAppBar.dart';
import 'package:vetdrugegy/Views/Shared/autoCompleteTextField.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';
import '../Models/Constants.dart';
import '../Controllers/UserController.dart';
import '../Models/Drugs.dart';
import '../Models/User.dart';
import '../Models/UsersAnimals.dart';
import 'LoginView.dart';
import 'Shared/authTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/imagePager.dart';

class MillAddView extends StatefulWidget {
  bool? isDrug;
  int? categoryId;

  //constructor
  MillAddView({Key? key,this.isDrug,this.categoryId}) : super(key: key);

  @override
  _DrugAdd createState() => _DrugAdd();
}

class _DrugAdd extends State<MillAddView> {
  final controller = DrugsController();

  final RoundedLoadingButtonController _signUpBtnController =
  RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnDetectLocation =
  RoundedLoadingButtonController();
  var isLoading = false;
  String name="";
  String price="";
  String description="";
  String company="";
  var number;
  int selectedGoverment = 0;
  int selectedActiveIngrdient = 0;
  File? image;
  File? pdf;
    List<Mills> suggestions = [];
  int categoryId=0;
  bool isDrug=true;
  List<String> activeIngredientsArr = [];
  int activeIngredientId=1;
  MillsActiveIngredient? dropDownActiveIngredientValue = null;

  List<MillsActiveIngredient> activeIngredientsList = [];
  

  var selectedBreederIndexes = [];


    int selectedType = 0;
  var typeList = <String>[
    UserData.language=="ar"?"علف نهائي":"Feed Mill",
     UserData.language=="ar"?"مستلزمات أعلاف":"Additions",
  

  ];
  @override
  void initState() {
    categoryId=widget.categoryId!;
    isDrug=widget.isDrug!;
    _signUpBtnController.start();
    super.initState();
        loadSuggestions();
    loadActiveIngredient(this.categoryId);
   // 
  }

  


     Future<void> loadSuggestions() async {
    List<Mills>? cities = await controller.GetMillsSuggestions(categoryId);
    if (cities != null) {
      suggestions = cities;
      //selectedCityObj = cities [0];
      final List<String> cityNames = cities.map((city) => UserData.language == "en" ? city.nameEn : city.name).toList();
      setState(() {
        isLoading = false;

      });
    } else {
      //todo down from server cannot get the cities
      setState(() {
        isLoading = false;
      });
    }
  }


  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);if(image == null) return;final imageTemp = File(image.path);setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
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
  Future<void> loadActiveIngredient(int parentId) async {
    List<MillsActiveIngredient>? cities = await controller.GetMillsActiveIngredients(categoryId);
    if (cities != null) {
      activeIngredientsList = cities;
      //selectedCityObj = cities [0];
      final List<String> cityNames = cities.map((city) => UserData.language == "en" ? city.nameEn : city.name).toList();
      setState(() {
        isLoading = false;
        activeIngredientsArr = cityNames;
        print(activeIngredientsArr.length);
        if (activeIngredientsArr.length != 0) {
                  dropDownActiveIngredientValue = cities![0];
        activeIngredientId = cities![0].id;
        }
      });
    } else {
      //todo down from server cannot get the cities
      setState(() {
        isLoading = false;
      });
    }
  }



  void signUpValidation(RoundedLoadingButtonController btnController) {

 String base64Image="";
 String base64Attachment="";
try{
 final bytes =
          image!.readAsBytesSync();

           base64Image = base64Encode(bytes);
}
catch(error){

}
try{
       final bytes2 =
          pdf!.readAsBytesSync();

           base64Attachment = base64Encode(bytes2);
}
catch(error){

}
          
         

   
          controller
              .AddMills(
              new Mills(id: 0, name: name, company: company, activeIngredientId: activeIngredientId, price: num.parse(StaticFuncs.replaceArabicNumber(price)),description: description,descriptionEn: description,image:base64Image,attachment: base64Attachment, nameEn: name, companyEn: company, isDrug: isDrug, userId: UserData.userId,divisionId: categoryId,isFinalOrAddition: selectedType))
              .then((user) {
            if (user != null) {
              btnController.success();
                context.showAlert(
              title:  AppLocalizations.of(context)!.loginAlert,
              message:  AppLocalizations.of(context)!.drugSuccess);
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
          appBar: AppBar(),
          widgetContext: context,
          showBackButton: true,
          showSearch: false,
      ),
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

                        child:  ImagePager(screenname: "milladd"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
                  FB5Col(
                      classNames: 'col-12 mt-5',child: image!=null? Image.file(image!,width: context.screenWidth*.25,height: context.screenWidth*.25 ,):SizedBox()),FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: appDesign.colorPrimary,
                        child:  Text(
                            AppLocalizations.of(context)!.drugsImage,
                            style: TextStyle(
                                color:Colors.white, fontWeight: FontWeight.bold
                            )
                        ),
                        onPressed: () {
                          pickImage();
                        }
                    ),
                  ),),
                    FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( AppLocalizations.of(context)!.millsType,style: TextStyle(   fontSize: 15,
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
                    hint: Text( AppLocalizations.of(context)!.millsType),
                    value: typeList[0],
                    items: typeList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      selectedType = typeList.indexOf(selectedValue!);
                      setState(() {
                        
                      });
                    },
                  ),
                  ),
                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.millsName,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AutoCompleteTextField(
                    labelText: "",
                    obscureText: false,
                    list:  selectedType==1? suggestions.map((item) =>UserData.language=="en"? item.nameEn:item.name).toList():new List.empty(),
                    onChanged: (text) {
                      name = text;
                    },
                  ),),
                    FB5Col(classNames: 'col-12 col-md-3', child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: selectedType==0?SizedBox(): Text(AppLocalizations.of(context)!.drugsActiveIngredient,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child:selectedType==0?SizedBox():  DropdownButtonFormField<MillsActiveIngredient>(
                    isExpanded: true, //Adding this property, does the magic
                    value: dropDownActiveIngredientValue,

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
                    hint:Container(
                      constraints: BoxConstraints(
                          maxWidth: context.screenHeight > 600 ? context.screenWidth * 0.7  : context.screenWidth * 0.5  ),
                      child: Text(

                        "",
                        overflow: TextOverflow.clip,
                        maxLines: 2,

                      ),
                    ),
                    items: activeIngredientsList
                        ?.map<DropdownMenuItem<MillsActiveIngredient>>((MillsActiveIngredient value) {
                      return DropdownMenuItem<MillsActiveIngredient>(
                          value: value,
                          child: SingleChildScrollView(
                            child: Container(
                              // Wrap Text widget with Container
                              constraints: BoxConstraints(
                                  maxWidth: context.screenWidth *
                                      0.7), // Set maximum width for the text
                              child: Container (
                                constraints: BoxConstraints(
                                    maxWidth: context.screenHeight > 600 ? context.screenWidth * 0.7 : context.screenWidth * 0.5  ),
                                child: Text(
                                  UserData.language == "en" ? value.nameEn : value.name,
                                  softWrap: true, // Allow multi-line text
                                ),
                              ),
                            ),
                          ));
                    }).toList(),
                    onChanged: (selectedItem) {
                      activeIngredientId = selectedItem!.id;
                      dropDownActiveIngredientValue = selectedItem!;
              
                    },
                  ),
                  ),

                  
  
                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.drugsDes,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                    onChanged: (text) {
                      description = text;
                    },
                  ),),


                
                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.drugsManufacturerer,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                    onChanged: (text) {
                      company = text;
                    },
                  ),),
     
                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.compassPrice,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                    onChanged: (text) {
                      price = text;
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