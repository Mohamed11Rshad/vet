import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap5/flutter_bootstrap5.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vetdrugegy/Extensions.dart';
import 'package:vetdrugegy/Views/CompassAddView.dart';
import 'package:vetdrugegy/Views/CourseDetailsView.dart';
import 'package:vetdrugegy/Views/DrugsTypes.dart';
import 'package:vetdrugegy/Views/JobsView.dart';
import 'package:vetdrugegy/Views/NotificationsView.dart';
import 'package:vetdrugegy/Views/Shared/imagePager.dart';
import 'package:vetdrugegy/Views/UsersGuideView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Models/Constants.dart';
import 'LoginView.dart';
import 'Shared/BaseAppBar.dart';
import 'SignUpView.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  int unreadNotificationsCount = 0;
  final List<String> imageUrls = [
    'https://backend.vetdrugegy.com/imgCarousel/1.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/2.jpg',
    'https://backend.vetdrugegy.com/imgCarousel/3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    getUnreadNotificationsCount();
  }

  Future<void> getUnreadNotificationsCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int readNotificationsCount = prefs.getInt('readNotificationsCount') ?? 0;
    List<String> notifications = prefs.getStringList('notifications') ?? [];

    setState(() {
      unreadNotificationsCount = notifications.length - readNotificationsCount;
    });
  }

  openWhatsApp(var context) async {
    var whatsapp = "201559556478";
    var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=");
    try {
      await launchUrl(whatsappAndroid);
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.whatasppalert),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appDesign.backGround,
      appBar: BaseAppBar(
        appBar: AppBar(),
        widgetContext: context,
        showBackButton: false,
        showSearch: false,
        showNotification: true,
        unreadNotificationsCount: unreadNotificationsCount,
        onNotificationPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationsView()))
              .then((value) {
            setState(() {
              getUnreadNotificationsCount();
            });
          });
        },
      ),
      body: SingleChildScrollView(
        child: FB5Row(
          classNames: ' justify-content-center',
          children: [
            FB5Col(
              classNames: 'col-12 mt-5',
              child: Container(
                child: ImagePager(
                  screenname: "",
                ),
                height: context.screenHeight * 0.2,
                width: context.screenWidth,
              ),
            ),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',
              child: Container(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    if (UserData.userId == 0) {
                      context.navigateTo(LoginView());
                    } else {
                      context.navigateTo(CompassAddView());
                    }
                  },
                  child: Card(
                    color: appDesign.colorPrimaryDark,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FB5Row(
                        children: [
                          FB5Col(
                              classNames: 'col-9 align-items-center',
                              child: Container(
                                height: 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              UserData.language == "ar"
                                                  ? "بوصلة الدواجن"
                                                  : "Poultry Compass",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              )),
                          FB5Col(
                              classNames: 'col-3',
                              child: Container(
                                  height: 180,
                                  child: Image.asset("images/1.png")))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',
              child: Container(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    context.navigateTo(DrugsTypes(
                      isDrug: true,
                    ));
                  },
                  child: Card(
                    color: appDesign.colorPrimaryLight,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FB5Row(
                        children: [
                          FB5Col(
                              classNames: 'col-3',
                              child: Container(
                                  height: 180,
                                  child: Image.asset("images/2.png"))),
                          FB5Col(
                              classNames: 'col-9 align-items-center',
                              child: Container(
                                height: 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              UserData.language == "ar"
                                                  ? "الأدوية البيطرية"
                                                  : "Vet Drugs",
                                              style: TextStyle(
                                                  color: appDesign
                                                      .colorPrimaryDark,
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',
              child: Container(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    context.navigateTo(DrugsTypes(
                      isDrug: false,
                    ));
                  },
                  child: Card(
                    color: appDesign.colorPrimaryDark,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FB5Row(
                        children: [
                          FB5Col(
                              classNames: 'col-9 align-items-center',
                              child: Container(
                                height: 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              UserData.language == "ar"
                                                  ? "الأعلاف ومستلزماتها"
                                                  : "Feedmill & Supplies",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              )),
                          FB5Col(
                              classNames: 'col-3',
                              child: Container(
                                  height: 180,
                                  child: Image.asset("images/3.png")))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',
              child: Container(
                height: 200,
                child: GestureDetector(
                  onTap: () => context.navigateTo(UsersGuideView()),
                  child: Card(
                    color: appDesign.colorPrimaryLight,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FB5Row(
                        children: [
                          FB5Col(
                              classNames: 'col-3',
                              child: Container(
                                  height: 180,
                                  child: Image.asset("images/4.png"))),
                          FB5Col(
                              classNames: 'col-9 align-items-center',
                              child: Container(
                                height: 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              UserData.language == "ar"
                                                  ? "دليلك"
                                                  : "Your Guide",
                                              style: TextStyle(
                                                  color: appDesign
                                                      .colorPrimaryDark,
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',
              child: Container(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    context.navigateTo(JobsView());
                  },
                  child: Card(
                    color: appDesign.colorPrimaryDark,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FB5Row(
                        children: [
                          FB5Col(
                              classNames: 'col-9 align-items-center',
                              child: Container(
                                height: 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                              UserData.language == "ar"
                                                  ? "التوظيف"
                                                  : "Employment",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              )),
                          FB5Col(
                              classNames: 'col-3',
                              child: Container(
                                  height: 180,
                                  child: Image.asset("images/5.png"))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FB5Col(
              classNames: 'col-12 col-md-12 mt-5',
              child: Container(
                height: 200,
                child: GestureDetector(
                  onTap: () => context.navigateTo(CourseDetailsView()),
                  child: Card(
                    color: appDesign.colorPrimaryLight,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FB5Row(
                        children: [
                          FB5Col(
                              classNames: 'col-3',
                              child: Container(
                                  height: 180,
                                  child: Image.asset("images/6.png"))),
                          FB5Col(
                              classNames: 'col-9 align-items-center',
                              child: Container(
                                height: 180,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              UserData.language == "ar"
                                                  ? "بودكاست"
                                                  : "Podcast",
                                              style: TextStyle(
                                                  color: appDesign
                                                      .colorPrimaryDark,
                                                  fontSize: 25,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FB5Col(
                classNames: 'col-12',
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 30, 8, 2),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.contactUs +
                          " 01559558632 / 01559556478",
                      style: TextStyle(
                          color: appDesign.colorPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ),
                )),
            FB5Col(
                classNames: 'col-12',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "info@vetdrugegy.com",
                      style: TextStyle(
                          color: appDesign.colorPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ),
                )),
            FB5Col(
                classNames: 'col-12 col-md-12 mt-5',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    color: Color(0xff25D366),
                    child: Text(
                      AppLocalizations.of(context)!.whatsapp,
                      style: TextStyle(
                          color: Color(0xfff6f6f6),
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    onPressed: () => openWhatsApp(context),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
