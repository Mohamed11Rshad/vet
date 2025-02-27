import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle2.
  ///
  /// In en, this message translates to:
  /// **'Vet Drug Egy'**
  String get appTitle2;

  /// No description provided for @appTitle3.
  ///
  /// In en, this message translates to:
  /// **'Vet Drug Egy'**
  String get appTitle3;

  /// No description provided for @appTitle4.
  ///
  /// In en, this message translates to:
  /// **'Vet Drug Egy'**
  String get appTitle4;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Vet Drug Egy'**
  String get appTitle;

  /// No description provided for @loginUser.
  ///
  /// In en, this message translates to:
  /// **'Phone or username'**
  String get loginUser;

  /// No description provided for @loginPass.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPass;

  /// No description provided for @loginLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginLogin;

  /// No description provided for @loginNew.
  ///
  /// In en, this message translates to:
  /// **'Don`t have an account ? Click here'**
  String get loginNew;

  /// No description provided for @loginAlert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get loginAlert;

  /// No description provided for @loginAlertDetails.
  ///
  /// In en, this message translates to:
  /// **'Please Enter All Required Fields and password more than 8 characters'**
  String get loginAlertDetails;

  /// No description provided for @loginWrongUserOrPass.
  ///
  /// In en, this message translates to:
  /// **'Username or password is wrong'**
  String get loginWrongUserOrPass;

  /// No description provided for @signUpActivateLocation.
  ///
  /// In en, this message translates to:
  /// **'Please activate location services'**
  String get signUpActivateLocation;

  /// No description provided for @signUpLocationDetected.
  ///
  /// In en, this message translates to:
  /// **'Location Detected'**
  String get signUpLocationDetected;

  /// No description provided for @signUpPermissionsLocation.
  ///
  /// In en, this message translates to:
  /// **'Please allow app to access location services'**
  String get signUpPermissionsLocation;

  /// No description provided for @signUpUserExist.
  ///
  /// In en, this message translates to:
  /// **'Company Name or Phone already registered'**
  String get signUpUserExist;

  /// No description provided for @signUpDifferentPass.
  ///
  /// In en, this message translates to:
  /// **'Different typed passwords'**
  String get signUpDifferentPass;

  /// No description provided for @signUpAlertDetails.
  ///
  /// In en, this message translates to:
  /// **'Please enter name ,phone and password more than 8 characters '**
  String get signUpAlertDetails;

  /// No description provided for @signUpFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get signUpFullName;

  /// No description provided for @signUpBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get signUpBusinessName;

  /// No description provided for @signUpBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Business Type'**
  String get signUpBusinessType;

  /// No description provided for @signUpPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get signUpPhone;

  /// No description provided for @signUpPhone2.
  ///
  /// In en, this message translates to:
  /// **'Additional Phone Number'**
  String get signUpPhone2;

  /// No description provided for @signUpEmail.
  ///
  /// In en, this message translates to:
  /// **'E-Mail'**
  String get signUpEmail;

  /// No description provided for @signUpPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signUpPassword;

  /// No description provided for @signUpRepassword.
  ///
  /// In en, this message translates to:
  /// **'Retype Password'**
  String get signUpRepassword;

  /// No description provided for @signUpClickToActivateLocation.
  ///
  /// In en, this message translates to:
  /// **'Click here to detect your location'**
  String get signUpClickToActivateLocation;

  /// No description provided for @signUpSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpSignUp;

  /// No description provided for @signUpNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get signUpNotes;

  /// No description provided for @signUpGovernment.
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get signUpGovernment;

  /// No description provided for @signUpSpeciality.
  ///
  /// In en, this message translates to:
  /// **'Please select specialities'**
  String get signUpSpeciality;

  /// No description provided for @compassSell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get compassSell;

  /// No description provided for @compassBuy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get compassBuy;

  /// No description provided for @compassDate.
  ///
  /// In en, this message translates to:
  /// **'Please select date'**
  String get compassDate;

  /// No description provided for @compassQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get compassQuantity;

  /// No description provided for @compassWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight average'**
  String get compassWeight;

  /// No description provided for @compassPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get compassPrice;

  /// No description provided for @compassView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get compassView;

  /// No description provided for @compassAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get compassAdd;

  /// No description provided for @compassResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Compass is telling you'**
  String get compassResultTitle;

  /// No description provided for @compassResultBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get compassResultBack;

  /// No description provided for @compassResultRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get compassResultRequired;

  /// No description provided for @compassResultOffering.
  ///
  /// In en, this message translates to:
  /// **'Offered'**
  String get compassResultOffering;

  /// No description provided for @drugsControlPanel.
  ///
  /// In en, this message translates to:
  /// **'Control Panel'**
  String get drugsControlPanel;

  /// No description provided for @drugsSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get drugsSearch;

  /// No description provided for @drugsNo.
  ///
  /// In en, this message translates to:
  /// **'No. '**
  String get drugsNo;

  /// No description provided for @drugsSellere.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get drugsSellere;

  /// No description provided for @drugsActiveIngredient.
  ///
  /// In en, this message translates to:
  /// **'Active Ing.'**
  String get drugsActiveIngredient;

  /// No description provided for @drugsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get drugsDelete;

  /// No description provided for @drugsName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get drugsName;

  /// No description provided for @drugsNameAr.
  ///
  /// In en, this message translates to:
  /// **'Arabic Drug Name'**
  String get drugsNameAr;

  /// No description provided for @drugsNameEn.
  ///
  /// In en, this message translates to:
  /// **'English Drug Name'**
  String get drugsNameEn;

  /// No description provided for @drugsDes.
  ///
  /// In en, this message translates to:
  /// **'Product`s Benefits'**
  String get drugsDes;

  /// No description provided for @drugsManufacturerer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get drugsManufacturerer;

  /// No description provided for @drugsCategory.
  ///
  /// In en, this message translates to:
  /// **'Main Category'**
  String get drugsCategory;

  /// No description provided for @drugsSubcategory.
  ///
  /// In en, this message translates to:
  /// **'Subcategory'**
  String get drugsSubcategory;

  /// No description provided for @drugsAttachment.
  ///
  /// In en, this message translates to:
  /// **'Select Attachment'**
  String get drugsAttachment;

  /// No description provided for @drugsFail.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get drugsFail;

  /// No description provided for @drugsImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get drugsImage;

  /// No description provided for @drugsAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get drugsAddress;

  /// No description provided for @drugsGoToLoc.
  ///
  /// In en, this message translates to:
  /// **'Navigate to location'**
  String get drugsGoToLoc;

  /// No description provided for @drugsDownload.
  ///
  /// In en, this message translates to:
  /// **'Download attachment'**
  String get drugsDownload;

  /// No description provided for @drugsYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get drugsYes;

  /// No description provided for @drugsNoNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get drugsNoNo;

  /// No description provided for @drugsDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this ?'**
  String get drugsDeleteConfirm;

  /// No description provided for @drugSuccess.
  ///
  /// In en, this message translates to:
  /// **'Done Successfully'**
  String get drugSuccess;

  /// No description provided for @millsName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get millsName;

  /// No description provided for @millsType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get millsType;

  /// No description provided for @jobTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobTitle;

  /// No description provided for @jobDes.
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get jobDes;

  /// No description provided for @jobAddress.
  ///
  /// In en, this message translates to:
  /// **'Job Address'**
  String get jobAddress;

  /// No description provided for @jobPhone.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get jobPhone;

  /// No description provided for @jobAdvertiser.
  ///
  /// In en, this message translates to:
  /// **'Posted By'**
  String get jobAdvertiser;

  /// No description provided for @onlyNearest.
  ///
  /// In en, this message translates to:
  /// **'Only Nearest'**
  String get onlyNearest;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact us on'**
  String get contactUs;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @deleteaccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteaccount;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp'**
  String get whatsapp;

  /// No description provided for @whatasppalert.
  ///
  /// In en, this message translates to:
  /// **'Whatsapp isn`t installed'**
  String get whatasppalert;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'If you forgot password click here'**
  String get forgetPassword;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @cofirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get cofirm;

  /// No description provided for @newpassword.
  ///
  /// In en, this message translates to:
  /// **'Enter the new password'**
  String get newpassword;

  /// No description provided for @renewpassword.
  ///
  /// In en, this message translates to:
  /// **'Re enter the new password'**
  String get renewpassword;

  /// No description provided for @wrongcode.
  ///
  /// In en, this message translates to:
  /// **'Wrong Code'**
  String get wrongcode;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @codesent.
  ///
  /// In en, this message translates to:
  /// **'Code already sent'**
  String get codesent;

  /// No description provided for @userGuideSearchAlert.
  ///
  /// In en, this message translates to:
  /// **'Please Enter Search Word'**
  String get userGuideSearchAlert;

  /// No description provided for @continueasguest.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueasguest;

  /// No description provided for @jobsGoToLoc.
  ///
  /// In en, this message translates to:
  /// **'Go To Publisher Location'**
  String get jobsGoToLoc;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
