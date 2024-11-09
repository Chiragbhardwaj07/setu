import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vasu/app/localization/app_translations.dart'; // Your app's translations for GetX
import 'package:vasu/app/routes/app_routes.dart';
import 'package:vasu/app/themes/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vasu/features/authentication/controllers/language_selection_controller.dart';
import 'package:vasu/features/authentication/controllers/login_controller.dart';
import 'package:vasu/features/authentication/data/models/user_model_hive.dart';
import 'package:vasu/features/authentication/data/services/user_session_servive.dart';
import 'package:vasu/features/profile/controllers/settings_controller.dart';
import 'package:vasu/utils/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import for localization delegates
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<String>('historyMessages');
  String? at = await SecureStorage.getAccessToken();
  print("acc.toke=${at}");
  final SessionManager sessionManager = SessionManager();
  bool isLoggedIn = await sessionManager.isLoggedIn();

  // Check if the intro screen was shown previously
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isIntroShown = prefs.getBool('introShown') ?? false;

  // Initialize the language controller
  final LanguageSelectionController _languageController =
      Get.put(LanguageSelectionController());

  // Load and apply the saved language before running the app
  await _languageController.loadSavedLanguage();

  String initialRoute;

  if (!isIntroShown) {
    // If intro screen is not shown, show language selection
    initialRoute = '/language';
  } else if (isLoggedIn) {
    String? accessToken = await SecureStorage.getAccessToken();
    if (accessToken != null) {
      await LoginController().checkAndHandleTokenExpiration(accessToken);
    }
    initialRoute =
        '/bottom_navbar'; // If logged in, navigate to home  //change to bottom_navbar(anshika)
  } else {
    initialRoute =
        '/login'; // If not logged in, go to login screen  // change to login (anshika)
  }

  runApp(MyApp(
      initialRoute: initialRoute, languageController: _languageController));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  final LanguageSelectionController languageController;

  MyApp({required this.initialRoute, required this.languageController});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Initialize only LoginController globally
    Get.put(LoginController());

    return Obx(() => GetMaterialApp(
          initialBinding: BindingsBuilder(() {
            Get.put(SettingsController());
          }),
          debugShowCheckedModeBanner: false,
          title: 'vasu',

          // Localization Setup
          translations: AppTranslations(), // GetX localization handling

          // Use the saved locale from the language controller, with a fallback locale
          locale: languageController.getLocale(),

          fallbackLocale: const Locale('en', 'US'), // Fallback language

          // Routing Setup
          initialRoute: initialRoute,
          getPages: AppPages.routes,

          // Themes
          theme: AppTheme.lightTheme(screenWidth),
          darkTheme: AppTheme.darkTheme(screenWidth),
          themeMode: ThemeMode.system,

          // Localization delegates for Material, Cupertino, and Widgets
          localizationsDelegates: const [
            GlobalMaterialLocalizations
                .delegate, // Material components localization
            GlobalWidgetsLocalizations.delegate, // Widgets localization
            GlobalCupertinoLocalizations
                .delegate, // Cupertino components localization
          ],

          // Supported locales
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('hi', 'IN'),
            Locale('pa', 'IN'),
            Locale('bn', 'IN'),
            Locale('te', 'IN'),
            Locale('ta', 'IN'),
            Locale('kn', 'IN'),
            Locale('ml', 'IN'),
            Locale('gu', 'IN'),
            Locale('mr', 'IN'),
            Locale('ur', 'PK'),
          ],
        ));
  }
}
