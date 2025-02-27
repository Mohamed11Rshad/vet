import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Views/HomeView.dart';
import 'package:vetdrugegy/Views/Shared/rounded_loading_button.dart';

import '../Controllers/UserController.dart';
import '../Models/Constants.dart';
import '../Models/User.dart';
import '../Models/UsersAnimals.dart';
import 'Shared/authTextField.dart';
import 'Shared/imagePager.dart';

class SignUpView extends StatefulWidget {
  String? email;
  String? name;

  //constructor
  SignUpView({Key? key}) : super(key: key);

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUpView> {
  final controller = UserController();

  final RoundedLoadingButtonController _signUpBtnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnDetectLocation =
      RoundedLoadingButtonController();
  var isLoading = false;
  String name = "";
  String companyname = "";
  String phone = "";
  String phone2 = "";
  String password = "";
  String password2 = "";
  String email = "";
  String notes = "";
  bool isDetected = false;

  var number;
  int selectedGoverment = 0;
  int selectedJobType = 0;
  var govermentsList = <String>[
    UserData.language == "ar" ? "الإسكندرية" : "Alex",
    UserData.language == "ar" ? "الإسماعيلية" : "Ismailia",
    UserData.language == "ar" ? "أسوان" : "Aswan",
    UserData.language == "ar" ? "أسيوط" : "Assiut",
    UserData.language == "ar" ? "الأقصر" : "Luxor",
    UserData.language == "ar" ? "البحر الأحمر" : "Red Sea",
    UserData.language == "ar" ? "البحيرة" : "Behira",
    UserData.language == "ar" ? "بني سويف" : "Beni Suef",
    UserData.language == "ar" ? "بورسعيد" : "Portsaid",
    UserData.language == "ar" ? "جنوب سيناء" : "South Sinai",
    UserData.language == "ar" ? "الجيزة" : "Giza",
    UserData.language == "ar" ? "الدقهلية" : "Dakahlia",
    UserData.language == "ar" ? "دمياط" : "Damietta",
    UserData.language == "ar" ? "سوهاج" : "Sohag",
    UserData.language == "ar" ? "السويس" : "Suez",
    UserData.language == "ar" ? "الشرقية" : "Sharqia",
    UserData.language == "ar" ? "شمال سيناء" : "North Sinai",
    UserData.language == "ar" ? "الغربية" : "Gharbia",
    UserData.language == "ar" ? "الفيوم" : "Fayyoum",
    UserData.language == "ar" ? "القاهرة" : "Cairo",
    UserData.language == "ar" ? "القليوبية" : "Qaliobia",
    UserData.language == "ar" ? "قنا" : "Qena",
    UserData.language == "ar" ? "كفر الشيخ" : "Kafr Elsheikh",
    UserData.language == "ar" ? "مطروح" : "Matrouh",
    UserData.language == "ar" ? "المنوفية" : "Menoufia",
    UserData.language == "ar" ? "المنيا" : "Alminia",
    UserData.language == "ar" ? "الوادي الجديد" : "New Valley",
  ];

  var jobTypes = <String>[
    UserData.language == "ar" ? "مربي" : "Breeder",
    UserData.language == "ar" ? "مصنع علف" : "Feed Mills Factory",
    UserData.language == "ar" ? "مكتب بيطري" : "Vet Pharmacy",
    UserData.language == "ar" ? "شركة أدوية" : "Vet Drug Company",
    UserData.language == "ar" ? "طبيب بيطري" : "Veternarian",
    UserData.language == "ar" ? "معمل بيطري" : "Vet Lab",
    UserData.language == "ar" ? "مجزر دواجن" : "Polutry Slaughterhouse",
    UserData.language == "ar" ? "محل دواجن" : "Polutry Shop",
    UserData.language == "ar" ? "فندق" : "Hotel",
    UserData.language == "ar" ? "هايبر ماركت" : "Market",
    UserData.language == "ar" ? "مستودع بيع وشراء بيض" : "Eggs Shop",
    UserData.language == "ar" ? "مطاعم" : "Restaurants",
    UserData.language == "ar" ? "أخرى" : "Other",
  ];

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

  var selectedBreederIndexes = [];
  String? _currentAddress;
  Position? _currentPosition;
  @override
  void initState() {
    _signUpBtnController.start();
    super.initState();
    _handleLocationPermission();
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        btnDetectLocation.reset();
        _currentAddress =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        print(_currentAddress);
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getCurrentPosition(
      RoundedLoadingButtonController btnController) async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      return;
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print(position);
      this.isDetected = true;

      _currentPosition = position;
      _getAddressFromLatLng(position);

      print(_currentPosition);
      setState(() => {});
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getCurrentPositionForWeb(
      RoundedLoadingButtonController btnController) async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      print(position);
      this.isDetected = true;

      _currentPosition = position;
      print(_currentPosition);
      btnController.reset();
      setState(() => {});
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.signUpActivateLocation)));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text(AppLocalizations.of(context)!.signUpPermissionsLocation)));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text(AppLocalizations.of(context)!.signUpPermissionsLocation)));
      return false;
    }
    return true;
  }

  void signUpValidation(RoundedLoadingButtonController btnController) {
    List<UsersAnimals> animals = [];
    for (int i = 0; i < selectedBreederIndexes.length; i++) {
      UsersAnimals animal = new UsersAnimals(
          animalType: selectedBreederIndexes[i], id: 0, userId: 0);
      animals.add(animal);
    }

    if (name.length > 0 && phone.length > 0 && password.length > 7) {
      if (_currentPosition != null || _currentAddress != null) {
        if (password == password2) {
          controller.SignUp(
                  new User(
                      id: 0,
                      name: name,
                      companyName: companyname,
                      activityType: selectedJobType,
                      government: selectedGoverment,
                      phone1: phone,
                      phone2: phone2,
                      email: email,
                      password: password,
                      isActive: true,
                      registerationDate: '2023-09-27',
                      lastLoginDate: '2023-09-27',
                      locationX: _currentPosition!.latitude,
                      locationY: _currentPosition!.longitude,
                      address: _currentAddress!,
                      notest: notes,
                      nameEn: name),
                  animals)
              .then((user) async {
            if (user != null) {
              btnController.success();
              //context.saveUser(user);
              Future.delayed(Duration(seconds: 2));
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt("UserID", user.id);
              prefs.setString("UserName", user.name);
              prefs.setInt("Government", user.government);
              UserData.userId = user.id;
              UserData.userName = user.name;
              UserData.government = user.government;
              context.navigateFromSplash(HomeView());
              //context.navigateTo(bottom app bar);
            } else {
              btnController.error();
              context.showAlert(
                  title: AppLocalizations.of(context)!.loginAlert,
                  message: AppLocalizations.of(context)!.signUpUserExist);
              btnController.reset();
            }
          });
        } else {
          btnController.error();
          context.showAlert(
              title: AppLocalizations.of(context)!.loginAlert,
              message: AppLocalizations.of(context)!.signUpDifferentPass);

          Future.delayed(Duration(seconds: 2), () {
            btnController.reset();
          });
        }
      } else {
        btnController.error();
        context.showAlert(
            title: AppLocalizations.of(context)!.loginAlert,
            message: AppLocalizations.of(context)!.signUpActivateLocation);

        Future.delayed(Duration(seconds: 2), () {
          btnController.reset();
        });
      }
    } else {
      btnController.error();
      context.showAlert(
          title: AppLocalizations.of(context)!.loginAlert,
          message: AppLocalizations.of(context)!.signUpAlertDetails);

      Future.delayed(Duration(seconds: 2), () {
        btnController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appDesign.backGround,
      body: SingleChildScrollView(
        child: Padding(
          // add space for all padding container
          padding: EdgeInsets.all(context.screenWidth * 0.0),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: FB5Row(
                children: [
                  FB5Col(
                    classNames: 'col-1 col-md-3',
                  ),
                  FB5Col(
                    classNames: 'col-10 col-md-6',
                    child: FB5Row(
                      classNames: ' justify-content-center',
                      children: [
                        FB5Col(
                          classNames: 'col-12',
                          child: Container(
                            child: ImagePager(screenname: "signup"),
                            height: context.screenHeight * 0.2,
                            width: context.screenWidth,
                          ),
                        ),
                        FB5Col(
                            classNames: 'col-12 mt-5',
                            child: Image.asset(
                              'images/applogo.png',
                              width: context.screenWidth * .25,
                              height: context.screenWidth * .25,
                            )),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpFullName,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText:
                                AppLocalizations.of(context)!.signUpFullName,
                            obscureText: false,
                            onChanged: (text) {
                              name = text;
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpBusinessName,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText: AppLocalizations.of(context)!
                                .signUpBusinessName,
                            obscureText: false,
                            onChanged: (text) {
                              companyname = text;
                            },
                          ),
                        ),

                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpBusinessType,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 20, 0),
                              focusColor: appDesign.colorPrimary,
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[350],
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide:
                                    BorderSide(color: appDesign.colorPrimary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(
                                    color: appDesign
                                        .colorPrimary), // Set the focused border color
                              ),
                            ),
                            hint: Text(AppLocalizations.of(context)!
                                .signUpBusinessType),
                            value: jobTypes[0],
                            items: jobTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (selectedValue) {
                              selectedJobType =
                                  jobTypes.indexOf(selectedValue!);
                              setState(() {});
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpGovernment,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 20, 20, 0),
                              focusColor: appDesign.colorPrimary,
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[350],
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide:
                                    BorderSide(color: appDesign.colorPrimary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide: BorderSide(
                                    color: appDesign
                                        .colorPrimary), // Set the focused border color
                              ),
                            ),
                            hint: Text(
                                AppLocalizations.of(context)!.signUpGovernment),
                            value: govermentsList[0],
                            items: govermentsList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (selectedValue) {
                              selectedGoverment =
                                  govermentsList.indexOf(selectedValue!);
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpPhone,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText: "xxx.xxxxxxxx",
                            obscureText: false,
                            onChanged: (text) {
                              phone = text;
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpPhone2,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText: "xxx.xxxxxxxx",
                            obscureText: false,
                            onChanged: (text) {
                              phone2 = text;
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpEmail,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText: "example@gmail.com",
                            obscureText: false,
                            onChanged: (text) {
                              email = text;
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpPassword,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText:
                                AppLocalizations.of(context)!.signUpRepassword,
                            obscureText: false,
                            onChanged: (text) {
                              password = text;
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpRepassword,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText:
                                AppLocalizations.of(context)!.signUpRepassword,
                            obscureText: false,
                            onChanged: (text) {
                              password2 = text;
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpNotes,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText:
                                AppLocalizations.of(context)!.signUpNotes,
                            obscureText: false,
                            onChanged: (text) {
                              notes = text;
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-3',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.drugsAddress,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: 'col-12 col-md-9 mb-4',
                          child: AuthTextField(
                            labelText:
                                AppLocalizations.of(context)!.drugsAddress,
                            obscureText: false,
                            initialValue: _currentAddress,
                            onChanged: (text) {
                              _currentAddress = text;
                            },
                          ),
                        ),
                        FB5Col(
                          classNames: selectedJobType > -1
                              ? 'col-12 col-md-12'
                              : 'd-none',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.signUpSpeciality,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        FB5Col(
                          classNames: selectedJobType > -1
                              ? 'col-12 col-md-12'
                              : 'd-none',
                          child: Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: breederSpecialities.length,
                              itemBuilder: (_, int index) {
                                return Card(
                                  color: Colors.white,
                                  elevation: 2.0,
                                  child: CheckboxListTile(
                                    checkColor: appDesign.colorPrimary,
                                    activeColor: Colors.transparent,
                                    title: Text(breederSpecialities[index]),
                                    value:
                                        selectedBreederIndexes.contains(index),
                                    onChanged: (_) {
                                      setState(() {
                                        if (selectedBreederIndexes
                                            .contains(index)) {
                                          selectedBreederIndexes
                                              .remove(index); // unselect
                                        } else {
                                          selectedBreederIndexes
                                              .add(index); // select
                                        }
                                        print(selectedBreederIndexes
                                            .contains(index));
                                        print(index);
                                        print(selectedBreederIndexes.length);
                                      });
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        FB5Col(
                            classNames: 'col-12 ',
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RoundedLoadingButton(
                                controller: btnDetectLocation,
                                color: appDesign.colorPrimary,
                                successIcon: Icons.cloud,
                                failedIcon: Icons.error,
                                child: Text(
                                  isDetected
                                      ? AppLocalizations.of(context)!
                                          .signUpLocationDetected
                                      : AppLocalizations.of(context)!
                                          .signUpClickToActivateLocation,
                                  style: TextStyle(
                                      color: Color(0xfff6f6f6),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                onPressed: () => kIsWeb
                                    ? _getCurrentPositionForWeb(
                                        btnDetectLocation)
                                    : _getCurrentPosition(btnDetectLocation),
                              ),
                            )),

                        FB5Col(
                            classNames: 'col-12',
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RoundedLoadingButton(
                                controller: _signUpBtnController,
                                color: appDesign.colorPrimary,
                                successIcon: Icons.cloud,
                                failedIcon: Icons.error,
                                child: Text(
                                  AppLocalizations.of(context)!.signUpSignUp,
                                  style: TextStyle(
                                      color: Color(0xfff6f6f6),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                onPressed: () =>
                                    signUpValidation(_signUpBtnController),
                              ),
                            ))

                        // SizedBox(height: context.screenHeight * 0.025),

                        //SizedBox(height: context.screenHeight * 0.02),

                        //SizedBox(height: context.screenHeight * 0.01),

                        //SizedBox(height: 30),
                      ],
                    ),
                  ),
                  FB5Col(
                    classNames: 'col-1 col-md-3',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
