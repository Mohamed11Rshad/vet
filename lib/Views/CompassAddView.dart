import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Controllers/CompassController.dart';
import 'package:vetdrugegy/Controllers/UserController.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Models/User.dart';
import 'package:vetdrugegy/Models/UsersAnimals.dart';
import 'package:vetdrugegy/Views/CompassResultView.dart';
import 'package:vetdrugegy/Views/HomeView.dart';
import 'package:vetdrugegy/Views/Shared/BaseAppBar.dart';
import 'package:vetdrugegy/Views/Shared/imagePager.dart';

import '../Models/Compass.dart';
import '../Models/Constants.dart';
import 'LoginView.dart';
import 'Shared/authTextField.dart';
import 'Shared/rounded_loading_button.dart';
import 'SignUpView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompassAddView extends StatefulWidget {
  const CompassAddView({Key? key}) : super(key: key);

  @override
  State<CompassAddView> createState() => CompassAddViewState();
}

class CompassAddViewState extends State<CompassAddView> {
  final controller = CompassController();
  final userController = UserController();

  var compassAddDirections = <String>[];
  int direction = 0;
  String selectedCompassDirection = "";
  TextEditingController dateInput = TextEditingController();
  late List<UsersAnimals>? animals = [];
  final RoundedLoadingButtonController btnAddToCompass =
      RoundedLoadingButtonController();

  final RoundedLoadingButtonController btnShowCompass =
      RoundedLoadingButtonController();
  var breederSpecialities = <String>[
    UserData.language == "ar" ? "تسمين أبيض" : "White Broiler",
    UserData.language == "ar" ? "تسمين ساسو" : "Saso Brolier",
    UserData.language == "ar" ? "تسمين بط" : "Duck",
    UserData.language == "ar" ? "نعام" : "Ostriches",
    UserData.language == "ar" ? "بياض أبيض" : "Laying White Hens",
    UserData.language == "ar" ? "بياض أحمر" : "Laying Red Hens",
    UserData.language == "ar" ? "أمهات أبيض" : "White Breeder",
    UserData.language == "ar" ? "أمهات ساسو" : "Saso Breeder",
    UserData.language == "ar" ? "بلدي دواجن" : "Native Brolier",
    UserData.language == "ar" ? "أمهات بلدي" : "Native Breeder",
    UserData.language == "ar" ? "أمهات بياض" : "Laying Breeder",
    UserData.language == "ar" ? "جدود الدواجن" : "Grand Parents",
    UserData.language == "ar" ? "أمهات بط" : "Duck Breeder",
    UserData.language == "ar" ? "تسمين دورزي" : "Dorzi",
    UserData.language == "ar" ? "أرانب" : "Rabbits",
    UserData.language == "ar" ? "حمام" : "Pigeons",
    UserData.language == "ar" ? "سمان" : "Quails",
    UserData.language == "ar" ? "أسماك" : "Fish",
    UserData.language == "ar" ? "مجترة" : "Large",
    UserData.language == "ar" ? "أليفة" : "Pets",
    UserData.language == "ar" ? "كتكوت أبيض تسمين" : "Brolier White Chicken",
    UserData.language == "ar" ? "كتكوت ساسو" : "Saso Chicken",
    UserData.language == "ar" ? "كتكوت بلدي حر" : "Native Chicken",
    UserData.language == "ar" ? "بيض مائدة أبيض" : "Commercial White Egg",
    UserData.language == "ar" ? "بيض مائدة أحمر" : "Commercial Red Egg",
    UserData.language == "ar" ? "بيض مائدة بلدي" : "Commercial Native Egg",
    UserData.language == "ar" ? "بيض تفريخ تسمين أبيض" : "Fertile Broiler Egg",
    UserData.language == "ar" ? "بيض تفريخ ساسو" : "Fertile Saso Egg",
    UserData.language == "ar" ? "بيض تفريخ بلدي" : "Fertile Native Egg"
  ];

  var compasses = <Compass>[];
  @override
  void initState() {
    super.initState();
    getUsersAnimals();
    compassAddDirections.add(UserData.language == "ar" ? "بيع" : "Sell");
    compassAddDirections.add(UserData.language == "ar" ? "شراء" : "Buy");
    selectedCompassDirection = compassAddDirections[0];

    print(compassAddDirections.length);
    setState(() {});
  }

