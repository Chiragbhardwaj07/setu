import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionController extends GetxController {
  var selectedLanguage = 'en_US'.obs; // Default to English (US)

  Map<String, String> _languageCodes = {
    'en_US': 'English',
    'hi_IN': 'हिन्दी',
    'pa_IN': 'ਪੰਜਾਬੀ',
    'mr_IN': 'मराठी',
    'te_IN': 'తెలుగు',
    'bn_IN': 'বাংলা',
    'ta_IN': 'தமிழ்',
    'ur_PK': 'اردو',
    'gu_IN': 'ગુજરાતી',
    'kn_IN': 'ಕನ್ನಡ',
    'ml_IN': 'മലയാളം',
  };

  // Expose a list of languages for the dropdown
  List<Map<String, String>> get languages =>
      _languageCodes.entries.map((entry) {
        return {entry.value: entry.key};
      }).toList();

  void setSelectedLanguage(String languageCode) async {
    var localeParts = languageCode.split('_');
    if (localeParts.length == 2) {
      Get.updateLocale(Locale(localeParts[0], localeParts[1]));
    } else {
      Get.updateLocale(Locale(localeParts[0]));
    }

    selectedLanguage.value = languageCode;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
  }

  void proceedToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('introShown', true);
    debugPrint('Selected Language: ${_languageCodes[selectedLanguage.value]}');
    Get.toNamed('/login');
  }

  Future<void> loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selectedLanguage');

    if (savedLanguage != null) {
      selectedLanguage.value = savedLanguage;
      updateLocale(savedLanguage);
    }
  }

  void updateLocale(String languageCode) {
    var locale = _getLocaleFromLanguageCode(languageCode);
    Get.updateLocale(locale);
  }

  Locale getLocale() {
    return _getLocaleFromLanguageCode(selectedLanguage.value);
  }

  Locale _getLocaleFromLanguageCode(String languageCode) {
    var localeParts = languageCode.split('_');
    return Locale(localeParts[0], localeParts[1]);
  }
}
