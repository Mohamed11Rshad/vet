import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vetdrugegy/Models/Constants.dart';


class LanguageProvider extends ChangeNotifier {
  Locale _appLocale = Locale("ar");
  // Default language is English
  Locale get appLocale => _appLocale;
  Future<void> initLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString("lang") ?? "ar";
    UserData.language = lang;
    _appLocale = Locale(lang);
    notifyListeners();
  }

  void changeLanguage(Locale newLocale) {
    print("Proiver called ******* $newLocale");
    UserData.language = newLocale.toString();
    if (_appLocale != newLocale) {
      _appLocale = newLocale;
      notifyListeners();
    }
  }
}