  void getUsersAnimals() async {
    animals = (await userController.GetAnimalsByUser(UserData.userId));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          for (int i = 0; i < animals!.length; i++) {
            compasses.add(new Compass(
                id: 0,
                userId: UserData.userId,
                animalType: animals![i].animalType,
                direction: 0,
                price: 0,
                quantity: 0,
                weight: 0,
                entryDate: "2023-20-20"));
          }
        }));
  }

  void signUpValidation(RoundedLoadingButtonController btnController) {
    btnController.reset();
    context.navigateTo(CompassResultView(
      entryDate: dateInput.text,
    ));
  }

  Future<void> addToCompass(
      RoundedLoadingButtonController btnController) async {
    print('compasseslength');
    print(compasses.length);
    for (int i = 0; i < compasses.length; i++) {
      if (compasses[i].quantity! > 0) {
        compasses[i].entryDate = dateInput.text;
        compasses[i].direction = direction;
        if (compasses[i].direction == 1) {
          compasses[i].price = 0;
        }
        await Future.delayed(const Duration(seconds: 1))
            .then((value) => setState(() {
                  controller.AddCompass(compasses[i]);
                }));
      }
    }
    btnController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appDesign.backGround,
      appBar: BaseAppBar(
        appBar: AppBar(),
        widgetContext: context,
        showBackButton: true,
        showSearch: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: FB5Row(
            classNames: ' justify-content-center',
            children: [
              FB5Col(
                classNames: 'col-12  mt-5',
                child: Container(
                  child: ImagePager(screenname: "compassadd"),
                  height: context.screenHeight * 0.2,
                  width: context.screenWidth,
                ),
              ),
              FB5Col(
                classNames: 'col-12 col-md-6 mt-5',
                child: DropdownButtonFormField<String>(
                  value: selectedCompassDirection,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    focusColor: appDesign.colorPrimary,
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
                      borderSide: BorderSide(
                          color: appDesign
                              .colorPrimary), // Set the focused border color
                    ),
                  ),
                  hint: Text(AppLocalizations.of(context)!.compassDate),
                  items: compassAddDirections.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    selectedCompassDirection = selectedValue!;
                    direction = compassAddDirections.indexOf(selectedValue!);
                    setState(() {});
                  },
                ),
              ),
              FB5Col(
                  classNames: 'col-12 col-md-6 mt-5',
                  child: Center(
                      child: TextField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        focusColor: appDesign.colorPrimary,
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
                          borderSide: BorderSide(
                              color: appDesign
                                  .colorPrimary), // Set the focused border color
                        ),
                        labelText: AppLocalizations.of(context)!
                            .compassDate //label text of field
                        ),
                    controller: dateInput,
                    //editing controller of this TextField

                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ))),
              FB5Col(
                classNames: 'col-12',
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: animals!.length,
                    itemBuilder: (_, int index) {
                      return Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                          child: FB5Row(
                            children: [
                              FB5Col(
                                classNames: 'col-12',
                                child: Text(
                                  UserData.language == "ar"
                                      ? Constants
                                          .animals[animals![index]!.animalType!]
                                          .name!
                                      : Constants
                                          .animalsEn[
                                              animals![index]!.animalType!]
                                          .name!,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              FB5Col(
                                  classNames: 'col-6',
                                  child: FB5Row(
                                    children: [
                                      FB5Col(
                                        classNames: 'col-4',
                                        child: Container(
                                          height: 100,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .compassQuantity,
                                                  style:
                                                      TextStyle(fontSize: 13)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FB5Col(
                                        classNames: 'col-6',
                                        child: Container(
                                          height: 100,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: AuthTextField(
                                                labelText: "",
                                                obscureText: false,
                                                onChanged: (text) {
                                                  compasses[index].quantity =
                                                      int.parse(StaticFuncs
                                                          .replaceArabicNumber(
                                                              text));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FB5Col(
                                        classNames: 'col-2',
                                      )
                                    ],
                                  )),
                              FB5Col(
                                  classNames: 'col-6',
                                  child: FB5Row(
                                    children: [
                                      FB5Col(
                                        classNames: 'col-6',
                                        child: Container(
                                          height: 100,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .compassWeight,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FB5Col(
                                        classNames: 'col-6',
                                        child: Container(
                                          height: 100,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: AuthTextField(
                                                labelText: "",
                                                obscureText: false,
                                                onChanged: (text) {
                                                  compasses[index].weight =
                                                      num.parse(StaticFuncs
                                                          .replaceArabicNumber(
                                                              text));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                              FB5Col(
                                  classNames:
                                      direction == 0 ? 'col-6' : 'd-none',
                                  child: FB5Row(
                                    children: [
                                      FB5Col(
                                        classNames: 'col-4',
                                        child: Container(
                                          height: 60,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .compassPrice,
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FB5Col(
                                        classNames: 'col-6',
                                        child: Container(
                                          height: 60,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: AuthTextField(
                                                labelText: "",
                                                obscureText: false,
                                                onChanged: (text) {
                                                  compasses[index].price =
                                                      num.parse(StaticFuncs
                                                          .replaceArabicNumber(
                                                              text));
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      FB5Col(classNames: 'col-2')
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              FB5Col(
                  classNames: 'col-6 col-md-6 mt-5',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedLoadingButton(
                      controller: btnAddToCompass,
                      color: appDesign.colorPrimary,
                      successIcon: Icons.cloud,
                      failedIcon: Icons.error,
                      child: Text(
                        AppLocalizations.of(context)!.compassAdd,
                        style: TextStyle(
                            color: Color(0xfff6f6f6),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      onPressed: () => addToCompass(btnAddToCompass),
                    ),
                  )),
              FB5Col(
                  classNames: 'col-6 col-md-6 mt-5',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedLoadingButton(
                      controller: btnShowCompass,
                      color: appDesign.colorPrimary,
                      successIcon: Icons.cloud,
                      failedIcon: Icons.error,
                      child: Text(
                        AppLocalizations.of(context)!.compassView,
                        style: TextStyle(
                            color: Color(0xfff6f6f6),
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      onPressed: () => signUpValidation(btnShowCompass),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
