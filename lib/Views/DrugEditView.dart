





import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import 'package:vetdrugegy/Views/Shared/BaseAppBar.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';
import '../Models/Constants.dart';
import '../Controllers/UserController.dart';
import '../Models/Drugs.dart';
import '../Models/User.dart';
import '../Models/UsersAnimals.dart';
import 'LoginView.dart';
import 'Shared/authTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'Shared/autoCompleteTextField.dart';
import 'Shared/imagePager.dart';

class DrugEditView extends StatefulWidget {
  Drugs drug;

  //constructor
  DrugEditView({Key? key,required this.drug}) : super(key: key);

  @override
  DrugEdit createState() => DrugEdit();
}

class DrugEdit extends State<DrugEditView> {
  final controller = DrugsController();

  final RoundedLoadingButtonController _signUpBtnController =
  RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnDetectLocation =
  RoundedLoadingButtonController();
  var isLoading = false;
  String name="";
  String nameEn="";
  String price="";
  String description="";
  String company="";
  var number;
  int selectedGoverment = 0;
  int selectedActiveIngrdient = 0;
  File? image;
  File? pdf;

  int categoryId=0;
  bool isDrug=true;
  List<String> activeIngredientsArr = [];
  int activeIngredientId=1;
  DrugsCategories? dropdownCategoryValue = null;
  DrugsCategories? dropdownCategoryValueMain = null;
  DrugsActiveIngredients? dropDownActiveIngredientValue = null;

  late List<DrugsCategories>? categoriesList = [];
  late List<DrugsCategories>? subCategoriesList = [];
  List<DrugsActiveIngredients> activeIngredientsList = [];
    List<Drugs> suggestions = [];

  int drugcategoryId = 1;
  int drugsubCategoryId = 1;
  

  var selectedBreederIndexes = [];

    var nameController = TextEditingController();
    var nameEnController = TextEditingController();
    var priceController = TextEditingController();
    var descriptionController = TextEditingController();
    var companyController = TextEditingController();

