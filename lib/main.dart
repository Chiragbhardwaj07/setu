import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import for localization delegates
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vasu/app/localization/app_translations.dart';
import 'package:vasu/app/routes/app_routes.dart';
import 'package:vasu/app/themes/app_themes.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Obx(() => GetMaterialApp(
          initialBinding: BindingsBuilder(() {}),
          debugShowCheckedModeBanner: false,
          title: 'Sanket',

          // Localization Setup
          translations: AppTranslations(), // GetX localization handling

          // Use the saved locale from the language controller, with a fallback locale
          locale: Locale('en', 'US'),

          fallbackLocale: const Locale('en', 'US'), // Fallback language

          // Routing Setup
          initialRoute: AppPages.initial,
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