  @override
  void initState() {
  
    _signUpBtnController.start();
    super.initState();
    loadSuggestions();
    getCategoriesInitiali(0);
    getDrug();

 
   // 
  }
  void getCategories(int categoryId) async {
    if (categoryId == 0) {
      categoriesList = (await DrugsController().GetCategoriesByParentId(categoryId));
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));
    } else {
      subCategoriesList?.clear();
      subCategoriesList =
          (await DrugsController().GetCategoriesByParentId(categoryId));
    
      print("loaded");
      print(subCategoriesList);
      setState(() {
        dropdownCategoryValue = subCategoriesList![0];
        drugsubCategoryId = subCategoriesList![0].id;
// remeber this value must be same as initial value of 2nd dropdown =>value: 'Initial Value of second',
      });
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));
    }
  }


  void getDrug(){
    nameController.text=widget.drug.name;
    nameEnController.text=widget.drug.nameEn;
    companyController.text=widget.drug.company;
    descriptionController.text=widget.drug.description;
    priceController.text=widget.drug.price.toString();

        print("herex"+nameController.text);

    nameEn=widget.drug.nameEn;
    company=widget.drug.company;
    description=widget.drug.description;
    description=widget.drug.description;
    categoryId=widget.drug.divisionId;
    
price=widget.drug.price.toString();
  drugcategoryId=widget.drug.activeIngredient!.category!.parentId;
  drugsubCategoryId=widget.drug.activeIngredient!.categoryId;
  activeIngredientId=widget.drug.activeIngredientId;
       

  }

  
  Future<void> getCategoriesInitiali(int categoryId) async {
     if (categoryId == 0) {
      categoriesList = (await DrugsController().GetCategoriesByParentId(categoryId));
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {
            dropdownCategoryValueMain=categoriesList!
    .where((element) => element.id == drugcategoryId)
    .toList()[0];
    getSubCategoriesInitiali(drugcategoryId);
          }));
    } 
  }

  Future<void> getSubCategoriesInitiali(int categoryIdx) async {
    if (categoryIdx > 0) {
      subCategoriesList =
          (await DrugsController().GetCategoriesByParentId(categoryIdx));
      print("loaded"+categoryIdx.toString());
      print(subCategoriesList);
                  dropdownCategoryValue=subCategoriesList!
    .where((element) => element.id == drugsubCategoryId)
    .toList()[0];
         activeIngredientsList.clear();
      activeIngredientsList =(await ( DrugsController().GetActiveIngredients(drugsubCategoryId,categoryId))!)!;
      setState(()  {
                      dropDownActiveIngredientValue=activeIngredientsList!
    .where((element) => element.id == activeIngredientId)
    .toList()[0];

// remeber this value must be same as initial value of 2nd dropdown =>value: 'Initial Value of second',
      });
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));
    } else {
      subCategoriesList?.clear();
      setState(() {});
    }
  }

   void getSubCategories(int categoryIdx) async {
    if (categoryIdx > 0) {
      subCategoriesList =
          (await DrugsController().GetCategoriesByParentId(categoryIdx));
      print("loaded");
      print(subCategoriesList);
        dropdownCategoryValue = subCategoriesList![0];
        drugsubCategoryId = subCategoriesList![0].id;
              print("subcat"+subCategoriesList![0].name);
activeIngredientId=-1;
dropDownActiveIngredientValue=null;
         activeIngredientsList.clear();
      activeIngredientsList =(await ( DrugsController().GetActiveIngredients(drugsubCategoryId,categoryId))!)!;
      setState(()  {
      

// remeber this value must be same as initial value of 2nd dropdown =>value: 'Initial Value of second',
      });
      Future.delayed(const Duration(seconds: 1))
          .then((value) => setState(() {}));
    } else {
      subCategoriesList?.clear();
      setState(() {});
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
    List<DrugsActiveIngredients>? cities = await controller.GetActiveIngredients(parentId,categoryId);
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

    Future<void> loadSuggestions() async {
    List<Drugs>? cities = await controller.GetDrugsSuggestions(categoryId);
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
              .EditDrug(
              new Drugs(id: widget.drug.id,nameEn:nameEnController.text, name: nameController.text, company: companyController.text, activeIngredientId: activeIngredientId, price: num.parse(StaticFuncs.replaceArabicNumber(priceController.text)),description: descriptionController.text,descriptionEn:  descriptionController.text,image:base64Image,attachment: base64Attachment, companyEn: companyController.text  , isDrug: widget.drug.isDrug, userId: UserData.userId,divisionId: widget.drug.divisionId))
              .then((user) {
            if (user != null) {
              btnController.success();
                context.showAlert(
              title:  AppLocalizations.of(context)!.loginAlert,
              message:  AppLocalizations.of(context)!.drugSuccess);
                Navigator.pop(context);

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

                        child:  ImagePager(screenname: "drugedit"),
                        height:  context.screenHeight * 0.2,
                        width: context.screenWidth,
                      ),),
                  FB5Col(
                      classNames: 'col-12 col-md-6 mt-5',child: kIsWeb? (image!=null? Image.network(image!.path,width: 512,height: 512 ,):SizedBox()):  (image!=null? Image.file(image!,width: context.screenWidth*.25,height: context.screenWidth*.25 ,):SizedBox())),FB5Col(classNames: 'col-12 col-md-6', child: Padding(
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
                    child: Text(AppLocalizations.of(context)!.drugsNameAr,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AutoCompleteTextField(
                    labelText: "",
                    obscureText: false,
                    controller: nameController,
                    initialValue: nameController.text,
                    list:     suggestions.map((item) =>item.name).toList() ,
                    onChanged: (text) {
                      name = text;
                    },
                  ),),

                      FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.drugsNameEn,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AutoCompleteTextField(
                    labelText: "",
                    obscureText: false,
                             controller: nameEnController,
                    initialValue: nameEnController.text,
                    list:     suggestions.map((item) => item.nameEn).toList() ,
                    onChanged: (text) {
                      nameEn = text;
                    },
                  ),),
                  

                   FB5Col(classNames: 'col-12 col-md-3', child: isDrug? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.drugsCategory,style: TextStyle(   fontSize: 15,
                    ),),
                  ):SizedBox(),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: isDrug? DropdownButtonFormField<DrugsCategories>(
           
                    isExpanded: true, //Adding this property, does the magic
                    value: dropdownCategoryValueMain,

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
                    hint: Text(""),
                    items: categoriesList
                        ?.map<DropdownMenuItem<DrugsCategories>>((DrugsCategories value) {
                      return DropdownMenuItem<DrugsCategories>(
                        value: value,
                        child: new Text( UserData.language == "en" ? value.nameEn : value.name),
                      );
                    }).toList(),
                    onChanged: (valueSelected) {
                      drugcategoryId = valueSelected!.id;
                      dropdownCategoryValueMain = valueSelected!;

                      getSubCategories(valueSelected!.id);
                    },
                  ):SizedBox(),
                ),
                 

 FB5Col(classNames: 'col-12 col-md-3', child: isDrug?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.drugsSubcategory,style: TextStyle(   fontSize: 15,
                    ),),
                  ):SizedBox(),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child:isDrug? DropdownButtonFormField<DrugsCategories>(
                    isExpanded: true, //Adding this property, does the magic
                    value: dropdownCategoryValue,

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
                    items: subCategoriesList
                        ?.map<DropdownMenuItem<DrugsCategories>>((DrugsCategories value) {
                      return DropdownMenuItem<DrugsCategories>(
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
                      drugsubCategoryId = selectedItem!.id;
                      dropdownCategoryValue = selectedItem!;
                      loadActiveIngredient( selectedItem!.id);
                    },
                  ):SizedBox(height: 1,),
                  ),

                  FB5Col(classNames: 'col-12 col-md-3', child:isDrug? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.drugsActiveIngredient,style: TextStyle(   fontSize: 15,
                    ),),
                  ):SizedBox(),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child:isDrug? DropdownButtonFormField<DrugsActiveIngredients>(
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
                        ?.map<DropdownMenuItem<DrugsActiveIngredients>>((DrugsActiveIngredients value) {
                      return DropdownMenuItem<DrugsActiveIngredients>(
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
                  ):SizedBox(),
                  ),
                 


              
    FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.compassPrice,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                             controller: priceController,
                    initialValue: priceController.text,
                    onChanged: (text) {
                      price = text;
                    },
                  ),),
                  FB5Col(classNames: 'col-12 col-md-3', child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(AppLocalizations.of(context)!.drugsDes,style: TextStyle(   fontSize: 15,
                    ),),
                  ),),
                  FB5Col( classNames: 'col-12 col-md-9 mb-4', child: AuthTextField(
                    labelText: "",
                    obscureText: false,
                             controller: descriptionController,
                    initialValue: descriptionController.text,
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
                             controller: companyController,
                    initialValue: companyController.text,
                    onChanged: (text) {
                      company = text;
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
                       AppLocalizations.of(context)!.edit,
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